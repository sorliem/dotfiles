# dotfiles

Uses [GNU Stow](https://www.gnu.org/software/stow/) to manage symlinking to the
correct place on the file system.

## Fresh install

Repo must exist in the $HOME directory in order to install correctly. To do a
fresh install of all scripts:

```bash
./install
```

## Uninstall

```bash
./uninstall
```

## Individual stow/unstow

Sometimes it is useful to stow and unstow individual folders

```bash
cd $DOTFILES
stow -D nvim      # delete symlinks for all files in nvim/ folder
stow nvim         # make symlinks for all files in nvim/ folder
```

