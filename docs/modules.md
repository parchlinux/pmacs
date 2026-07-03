# Modules

pmacs groups its functionality into seven module categories. Each module lives
in a directory under `modules/` and contains two files: `packages.el`
declares the Emacs packages needed by that module, and `config.el` configures
them. The module system is straightforward — there is no complex DSL or
dependency resolution. Modules are loaded in alphabetical order during
startup.

## Completion

The completion module provides a modern minibuffer completion framework built
on Vertico, Orderless, Marginalia, Consult, and Embark. Vertico gives you a
vertical listing of completion candidates with a clean UI. Orderless allows
flexible matching where space-separated substrings are matched in any order.
Marginalia enriches completion candidates with annotations such as file
permissions, docstrings, and keybindings. Consult provides practical commands
that use the completing-read interface for tasks like searching lines in a
project, previewing buffers, and navigating Imenu. Embark gives you
contextual actions on completion candidates, and embark-consult bridges the
two.

## UI

The UI module handles visual appearance. It includes doom-themes for a set of
polished color themes, doom-modeline for a modern mode line, and nerd-icons
for icon support throughout the interface. The hl-todo package highlights
TODO, FIXME, and other keywords in source code. Diff-hl shows uncommitted
changes as colored indicators in the fringe. Which-key displays available
keybindings after pressing the leader key, making it easier to discover and
remember commands.

## Editor

The editor module provides the core editing experience. Evil gives you Vim
emulation with modal editing. Evil-collection extends Evil bindings to dozens
of Emacs modes so the keybinding style remains consistent. Evil-surround adds
text object surround operations like ys, cs, and ds. Evil-commentary provides
comment toggling with gc and gC. Undo-tree gives you a visual, branching undo
history. YASnippet and yasnippet-snippets provide template expansion with a
collection of useful snippets. WS-butler cleans trailing whitespace
automatically when saving. Hungry-delete lets you delete up to the next
non-whitespace character with a single press of backspace.

## Tools

The tools module includes developer-oriented packages. Magit provides a
complete Git interface with a staging area, commit workflow, and branch
management. Forge extends Magit with support for GitHub, GitLab, and other
forges, letting you view issues, pull requests, and notifications from within
Emacs. Helpful provides improved help buffers with better navigation, source
links, and documentation for Emacs Lisp functions and variables.

## Languages

The language module provides support for programming languages. It includes
major modes and tree-sitter integration where available. Language-specific
features are added as needed rather than all at once, keeping the module
lightweight and focused on the languages you actually use.

## Terminal

The terminal module provides VTerm, a full-featured terminal emulator that
runs inside Emacs. VTerm uses native module support to provide true terminal
behavior with full color, mouse support, and shell integration.

## Emacs

The Emacs module enhances built-in Emacs features. It configures Dired for a
better file manager experience, sets up TRAMP for remote file editing, and
improves the jump list and bookmark system.
