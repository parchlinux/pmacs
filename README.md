# pmacs

pmacs is an Emacs distribution for Parch Gnu/Linux. It provides a fast, simple,
and focused editing experience with Evil-mode keybindings, Parch system
integration, and a curated set of packages. Inspired by Doom Emacs but with a
simpler architecture and a tighter scope, pmacs aims to be the Emacs
configuration that feels right at home on Parch.

## What pmacs gives you

pmacs starts fast. By deferring garbage collection, disabling unnecessary
features during startup, and using lazy loading throughout, pmacs typically
loads in under a second. The performance work is invisible -- you just
experience an editor that opens quickly.

The keybinding system gives you both Evil and Emacs keybindings. Evil mode is
active by default with the space bar as the leader key, giving you Vim-style
modal editing across all supported modes. If you prefer Emacs keybindings,
press M-SPC e to toggle to Emacs state.

Parch integration means you can search and install pacman packages, query the
AUR, manage systemd services, and view journalctl logs without leaving the
editor. These features are available through the leader key menu and work with
the same completion interface you use for files and buffers.

The module system provides seven categories -- completion, UI, editor, tools,
languages, terminal, and Emacs enhancements -- each focused on a specific
area. The completion module uses Vertico, Orderless, Marginalia, Consult, and
Embark for a modern minibuffer experience. The editor module uses Evil,
Evil-collection, YASnippet, and Undo-tree. The tools module includes Magit
with Forge for Git integration.

The package list is documented in each module's `packages.el` file. You can
add your own packages by declaring them in `config.el` with the `package!`
macro and running `pmacs --sync`.

## Getting started

Install Emacs 28 or later from pacman, clone the repository to
`~/.config/pmacs/`, and run `~/.config/pmacs/bin/pmacs --sync` to install
packages. After synchronization, both `pmacs` and `emacs` will load pmacs.
Full installation instructions are in the documentation.

## Documentation

The docs directory contains detailed guides for installation, configuration,
modules, keybindings, and Parch integration. Start with the installation guide
and work through the topics that interest you.

## License

pmacs is licensed under the GNU General Public License v3.0 or later.
