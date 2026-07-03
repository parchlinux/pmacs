# Configuration

## Directory layout

pmacs stores its files across several directories following the XDG Base
Directory specification. The main installation lives at `~/.config/pmacs/`,
which contains the core Lisp files, modules, themes, and the launch script.
Your personal configuration goes in the same directory.

The default directory layout is:

    ~/.config/pmacs/
      bin/pmacs                  Launch script
      lisp/core.el               Core library files
      modules/                   Module definitions
      themes/                    Theme files
      static/                    Static support files
      snippets/                  YASnippet template files
      init.el                    Main initialization file
      early-init.el              Early initialization file
      config.el                  Your personal configuration (created on first run)
      custom.el                  Customize settings (managed by Emacs)

Persistent data, cache, and state files live in `~/.local/`:

    ~/.local/share/pmacs/        Snippets, persistent data
    ~/.local/cache/pmacs/        Byte-compiled files, recentf history
    ~/.local/state/pmacs/        Undo history, backups, auto-save files

## Your personal configuration

Your configuration file is `~/.config/pmacs/config.el`. pmacs creates this file
automatically the first time it starts, with a basic template. You can edit it
to change themes, fonts, keybindings, and add packages.

Here is an example configuration:

    (setq pmacs-theme 'doom-one)
    (setq pmacs-font "JetBrains Mono-14")
    (setq pmacs-variable-pitch-font "Noto Sans-13")
    (package! some-package :recipe (:host github :repo "user/repo"))

The `pmacs-theme` variable controls which theme loads at startup. Available
themes include `parch` (the default Catppuccin-inspired theme), `doom-one`,
`doom-vibrant`, and `modus-vivendi`. You can place custom theme files in
`~/.config/pmacs/themes/`.

The `pmacs-font` variable specifies the default monospace font. It should
be a font string like `"JetBrains Mono-14"` or `"Iosevka-13"`.

## Configuration loading order

pmacs loads configuration files in a specific order so that each layer can
override the previous one:

1. `early-init.el` — GC tuning, frame defaults, performance settings. This
   runs before the package system is initialized.
2. `pmacs.el` — Core path definitions and directory setup.
3. `pmacs-packages.el` — Package management with straight.el.
4. `pmacs-ui.el` — UI defaults: fonts, line numbers, modeline.
5. `pmacs-editor.el` — Editor defaults: indentation, undo, whitespace.
6. `pmacs-keybinds.el` — Evil keybindings and leader key setup.
7. `pmacs-parch.el` — Parch Gnu/Linux integration.
8. Module `packages.el` files — Package declarations for each module.
9. Module `config.el` files — Module-specific configuration.
10. Your `config.el` — User configuration, loaded last so it can override
    everything.

The `package!` macro is available to declare packages. When you add a new
package, you must run `pmacs --sync` to install it.

## Adding custom Lisp files

If you have custom Emacs Lisp files that you want to load, place them in
`~/.config/pmacs/lisp/` and add that directory to the load path in your
config.el:

    (add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
    (require 'my-library)

## Using Customize

pmacs sets the `custom-file` to `~/.config/pmacs/custom.el`. Settings you save
with `M-x customize` are written to this file. It is loaded automatically so
your customizations persist across restarts.
