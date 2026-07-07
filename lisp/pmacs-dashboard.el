;;; pmacs-dashboard.el --- startup welcome screen -*- lexical-binding: t; -*-

(defvar pmacs-dashboard-buffer-name "*pmacs*")

(defun pmacs-dashboard--time-greeting ()
  (let ((hour (string-to-number (format-time-string "%H"))))
    (cond ((< hour 12) "Good morning")
          ((< hour 17) "Good afternoon")
          (t "Good evening"))))

(defun pmacs-dashboard--insert-recent-files ()
  (when (and (boundp 'recentf-list) recentf-list)
    (insert "\n")
    (let ((files (cl-subseq recentf-list 0 (min 10 (length recentf-list)))))
      (dolist (f files)
        (insert (propertize (abbreviate-file-name f)
                            'face 'font-lock-keyword-face
                            'help-echo "Mouse-1: open this file"
                            'mouse-face 'highlight
                            'keymap (let ((map (make-sparse-keymap)))
                                      (define-key map [mouse-1]
                                        (lambda ()
                                          (interactive)
                                          (find-file f)))
                                      map))
                "\n")))))

(defun pmacs-dashboard--show ()
  (interactive)
  (let ((buf (get-buffer-create pmacs-dashboard-buffer-name)))
    (with-current-buffer buf
      (erase-buffer)
      (read-only-mode -1)
      (insert (pmacs-dashboard--time-greeting) ".\n\n")
      (when (and (boundp 'recentf-list) recentf-list)
        (insert "Recent files:\n")
        (pmacs-dashboard--insert-recent-files)
        (insert "\n"))
      (insert (format "System: %s %s\n" system-type (system-name))
              (format "Emacs: %s\n" emacs-version)
              (format "pmacs: %s" pmacs-version))
      (goto-char (point-min))
      (read-only-mode 1))
    (switch-to-buffer buf)))

(defun pmacs-dashboard--schedule ()
  (run-with-idle-timer 0.3 nil
    (lambda ()
      (unless (or (buffer-file-name)
                  (member (buffer-name) '("*scratch*" "*Messages*" "*straight-process*")))
        (pmacs-dashboard--show)))))

(provide 'pmacs-dashboard)
;;; pmacs-dashboard.el ends here
