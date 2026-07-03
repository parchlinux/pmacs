# Parch integration

pmacs is designed to work closely with Parch Gnu/Linux and its system tools.
The Parch module provides direct access to package management, system service
control, and log viewing from within Emacs.

## Searching and managing packages

The main entry point for package management is SPC p p, which searches the
pacman database. It prompts you for a search term and returns a list of
matching packages from both the official repositories and any repositories you
have configured in pacman. Each result shows the package name, version, and
description.

SPC p i shows detailed information about a specific package. It first checks
whether the package is installed and shows installed metadata if available.
For uninstalled packages, it queries the repository information. The output
includes dependencies, conflicts, package size, and a longer description.

SPC p k searches the Arch User Repository. It uses either yay or paru to
perform the search, whichever is available on your system. If neither is
installed, it falls back to querying the AUR RPC interface directly over
HTTP.

SPC p b builds a PKGBUILD in the current directory by running makepkg with
the sync and install flags. This is useful when you have downloaded a
PKGBUILD from the AUR or written one yourself.

## Managing system services

SPC s s lists all systemd units on the system. The list is filterable and
shows the unit name, load state, active state, and description. Selecting a
unit opens its status output.

## Viewing system logs

SPC s j shows recent journalctl log entries. This provides a quick way to
check system messages without leaving Emacs or switching to a terminal.

## Configuration

The Parch integration can be configured through variables set in your config.el
file. The `pmacs-aur-helper` variable controls which AUR helper is used when
searching the AUR. It defaults to auto-detecting yay or paru. Set it to your
preferred helper:

    (setq pmacs-aur-helper "paru")

The `pmacs-pacman-max-results` variable limits the number of results returned
by a pacman search. The default is 50.
