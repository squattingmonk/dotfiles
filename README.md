# Description
This repository contains configuration files for my local Linux rig. The dotfiles are managed by [GNU Stow](https://www.gnu.org/software/stow/).

# Installation
Clone the repository:

```bash
$ git clone https://github.com/squattingmonk/dotfiles
```

If you have [fish](https://fishshell.com) installed, run the install script:

```bash
 dotfiles/install
 ```

Otherwise, switch to the repository directory and manually stow the packages you wish to install:

```bash
$ cd dotfiles
$ stow bash
$ stow bspwm
$ stow fish
# etc...
```

Installation will not override any local files or symlinks. If you wish to override your local files, you must delete or move them first.
