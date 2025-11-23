# Vicodin

An opinionated minimalist nvim configuration that bundles nvim + plugins
to avoid deprecation/breaking. Vicodin takes the pain out of configuring 
nvim and is designed to be as batteries-included as possible

## Quick Start

On Linux:

```
git clone https://github.com/Aniruddha-Deb/vicodin ~/.local/share/vicodin
ln -s ~/.local/share/vicodin/run ~/.local/bin/vc
```

(assuming you use ~/.local, if not install wherever convenient)

and that's it! you can now edit files with `vc <filename>`.

## Out of the box configuration

- LSP with Autocomplete (blink.cmp)
- TreeSitter syntax highlighting
- Autoformatter (conform.nvim)
- Fuzzy Finder (fzf-lua, requires `fd`/`rg`/`fzf` installed)

## What still needs to be solved

- MacOS branch + binaries
- Overlaying configs in ~/.config/nvim 
- Bundling treesitter .so's

## Why Vicodin

I like stable tools that work. My setup broke one too many times after doing 
`:Lazy update`, and after going down the deep dark rabbit hole of dependency
management I decided to vendor everything. It works: the folder takes ~100MB
on disk if you exclude the `.git` folder. It still retains configurability.
If you want a batteries-included nvim that doesn't break and can be packaged/
installed easily without fiddling with mason/lazy this is made for that usecase.

## License

Vicodin is released under the MIT license.

Vicodin uses external plugins under the `externals/` folder, and also vendors
the `nvim` binary. These plugins/binaries have external licenses of their own,
and may not fall under the license of this repository.
