;;; pmacs-parch.el --- Parch Gnu/Linux integration -*- lexical-binding: t; -*-
;;; Commentary:
;; Pacman, AUR, systemctl, and journalctl integration.
;;; Code:

(require 'pmacs)
(require 'pmacs-lib)

(defvar pmacs-parch-p (eq system-type 'gnu/linux)
  "Non-nil when running on Parch or Arch-based Linux.")

(defvar pmacs-parch-package-manager "pacman"
  "Default package manager command.")

(defvar pmacs-parch-aur-helper
  (cond
   ((executable-find "paru") "paru")
   ((executable-find "yay") "yay")
   ((executable-find "pamac") "pamac")
   (t nil))
  "Detected AUR helper, or nil if none found.")

(defun pmacs/pacman-search (query)
  "Search for QUERY in the pacman package database."
  (interactive "sSearch pacman: ")
  (let ((buffer (get-buffer-create "*pacman-search*")))
    (with-current-buffer buffer
      (erase-buffer)
      (call-process "pacman" nil buffer t "-Ss" query)
      (goto-char (point-min))
      (special-mode))
    (display-buffer buffer)))

(defun pmacs/pacman-info (package)
  "Display information about PACKAGE."
  (interactive "sPackage name: ")
  (let ((buffer (get-buffer-create "*pacman-info*")))
    (with-current-buffer buffer
      (erase-buffer)
      (call-process "pacman" nil buffer t "-Si" package)
      (goto-char (point-min))
      (special-mode))
    (display-buffer buffer)))

(defun pmacs/pacman-installed-p (package)
  "Return non-nil if PACKAGE is installed."
  (= 0 (call-process "pacman" nil nil nil "-Qi" package)))

(defun pmacs/pacman-list-orphans ()
  "List orphaned packages."
  (interactive)
  (let ((buffer (get-buffer-create "*pacman-orphans*")))
    (with-current-buffer buffer
      (erase-buffer)
      (call-process "pacman" nil buffer t "-Qtdq")
      (goto-char (point-min))
      (special-mode))
    (display-buffer buffer)))

(defun pmacs/pacman-list-explicit ()
  "List explicitly installed packages."
  (interactive)
  (let ((buffer (get-buffer-create "*pacman-explicit*")))
    (with-current-buffer buffer
      (erase-buffer)
      (call-process "pacman" nil buffer t "-Qe")
      (goto-char (point-min))
      (special-mode))
    (display-buffer buffer)))

(defun pmacs/aur-search (query)
  "Search for QUERY in the AUR."
  (interactive "sSearch AUR: ")
  (if pmacs-parch-aur-helper
      (let ((buffer (get-buffer-create "*aur-search*")))
        (with-current-buffer buffer
          (erase-buffer)
          (call-process pmacs-parch-aur-helper nil buffer t "-Ss" query)
          (goto-char (point-min))
          (special-mode))
        (display-buffer buffer))
    (message "pmacs: no AUR helper found")))

(defun pmacs/aur-install (package)
  "Install PACKAGE from the AUR."
  (interactive "sAUR package: ")
  (if pmacs-parch-aur-helper
      (compile (format "%s -S %s" pmacs-parch-aur-helper package))
    (message "pmacs: no AUR helper found")))

(defun pmacs/system-info ()
  "Display system information."
  (interactive)
  (let ((info (concat "OS: "
                      (if (file-exists-p "/etc/os-release")
                          (with-temp-buffer
                            (insert-file-contents "/etc/os-release")
                            (goto-char (point-min))
                            (if (re-search-forward "^PRETTY_NAME=\"\\(.*\\)\"" nil t)
                                (match-string 1)
                              (system-name)))
                        (system-name))
                      "\nKernel: " (string-trim (shell-command-to-string "uname -r"))
                      "\nUptime: " (string-trim (shell-command-to-string "uptime -p"))
                      "\nPackages: "
                      (if (executable-find "pacman")
                          (format "%d (pacman)"
                                  (length (split-string
                                           (shell-command-to-string "pacman -Q"))))
                        "unknown")
                      "\nShell: " (or (getenv "SHELL") "unknown")
                      "\nEmacs: " emacs-version)))
    (message "%s" info)))

(defun pmacs/systemctl-list-units ()
  "List active systemd units."
  (interactive)
  (let ((buffer (get-buffer-create "*systemd-units*")))
    (with-current-buffer buffer
      (erase-buffer)
      (call-process "systemctl" nil buffer t "list-units" "--type=service")
      (goto-char (point-min))
      (special-mode))
    (display-buffer buffer)))

(defun pmacs/systemctl-status (service)
  "Display the status of SERVICE."
  (interactive "sService name: ")
  (let ((buffer (get-buffer-create "*systemd-status*")))
    (with-current-buffer buffer
      (erase-buffer)
      (call-process "systemctl" nil buffer t "status" service)
      (goto-char (point-min))
      (special-mode))
    (display-buffer buffer)))

(defun pmacs/journalctl ()
  "View recent systemd journal entries."
  (interactive)
  (let ((buffer (get-buffer-create "*journalctl*")))
    (with-current-buffer buffer
      (erase-buffer)
      (call-process "journalctl" nil buffer t "-n" "100" "--no-pager")
      (goto-char (point-min))
      (special-mode))
    (display-buffer buffer)))

(defun pmacs/copy-to-system-clipboard (text &optional _push)
  "Copy TEXT to the system clipboard using xclip or xsel."
  (when (and text (not (string-empty-p text)))
    (let ((proc (cond
                 ((executable-find "xclip")
                  (start-process "xclip" nil "xclip" "-selection" "clipboard"))
                 ((executable-find "xsel")
                  (start-process "xsel" nil "xsel" "--clipboard" "--input"))
                 (t nil))))
      (when proc
        (process-send-string proc text)
        (process-send-eof proc)))))

(setq interprogram-cut-function #'pmacs/copy-to-system-clipboard
      compilation-always-kill t
      compilation-scroll-output 'first-error
      tramp-default-method "ssh"
      tramp-auto-save-directory (expand-file-name "auto-save" (expand-file-name "tramp" pmacs-state-dir)))

(defun pmacs-init-parch-keybinds ()
  "Initialize Parch-specific keybindings."
  (when (fboundp 'evil-define-key)
    (evil-define-key 'normal 'global
      (kbd "SPC p p") #'pmacs/pacman-search
      (kbd "SPC p i") #'pmacs/pacman-info
      (kbd "SPC p o") #'pmacs/pacman-list-orphans
      (kbd "SPC p e") #'pmacs/pacman-list-explicit
      (kbd "SPC p k") #'pmacs/aur-search
      (kbd "SPC p K") #'pmacs/aur-install
      (kbd "SPC s u") #'pmacs/systemctl-list-units
      (kbd "SPC s S") #'pmacs/systemctl-status
      (kbd "SPC s j") #'pmacs/journalctl
      (kbd "SPC s i") #'pmacs/system-info)))

(provide 'pmacs-parch)
;;; pmacs-parch.el ends here
