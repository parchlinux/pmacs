;;; pmacs-keybinds.el --- pmacs keybinding configuration -*- lexical-binding: t; -*-

(require 'pmacs)
(require 'pmacs-lib)

(defvar pmacs-leader-key "SPC")

(defun pmacs-init-evil ()
  (when (require 'evil nil t)
    (evil-mode 1)
    (when (require 'evil-collection nil t)
      (evil-collection-init))))

(defun pmacs-init-leader ()
  (when (fboundp 'evil-set-leader)
    (evil-set-leader 'normal (kbd pmacs-leader-key))
    (evil-set-leader 'visual (kbd pmacs-leader-key))
    (evil-define-key 'normal 'global
      (kbd "SPC f f") #'find-file
      (kbd "SPC f s") #'save-buffer
      (kbd "SPC b b") #'switch-to-buffer
      (kbd "SPC g g") #'magit-status)))

(defun pmacs-init-keybinds ()
  (pmacs-init-evil)
  (pmacs-init-leader))

(provide 'pmacs-keybinds)
;;; pmacs-keybinds.el ends here
