# dotfiles

Uses [GNU Stow](https://www.gnu.org/software/stow/) to manage symlinking to the
correct place on the file system.

## Install

Repo must exist in the $HOME directory to install. To do a fresh install of all scripts:

```bash
./install
```

## Uninstall

```bash
./uninstall
```

## Individual stow/unstow

To stow and unstow individual folders

```bash
cd $DOTFILES
stow -D nvim      # delete symlinks for all files in nvim/ folder
stow nvim         # make symlinks for all files in nvim/ folder
```
