# Peroyhav's Dotfiles
## How to "install"

### Windows
``` cmd
C:\> cd %USERPROFILE%
%USERPROFILE% > mklink .gitconfig <dotfiles dir>\.gitconfig
%USERPROFILE% > mklink .bashrc <dotfiles dir>\.bashrc
%USERPROFILE% > mklink .profile <dotfiles dir>\.profile
%USERPROFILE% > mklink .bash_logout <dotfiles dir>\.bash_logout
%USERPROFILE% > cd %LOCALAPPDATA%
%LOCALAPPDATA% > mklink /J nvim <dotfiles dir>\nvim
```

### Linux
I've made a script for linux, as thats where I primarily will be likelly to recreate my install.
``` bash
<dotfiles dir> $ ./setup.sh
```

### Install tmux
1. Install tmux using your desired package manager
1. Download and install plugin manager
``` bash
$ git clone --depth 1 https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
$ cd
$ tmux new -s home # I usually name session 0 home, and add new sessions for each thing I work with so they're numbered 1 .. n
$ <C-b>I
```
