# Installation

## Prerequisites

pmacs requires Emacs 28 or later. On Parch Gnu/Linux, you can install it with
pacman:

    sudo pacman -S emacs

If you only need terminal editing, the `emacs-nox` package provides Emacs
without X11 or GTK dependencies:

    sudo pacman -S emacs-nox

You will also need git and make (optional, for native compilation):

    sudo pacman -S git make

## Getting pmacs

Clone the repository into the standard XDG configuration directory:

    git clone https://github.com/parchlinux/pmacs ~/.config/pmacs

This creates the directory `~/.config/pmacs/` with all the files needed to run
pmacs. The rest of this guide assumes pmacs is installed at that location.

If you prefer a different location, set the `PMACSDIR` environment variable to
point to it. For example:

    export PMACSDIR="$HOME/path/to/pmacs"

## Setting up packages

The first time you run pmacs, you need to synchronize the package list. This
installs all the Emacs packages that pmacs depends on:

    ~/.config/pmacs/bin/pmacs --sync

This command does two things. First, it starts Emacs in batch mode and installs
every package declared by the pmacs modules using the straight.el package
manager. Second, it installs a small loader script at `~/.emacs.d/init.el`
so that running plain `emacs` will also load pmacs.

During the synchronization, straight.el bootstraps itself by cloning its
repository, then fetches and builds each package. This can take a few minutes
on the first run. Subsequent syncs are much faster because only new or updated
packages are processed.

## Starting pmacs

Once packages are installed, start pmacs with:

    ~/.config/pmacs/bin/pmacs

Or run plain `emacs` -- the loader script at `~/.emacs.d/init.el` ensures
pmacs loads automatically:

    emacs

For terminal-only use, pass the `-nw` flag:

    pmacs -nw

Or equivalently:

    emacs -nw

## Making pmacs available globally

To be able to run `pmacs` from anywhere, add the pmacs bin directory to your
shell's PATH. In `~/.bashrc` or `~/.zshrc`, add:

    export PATH="$HOME/.config/pmacs/bin:$PATH"

After reloading your shell configuration, you can run `pmacs` from any
directory:

    pmacs

## Updating packages

To update all installed packages to their latest versions:

    pmacs --upgrade

This runs the sync process and also pulls the latest pmacs source from the git
repository.

## Running diagnostics

If something is not working correctly, run the doctor:

    pmacs --doctor

This checks the Emacs installation, verifies that pmacs can find its files,
and reports any obvious problems.

## Installing nerd-icons fonts

pmacs uses the nerd-icons package to display icons in the modeline, in
file listings, and in various other UI elements. If you see symbols or boxes
where icons should be, the nerd-icons fonts are not installed. Inside pmacs,
run:

    M-x pmacs-install-nerd-icons-fonts

This downloads and installs the font files to your system. After a restart,
icons should display correctly.
