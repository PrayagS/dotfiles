## Shell
- Check out [zsh4humans](https://github.com/romkatv/zsh4humans).

### The state of zinit
[zinit](https://github.com/zdharma-continuum/zinit) in its current state is on
life support. The original maintainer (zdharma / psprint / Sebastian) had
abandoned the project multiple times and has since passed away. While his
ways of maintaining the project were questionable, the work he did significantly
changed the state of zsh plugins. zinit was written years ago has features that
even some OS package managers can fall short of.

Since the project is on life support, the following alternatives can
be explored,
- [zimfw](https://github.com/zimfw/zimfw)
- [zcomet](https://github.com/agkozak/zcomet)
- CLI tools managers like [Aqua](https://github.com/aquaproj/aqua), [Sheldon](https://github.com/rossmacarthur/sheldon).
- Nix

That said, zinit hasn't given me any problems since I started using it and it's
probably a good idea to stay put unless the newer managers innovate
significantly.

## neovim

- Configure diagnostics.
- https://github.com/rockerBOO/awesome-neovim#editing-support
- https://github.com/rockerBOO/awesome-neovim#lsp
- folke/trouble.nvim
- hedyhli/outline.nvim
- https://github.com/hedyhli/outline.nvim#related-plugins
- configure diagnostics support in UI plugins like bufferline.
- utilyre/barbecue.nvim
- Bekaboo/dropbar.nvim
- ray-x/lsp_signature.nvim / https://nvimdev.github.io/lspsaga/
- ray-x/navigator.lua
- Wansmer/treesj
- cshuaimin/ssr.nvim
- ggandor/leap-spooky.nvim // rasulomaroff/telepath.nvim // folke/flash.nvim
- nvim-telescope/telescope-ui-select.nvim
- folke/todo-comments.nvim
- pwntester/octo.nvim
- epwalsh/obsidian.nvim
- Explore treesitter text objects or text objects in general
- ~~fidget.nvim~~
- ~~Set keymaps for gitsigns actions.~~
- ~~Use `opts` instead of one liner require statements.~~
- ~~Figure out a way to preserve cursor position in the autocmd for cleaning whitespace/trailing empty lines.~~ [Commit](https://github.com/PrayagS/dotfiles/commit/3e1e94c220f675fc0f9b2bf070a6d3828fbbf174)
- ~~Configure repeatable leap motions.~~ [Commit](https://github.com/PrayagS/dotfiles/commit/45f104000034ef84b29b0d26a7c45ae92414e03f)
- ~~LSP~~
- ~~Set `version` for all plugins.~~
