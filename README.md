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
~$ mkdir -p .config
~$ cd .config
~$ ln -s <dotfiles dir>/nvim
```
