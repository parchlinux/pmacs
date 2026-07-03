# Contributing

Contributions to pmacs are welcome. The project follows a straightforward set
of conventions to keep the codebase consistent and maintainable.

## Getting started

Clone the repository and make your changes in a feature branch. Test your
changes before submitting by running `pmacs --doctor` and by starting Emacs
with your modified code to check for errors or unexpected behavior.

## Coding standards

All Emacs Lisp files should specify `lexical-binding: t` in the file header.
Follow standard Emacs Lisp naming conventions: functions and variables use
kebab-case, with the `pmacs-` prefix for public symbols and `pmacs--` for
internal ones. Library functions from CL can be used but should be called with
the `cl-` prefix.

Comments should be professional and useful. Do not add decorative comment
separators or emojis to any file. A comment should explain why something is
done a certain way, not restate what the code already says.

## Module development

Each module needs exactly two files: `packages.el` and `config.el`. The
packages file declares the Emacs packages the module needs using the
`package!` macro. The config file configures those packages and sets up
hooks and keybindings.

Module names should be lowercase with hyphens separating words. Keep modules
focused on a single area of functionality. If you find yourself configuring
things from three different domains in one module, split it up.

## Testing

Run `pmacs --doctor` before submitting to check for configuration issues. For
batch testing, start Emacs with the `--batch` flag and load the init file:

    emacs --batch -l ~/.config/pmacs/init.el

This loads pmacs without creating a frame and reports any errors during
loading. You can add `--eval` expressions to test specific functions.

Make sure your changes do not produce byte-compilation warnings. You can
byte-compile individual files with `M-x byte-compile-file` or check the
`*Warnings*` buffer after a full startup.

## Pull request guidelines

Each pull request should address a single feature or bug fix. Rebase your
branch on the current main branch before opening the request. Include updates
to the relevant documentation when adding or changing functionality. If you
add a new dependency to a module, update the module's `packages.el` file and
mention the dependency in the documentation.
