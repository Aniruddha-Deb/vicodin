#!/usr/bin/env python3
from __future__ import annotations

from dataclasses import dataclass
from pathlib import Path
import subprocess
import argparse
import sys


@dataclass
class Plugin:
    name: str      # remote name AND folder name under externals/
    url: str       # git URL
    branch: str    # upstream branch to track (usually "main" or "master")
    pack: str      # "start" or "opt" (pack/plugins/{pack}/name)


PLUGINS: list[Plugin] = [
    Plugin("conform.nvim",       "https://github.com/stevearc/conform.nvim",           "master",   "start"),
    Plugin("fzf-lua",            "https://github.com/ibhagwan/fzf-lua",                "main",     "start"),
    Plugin("gitsigns.nvim",      "https://github.com/lewis6991/gitsigns.nvim",         "main",     "start"),
    Plugin("lualine.nvim",       "https://github.com/nvim-lualine/lualine.nvim",       "master",   "start"),
    Plugin("LuaSnip",            "https://github.com/L3MON4D3/LuaSnip",                "master",   "start"),
    Plugin("mini.nvim",          "https://github.com/nvim-mini/mini.nvim",             "main",     "start"),
    Plugin("nvim-lspconfig",     "https://github.com/neovim/nvim-lspconfig",           "master",   "start"),
    Plugin("nvim-treesitter",    "https://github.com/nvim-treesitter/nvim-treesitter", "main",     "start"),
    Plugin("vim-sleuth",         "https://github.com/tpope/vim-sleuth",                "master",   "start"),
    Plugin("which-key.nvim",     "https://github.com/folke/which-key.nvim",            "main",     "start"),
    Plugin("nvim-web-devicons",  "https://github.com/nvim-tree/nvim-web-devicons",     "master",   "start"),
    Plugin("monokai-pro.nvim",   "https://github.com/loctvl842/monokai-pro.nvim",      "master",   "start"),
]


EXTERNALS_DIR = Path("externals")
PACK_ROOT = Path("share/vicodin/site/pack/plugins")  # {start,opt}/<name>


def run(*args: str) -> None:
    print("+", " ".join(args))
    subprocess.check_call(args)


def get_remotes() -> set[str]:
    out = subprocess.check_output(["git", "remote"], text=True)
    return {r for r in out.split() if r}


def ensure_git_repo() -> None:
    subprocess.check_call(
        ["git", "rev-parse", "--is-inside-work-tree"],
        stdout=subprocess.DEVNULL,
        stderr=subprocess.DEVNULL,
    )


def ensure_dirs() -> None:
    EXTERNALS_DIR.mkdir(exist_ok=True)
    # Create pack/{start,opt} roots
    for kind in ("start", "opt"):
        (PACK_ROOT / kind).mkdir(parents=True, exist_ok=True)


def add_and_fetch_remotes(remotes: set[str], pull: bool) -> None:
    for p in PLUGINS:
        if p.name not in remotes:
            run("git", "remote", "add", p.name, p.url)
            run("git", "fetch", p.name)
        elif pull:
            run("git", "fetch", p.name)


def update_or_add_subtrees(pull_updates: bool) -> None:
    for p in PLUGINS:
        prefix = EXTERNALS_DIR / p.name

        if prefix.exists():
            if not pull_updates:
                print(f"= {p.name} exists; skipping update (--pull not passed)")
                continue

            run("git", "subtree", "pull",
                f"--prefix={prefix}",
                p.name, p.branch,
                "--squash")
        else:
            run("git", "subtree", "add",
                f"--prefix={prefix}",
                p.name, p.branch,
                "--squash")



def ensure_symlink(src: Path, dest: Path) -> None:
    """
    Ensure dest is a symlink pointing to src (absolute).
    If dest exists but is wrong, replace it.
    """
    src = src.resolve()

    if dest.is_symlink():
        target = dest.resolve()
        if target == src:
            # Already correct
            return
        dest.unlink()

    elif dest.exists():
        # Directory or regular file – nuke and replace
        if dest.is_dir():
            # Be explicit & safe-ish: require empty dir to avoid surprises
            try:
                next(dest.iterdir())
            except StopIteration:
                dest.rmdir()
            else:
                print(f"! {dest} exists and is non-empty; refusing to overwrite", file=sys.stderr)
                return
        else:
            dest.unlink()

    dest.symlink_to(src)
    print(f"+ symlink {dest} -> {src}")


def link_plugins() -> None:
    for p in PLUGINS:
        if p.pack not in ("start", "opt"):
            raise ValueError(f"Invalid pack type {p.pack!r} for plugin {p.name}")

        source = EXTERNALS_DIR / p.name
        if not source.exists():
            print(f"! externals/{p.name} does not exist yet; skipping link", file=sys.stderr)
            continue

        dest = PACK_ROOT / p.pack / p.name
        ensure_symlink(source, dest)


def main() -> None:

    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--pull",
        action="store_true",
        help="Update existing vendored dependencies (default: off)",
    )
    args = parser.parse_args()

    ensure_git_repo()
    ensure_dirs()

    remotes = get_remotes()
    add_and_fetch_remotes(remotes, args.pull)
    update_or_add_subtrees(args.pull)
    link_plugins()


if __name__ == "__main__":
    main()

