# Let the ricing begin!

Welcome to my dotfiles! Huge credits to folks over at [r/unixporn](https://www.reddit.com/r/unixporn/). Not quite an original rice but bits and pieces joined together from different places.

## Overview

- Terminal - [st](https://github.com/PrayagS/st) (my build) and colors can be found in .Xresources
- Shell - [zsh](http://zsh.sourceforge.net/). Along with [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) as the plugin manager
- Shell prompt - [powerlevel10k](https://github.com/romkatv/powerlevel10k). A faster drop-in replacement of powerlevel9k. Its config can be found in .p10k.zsh
- WM - [i3-gaps](https://github.com/Airblader/i3). Fork of i3 (a tiling window manager) enabling gaps between windows
- Status Bar - [polybar](https://github.com/polybar/polybar). Easily configurable status bar
- Launcher - [rofi](https://github.com/davatorium/rofi). For those who find dmenu ancient
- Others - [dunst](https://dunst-project.org/) for notifications, [sxhkd](https://github.com/baskerville/sxhkd) for keyboard hotkeys and [compton](https://github.com/tryone144/compton) (tryone's fork) for transparency effects.

## TODO

- [ ] Add oh-my-zsh (probably as a submodule).
- [ ] Write a script to setup LaTeX environment. Notes [here](notes/Reinstalling LaTeX.md).
- [ ] Use [this](https://github.com/sobolevn/dotbot-pip) or just shell commands to install pip stuff
- [ ] Use [this](https://github.com/oxson/dotbot-yay) or just shell commands paired with the pacmanity [gist](https://gist.github.com/PrayagS/4a2f5dcb9b09be0bd6649c6a194560ac) to install packages.
- [ ] Use [this](https://github.com/alexcormier/dotbot-rust) or shell commands to install rust packages.
- [ ] Setup CI with [Travis](https://travis-ci.com/getting_started) or [GitHub Actions](https://github.com/features/actions) to test the install script.
