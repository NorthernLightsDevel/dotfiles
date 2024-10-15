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
``` bash
$ cd ~
~$ ln -s <dotfiles dir>/.gitconfig
~$ ln -s <dotfiles dir>/.bashrc
~$ ln -s <dotfiles dir>/.profile
~$ ln -s <dotfiles dir>/.tmux.conf
~$ mkdir -p .config
~$ cd .config
~$ ln -s <dotfiles dir>/nvim
```

### Install tmux
1. Install tmux using your desired package manager
1. Download and install plugins
``` bash
$ git clone --depth 1 https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
$ cd <dotfiles git dir>
$ tmux new -s dotfiles
$ <C-a>I
```
