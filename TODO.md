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

#### As of Jan 2025

Finally bit the bullet and migrated from zinit to [antidote](https://antidote.sh).

Reasons,
- Completions not loading consistently.
- Simplifying tool management using mise
- Overall config has also became very simple now that we're not using ice modifiers from zinit. The only modifier I'd miss is the patch modifier. Though antidote has support for pre- and post-install scripts.

Shell startup time after migration is the same.

Alternatives considered,
- [znap](https://github.com/marlonrichert/zsh-snap)
  - Lot of the features didn't stand out to me. Faster eval is cool which I
  have replicated using plugins.
- [zimfw](https://github.com/zimfw/zimfw)
  - Probably the fastest out of the bunch since the author spent time optimizing
  it based on zsh-bench results. Actively maintained as well. antidote just felt
  more simpler IMO while still giving the same benchmark results.

I have moved all zinit configuration to an [archive folder](archive/zsh/zinit)
for anyone's reference.

## neovim

- Configure diagnostics.
- configure diagnostics support in UI plugins like bufferline.
- Explore treesitter text objects or text objects in general
- Configure telescope-frecency to filter by workspace or a set of workspaces.
- ~~Wansmer/treesj~~
- ~~cshuaimin/ssr.nvim~~
- ~~ray-x/lsp_signature.nvim~~
- ~~folke/trouble.nvim~~
- ~~https://github.com/hedyhli/outline.nvim#related-plugins~~
- ~~Bekaboo/dropbar.nvim~~
- ~~ggandor/leap-spooky.nvim // rasulomaroff/telepath.nvim // folke/flash.nvim~~
- ~~folke/todo-comments.nvim~~
- ~~pwntester/octo.nvim~~
- ~~fidget.nvim~~
- ~~Set keymaps for gitsigns actions.~~
- ~~Use `opts` instead of one liner require statements.~~
- ~~Figure out a way to preserve cursor position in the autocmd for cleaning whitespace/trailing empty lines.~~ [Commit](https://github.com/PrayagS/dotfiles/commit/3e1e94c220f675fc0f9b2bf070a6d3828fbbf174)
- ~~Configure repeatable leap motions.~~ [Commit](https://github.com/PrayagS/dotfiles/commit/45f104000034ef84b29b0d26a7c45ae92414e03f)
- ~~LSP~~
- ~~Set `version` for all plugins.~~
