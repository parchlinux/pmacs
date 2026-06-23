;;; pmacs-lib.el --- pmacs standard library -*- lexical-binding: t; -*-
;;; Commentary:
;; Core utility macros used throughout pmacs.
;;; Code:

(require 'cl-lib)
(require 'subr-x)

(unless (fboundp 'ensure-list)
  (defun ensure-list (object)
    "Return OBJECT as a list."
    (declare (pure t) (side-effect-free t))
    (if (listp object) object (list object))))

(unless (fboundp 'always)
  (defun always (&rest _args) t))

(unless (fboundp 'file-name-concat)
  (defun file-name-concat (directory &rest components)
    "Append COMPONENTS to DIRECTORY."
    (mapconcat #'identity
               (cl-loop for str in (cons directory components)
                        if (and str (not (string-empty-p str))
                                (if (string-suffix-p "/" str)
                                    (substring str 0 -1)
                                  str))
                        collect it)
               "/")))

(unless (fboundp 'string-blank-p)
  (defun string-blank-p (string)
    "Return non-nil if STRING is empty or whitespace-only."
    (string-match-p "\\`[ \t\n\r]*\\'" string)))

(defvar pmacs--log-level 0
  "Logging verbosity. 0 = warnings only, 1 = info, 2 = debug.")

(defmacro pmacs-log (level &rest args)
  "Log a message at LEVEL if `pmacs--log-level' is sufficient."
  (declare (indent 1))
  `(when (>= pmacs--log-level ,level)
     (message "(pmacs) %s" (format ,@args))))

(defmacro file! ()
  "Expand to the path of the current file."
  (or (and load-in-progress (car load-file-name))
      (and (boundp 'buffer-file-name) buffer-file-name)
      (error "file! called outside a file context")))

(defmacro dir! ()
  "Expand to the directory of the current file."
  `(directory-name-directory (file!)))

(defmacro load! (file &optional relative-path noerror)
  "Load FILE relative to the current file."
  (let ((path (if relative-path
                  `(expand-file-name ,file ,relative-path)
                `(expand-file-name ,file (dir!)))))
    `(load ,path nil ,(or noerror t))))

(defmacro after! (feature &rest body)
  "Execute BODY after FEATURE is loaded."
  (declare (indent 1) (debug t))
  (cond
   ((and (symbolp feature) (not (keywordp feature)))
    `(eval-after-load ',feature
       (lambda () ,@body)))
   ((eq (car feature) :or)
    `(progn
       ,@(cl-loop for feat in (cdr feature)
                  collect `(eval-after-load ',feat
                             (lambda () ,@body)))))
   ((eq (car feature) :and)
    (if (null (cddr feature))
        `(eval-after-load ',(cadr feature)
           (lambda ()
             (eval-after-load ',(caddr feature)
               (lambda () ,@body))))
      `(eval-after-load ',(cadr feature)
         (after! (:and ,@(cddr feature)) ,@body))))
   ((listp feature)
    `(after! (:or ,@feature) ,@body))
   (t
    (error "Invalid after! form: %s" (list 'after! feature body)))))

(defmacro cmd! (&rest body)
  "Create an anonymous interactive command from BODY."
  `(lambda () (interactive) ,@body))

(defmacro cmds! (&rest defs)
  "Define multiple named interactive commands."
  `(progn
     ,@(cl-loop for (name . body) in defs
                collect `(defun ,name () (interactive) ,@body))))

(defmacro quiet! (&rest body)
  "Execute BODY without producing any output."
  (declare (indent 0))
  `(let ((inhibit-message t)
         (message-log-max nil))
     (with-temp-buffer
       ,@body)))

(provide 'pmacs-lib)
;;; pmacs-lib.el ends here
