# Keybindings

pmacs provides both Evil (Vim-style) and Emacs keybindings. Evil mode is
enabled by default, with the space bar set as the leader key. You can toggle
between Evil and Emacs states by pressing M-SPC e.

## The leader key

The leader key is SPC (space bar). In Evil normal state, pressing SPC starts
a key sequence that gives you access to most pmacs commands. After pressing
SPC, you have a moment to press the next key. If you press SPC ? instead of
a second key, which-key shows all available bindings.

## File operations

- SPC f f finds a file using Consult's file completion, with preview and
  smart filtering based on your project root.
- SPC f r opens the recent files list, letting you quickly jump to files you
  have edited recently.
- SPC f s saves the current buffer. SPC f S saves all modified buffers at
  once.
- SPC f e opens your pmacs configuration file for editing.

## Buffer management

- SPC b b switches buffers with a live preview of each buffer's content.
- SPC b d kills the current buffer. SPC b D kills all other buffers except
  the current one.
- SPC b h opens the pmacs welcome dashboard.

## Window management

- SPC w h, j, k, l move focus to the window in that direction.
- SPC w v splits the current window vertically. SPC w s splits it
  horizontally.
- SPC w c closes the current window. SPC w m maximizes it.
- SPC w = balances the widths of all windows in the frame.

## Git operations

- SPC g g opens Magit status for the current repository.
- SPC g l shows the Magit log. SPC g d shows the Magit diff.
- SPC g b runs Magit blame on the current file.
- SPC g f fetches from all remotes.

## Search and navigation

- SPC s s searches the current buffer line by line with live preview.
- SPC s p searches across all files in the current project.
- SPC s d searches files in a specific directory.
- SPC s g runs grep across the project.
- SPC s r resumes the last search.

## Toggles

- SPC t l toggles line numbers on and off.
- SPC t t cycles through available themes.
- SPC t f toggles fullscreen mode for the current frame.

## Help

- SPC h opens the help menu. SPC h f looks up documentation for a function.
- SPC h v looks up documentation for a variable.
- SPC h k shows what command a keybinding runs.

## Parch integration

- SPC p p searches pacman packages by name.
- SPC p i shows detailed information about a package.
- SPC p k searches the Arch User Repository.
- SPC p b builds a PKGBUILD in the current directory.
- SPC s s lists systemd units on the system.
- SPC s j shows recent journalctl log entries.

## Emacs mode keybindings

When Emacs state is active (not Evil), standard Emacs keybindings are
available:

- C-x C-f finds a file. C-x C-s saves the current buffer.
- C-x b switches buffers. C-x k kills the current buffer.
- C-x 2 splits horizontally. C-x 3 splits vertically. C-x o moves to the
  other window.
- C-c g opens Magit status. C-c p p searches pacman packages.
