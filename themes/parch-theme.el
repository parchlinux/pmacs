;;; parch-theme.el --- A dark theme for pmacs -*- lexical-binding: t; -*-

;; This file is not part of GNU Emacs.

;;; Commentary:

;; Parch - a dark color theme for pmacs. Designed for comfortable long
;; coding sessions with carefully chosen contrast ratios and a cohesive
;; color palette inspired by modern terminal aesthetics.

;;; Code:

(deftheme parch
  "A dark theme for pmacs.")

;; ---------------------------------------------------------------------------
;; Color palette
;; ---------------------------------------------------------------------------

(let* ((class '((class color) (min-colors 89)))

       ;; Background colors (darkest to lightest)
       (bg-dim      "#11111b")
       (bg-base     "#1e1e2e")
       (bg-surface  "#242438")
       (bg-overlay  "#313244")
       (bg-muted    "#45475a")

       ;; Foreground colors (brightest to dimmest)
       (fg-bright   "#f5f5f5")
       (fg-default  "#cdd6f4")
       (fg-dim      "#bac2de")
       (fg-muted    "#a6adc8")

       ;; Accent colors
       (red         "#f38ba8")
       (red-dim     "#eba0ac")
       (green       "#a6e3a1")
       (green-dim   "#94e2d5")
       (yellow      "#f9e2af")
       (yellow-dim  "#fab387")
       (blue        "#89b4fa")
       (blue-dim    "#74c7ec")
       (magenta     "#cba6f7")
       (magenta-dim "#b4befe")
       (cyan        "#94e2d5")
       (cyan-dim    "#89dceb")
       (peach       "#fab387")
       (rosewater   "#f5e0dc")

       ;; Semantic colors
       (success     green)
       (warning     yellow)
       (error       red)
       (info        blue)

       ;; UI colors
       (border      bg-muted)
       (highlight   bg-overlay)
       (selection   blue))

  ;; ---------------------------------------------------------------------------
  ;; Theme faces
  ;; ---------------------------------------------------------------------------

  (custom-theme-set-faces
   'parch

   ;; Base faces
   `(default
      ((,class (:background ,bg-base :foreground ,fg-default))))
   `(bold
      ((,class (:weight bold))))
   `(bold-italic
      ((,class (:weight bold :slant italic))))
   `(italic
      ((,class (:slant italic))))
   `(underline
      ((,class (:underline t))))
   `(shadow
      ((,class (:foreground ,fg-muted))))
   `(link
      ((,class (:foreground ,blue :underline t))))
   `(link-visited
      ((,class (:foreground ,magenta :underline t))))
   `(highlight
      ((,class (:background ,highlight :foreground ,fg-bright))))
   `(region
      ((,class (:background ,bg-overlay))))
   `(secondary-selection
      ((,class (:background ,bg-muted))))
   `(trailing-whitespace
      ((,class (:background ,red :foreground ,red))))
   `(nobreak-space
      ((,class (:background ,bg-muted :underline (:color ,blue)))))

   ;; Minibuffer
   `(minibuffer-prompt
      ((,class (:foreground ,blue :weight bold))))
   `(completions-common-part
      ((,class (:foreground ,yellow :weight bold))))
   `(completions-first-difference
      ((,class (:foreground ,red :weight bold))))

   ;; Buffer and window
   `(buffer-menu-buffer
      ((,class (:foreground ,blue :weight bold))))
   `(fringe
      ((,class (:background ,bg-base :foreground ,bg-muted))))
   `(window-border
      ((,class (:background ,border))))
   `(window-divider
      ((,class (:foreground ,border))))
   `(vertical-border
      ((,class (:foreground ,border))))

   ;; Mode line
   `(mode-line
      ((,class (:background ,bg-surface :foreground ,fg-dim :box (:line-width 1 :color ,border)))))
   `(mode-line-buffer-id
      ((,class (:foreground ,blue :weight bold))))
   `(mode-line-emphasis
      ((,class (:foreground ,fg-bright :weight bold))))
   `(mode-line-highlight
      ((,class (:background ,bg-overlay :foreground ,fg-bright))))
   `(mode-line-inactive
      ((,class (:background ,bg-dim :foreground ,fg-muted :box (:line-width 1 :color ,border)))))

   ;; Line numbers
   `(line-number
      ((,class (:foreground ,bg-muted :background ,bg-base))))
   `(line-number-current-line
      ((,class (:foreground ,blue :background ,bg-surface :weight bold))))
   `(line-number-major-mode
      ((,class (:foreground ,fg-muted :background ,bg-base))))

   ;; Syntax highlighting
   `(font-lock-builtin-face
      ((,class (:foreground ,magenta))))
   `(font-lock-comment-face
      ((,class (:foreground ,fg-muted :slant italic))))
   `(font-lock-constant-face
      ((,class (:foreground ,magenta))))
   `(font-lock-delimiter-face
      ((,class (:foreground ,fg-dim))))
   `(font-lock-doc-face
      ((,class (:foreground ,fg-muted :slant italic))))
   `(font-lock-function-name-face
      ((,class (:foreground ,blue))))
   `(font-lock-keyword-face
      ((,class (:foreground ,magenta))))
   `(font-lock-negation-char-face
      ((,class (:foreground ,red))))
   `(font-lock-preprocessor-face
      ((,class (:foreground ,magenta-dim))))
   `(font-lock-regexp-grouping-backslash
      ((,class (:foreground ,fg-dim))))
   `(font-lock-regexp-grouping-construct
      ((,class (:foreground ,fg-dim))))
   `(font-lock-string-face
      ((,class (:foreground ,green))))
   `(font-lock-type-face
      ((,class (:foreground ,yellow))))
   `(font-lock-variable-name-face
      ((,class (:foreground ,fg-default))))
   `(font-lock-warning-face
      ((,class (:foreground ,warning :weight bold))))

   ;; Search and replace
   `(isearch
      ((,class (:background ,yellow :foreground ,bg-base :weight bold))))
   `(isearch-fail
      ((,class (:background ,red :foreground ,fg-bright))))
   `(lazy-highlight
      ((,class (:background ,bg-overlay :foreground ,yellow))))
   `(match
      ((,class (:background ,bg-overlay :foreground ,green :weight bold))))

   ;; Diffs
   `(diff-added
      ((,class (:background ,green :foreground ,bg-base))))
   `(diff-removed
      ((,class (:background ,red :foreground ,bg-base))))
   `(diff-changed
      ((,class (:background ,yellow :foreground ,bg-base))))
   `(diff-indicator-added
      ((,class (:background ,green :foreground ,bg-base))))
   `(diff-indicator-removed
      ((,class (:background ,red :foreground ,bg-base))))
   `(diff-indicator-changed
      ((,class (:background ,yellow :foreground ,bg-base))))
   `(diff-refine-added
      ((,class (:background ,green-dim :foreground ,bg-base))))
   `(diff-refine-removed
      ((,class (:background ,red-dim :foreground ,bg-base))))
   `(diff-refine-changed
      ((,class (:background ,yellow-dim :foreground ,bg-base))))

   ;; Diff-hl
   `(diff-hl-insert
      ((,class (:background ,green :foreground ,green))))
   `(diff-hl-delete
      ((,class (:background ,red :foreground ,red))))
   `(diff-hl-change
      ((,class (:background ,yellow :foreground ,yellow))))

   ;; Errors and diagnostics
   `(error
      ((,class (:foreground ,error :weight bold))))
   `(warning
      ((,class (:foreground ,warning :weight bold))))
   `(success
      ((,class (:foreground ,success :weight bold))))

   ;; Flycheck / Flymake
   `(flycheck-error
      ((,class (:underline (:style wave :color ,red)))))
   `(flycheck-warning
      ((,class (:underline (:style wave :color ,yellow)))))
   `(flycheck-info
      ((,class (:underline (:style wave :color ,blue)))))
   `(flymake-error
      ((,class (:underline (:style wave :color ,red)))))
   `(flymake-warning
      ((,class (:underline (:style wave :color ,yellow)))))
   `(flymake-note
      ((,class (:underline (:style wave :color ,blue)))))

   ;; Which-key
   `(which-key-key-face
      ((,class (:foreground ,green :weight bold))))
   `(which-key-separator-face
      ((,class (:foreground ,fg-muted))))
   `(which-key-note-face
      ((,class (:foreground ,fg-muted :slant italic))))
   `(which-key-command-description-face
      ((,class (:foreground ,fg-default))))
   `(which-key-group-description-face
      ((,class (:foreground ,magenta))))
   `(which-key-special-key-face
      ((,class (:foreground ,yellow :weight bold))))

   ;; Company / completion
   `(company-tooltip
      ((,class (:background ,bg-surface :foreground ,fg-default))))
   `(company-tooltip-selection
      ((,class (:background ,bg-overlay :foreground ,fg-bright))))
   `(company-tooltip-common
      ((,class (:foreground ,yellow :weight bold))))
   `(company-tooltip-annotation
      ((,class (:foreground ,fg-muted))))
   `(company-scrollbar-bg
      ((,class (:background ,bg-surface))))
   `(company-scrollbar-fg
      ((,class (:background ,bg-muted))))

   ;; Consult
   `(consult-preview-match-face
      ((,class (:background ,bg-overlay :foreground ,yellow))))

   ;; Vertico
   `(vertico-current
      ((,class (:background ,bg-overlay :foreground ,fg-bright :weight bold))))

   ;; Marginalia
   `(marginalia-documentation
      ((,class (:foreground ,fg-muted :slant italic))))

   ;; Org-mode
   `(org-level-1
      ((,class (:foreground ,blue :weight bold :height 1.3))))
   `(org-level-2
      ((,class (:foreground ,magenta :weight bold :height 1.2))))
   `(org-level-3
      ((,class (:foreground ,green :weight bold :height 1.1))))
   `(org-level-4
      ((,class (:foreground ,yellow :weight bold))))
   `(org-level-5
      ((,class (:foreground ,cyan :weight bold))))
   `(org-level-6
      ((,class (:foreground ,peach :weight bold))))
   `(org-level-7
      ((,class (:foreground ,rosewater :weight bold))))
   `(org-level-8
      ((,class (:foreground ,fg-dim :weight bold))))
   `(org-todo
      ((,class (:foreground ,red :weight bold))))
   `(org-done
      ((,class (:foreground ,green :weight bold))))
   `(org-headline-done
      ((,class (:foreground ,fg-muted :strike-through t))))
   `(org-code
      ((,class (:foreground ,green :background ,bg-surface))))
   `(org-verbatim
      ((,class (:foreground ,magenta))))
   `(org-block
      ((,class (:background ,bg-surface))))
   `(org-block-begin-line
      ((,class (:foreground ,fg-muted :slant italic))))
   `(org-block-end-line
      ((,class (:foreground ,fg-muted :slant italic))))
   `(org-meta-line
      ((,class (:foreground ,fg-muted :slant italic))))
   `(org-link
      ((,class (:foreground ,blue :underline t))))
   `(org-date
      ((,class (:foreground ,cyan))))
   `(org-special-keyword
      ((,class (:foreground ,magenta :weight bold))))

   ;; Markdown
   `(markdown-header-face
      ((,class (:foreground ,blue :weight bold))))
   `(markdown-header-delimiter-face
      ((,class (:foreground ,fg-muted))))
   `(markdown-list-face
      ((,class (:foreground ,magenta))))
   `(markdown-bold-face
      ((,class (:foreground ,fg-bright :weight bold))))
   `(markdown-italic-face
      ((,class (:foreground ,fg-bright :slant italic))))
   `(markdown-code-face
      ((,class (:foreground ,green :background ,bg-surface))))
   `(markdown-inline-code-face
      ((,class (:foreground ,green :background ,bg-surface))))
   `(markdown-link-face
      ((,class (:foreground ,blue :underline t))))
   `(markdown-url-face
      ((,class (:foreground ,cyan))))
   `(markdown-blockquote-face
      ((,class (:foreground ,fg-muted :slant italic))))

   ;; Dired
   `(dired-directory
      ((,class (:foreground ,blue :weight bold))))
   `(dired-flagged
      ((,class (:foreground ,red :weight bold))))
   `(dired-header
      ((,class (:foreground ,blue :weight bold))))
   `(dired-ignored
      ((,class (:foreground ,fg-muted))))
   `(dired-mark
      ((,class (:foreground ,yellow :weight bold))))
   `(dired-marked
      ((,class (:foreground ,green :weight bold))))
   `(dired-perm-write
      ((,class (:foreground ,fg-default))))
   `(dired-symlink
      ((,class (:foreground ,cyan :slant italic))))
   `(dired-warning
      ((,class (:foreground ,warning :weight bold))))

   ;; Magit
   `(magit-section-highlight
      ((,class (:background ,bg-surface))))
   `(magit-section-heading
      ((,class (:foreground ,blue :weight bold))))
   `(magit-section-heading-selection
      ((,class (:foreground ,yellow :weight bold))))
   `(magit-diff-file-heading
      ((,class (:foreground ,fg-dim :weight bold))))
   `(magit-diff-file-heading-highlight
      ((,class (:background ,bg-overlay :foreground ,fg-bright))))
   `(magit-diff-hunk-heading
      ((,class (:foreground ,magenta :background ,bg-muted))))
   `(magit-diff-hunk-heading-highlight
      ((,class (:foreground ,magenta :background ,bg-overlay))))
   `(magit-diff-added
      ((,class (:foreground ,green))))
   `(magit-diff-added-highlight
      ((,class (:foreground ,green :background ,bg-surface))))
   `(magit-diff-removed
      ((,class (:foreground ,red))))
   `(magit-diff-removed-highlight
      ((,class (:foreground ,red :background ,bg-surface))))
   `(magit-branch-local
      ((,class (:foreground ,blue :weight bold))))
   `(magit-branch-remote
      ((,class (:foreground ,green :weight bold))))
   `(magit-tag
      ((,class (:foreground ,yellow :weight bold))))
   `(magit-log-author
      ((,class (:foreground ,magenta))))
   `(magit-log-date
      ((,class (:foreground ,fg-muted))))
   `(magit-hash
      ((,class (:foreground ,cyan))))

   ;; Evil
   `(evil-ex-info
      ((,class (:foreground ,blue :slant italic))))
   `(evil-ex-substitute-matches
      ((,class (:foreground ,red :underline t))))
   `(evil-ex-substitute-replacement
      ((,class (:foreground ,green :underline t))))

   ;; Treemacs
   `(treemacs-directory-face
      ((,class (:foreground ,blue))))
   `(treemacs-file-face
      ((,class (:foreground ,fg-default))))
   `(treemacs-root-face
      ((,class (:foreground ,blue :weight bold))))
   `(treemacs-git-added-face
      ((,class (:foreground ,green))))
   `(treemacs-git-modified-face
      ((,class (:foreground ,yellow))))
   `(treemacs-git-untracked-face
      ((,class (:foreground ,fg-muted))))

   ;; Popup
   `(popup-face
      ((,class (:background ,bg-surface :foreground ,fg-default))))
   `(popup-menu-selection-face
      ((,class (:background ,bg-overlay :foreground ,fg-bright :weight bold))))
   `(popup-tip-face
      ((,class (:background ,bg-surface :foreground ,fg-dim))))

   ;; Tab-bar / tabs
   `(tab-bar
      ((,class (:background ,bg-dim :foreground ,fg-muted))))
   `(tab-bar-tab
      ((,class (:background ,bg-base :foreground ,fg-bright :box (:line-width 1 :color ,border)))))
   `(tab-bar-tab-inactive
      ((,class (:background ,bg-dim :foreground ,fg-muted :box (:line-width 1 :color ,border)))))

   ;; Tree-sitter
   `(tree-sitter-hl-face:property
      ((,class (:foreground ,cyan))))
   `(tree-sitter-hl-face:attribute
      ((,class (:foreground ,magenta))))
   `(tree-sitter-hl-face:variable
      ((,class (:foreground ,fg-default))))
   `(tree-sitter-hl-face:variable.builtin
      ((,class (:foreground ,magenta))))
   `(tree-sitter-hl-face:parameter
      ((,class (:foreground ,fg-default))))
   `(tree-sitter-hl-face:number
      ((,class (:foreground ,peach))))
   `(tree-sitter-hl-face:literal
      ((,class (:foreground ,peach))))
   `(tree-sitter-hl-face:punctuation
      ((,class (:foreground ,fg-dim))))
   `(tree-sitter-hl-face:punctuation.bracket
      ((,class (:foreground ,fg-dim))))
   `(tree-sitter-hl-face:punctuation.delimiter
      ((,class (:foreground ,fg-dim))))
   `(tree-sitter-hl-face:operator
      ((,class (:foreground ,cyan))))
   ))

;; ---------------------------------------------------------------------------
;; Theme variables
;; ---------------------------------------------------------------------------

;;;###autoload
(when load-file-name
  (add-to-list 'custom-theme-load-path
               (file-name-directory load-file-name)))

(provide-theme 'parch)

;;; parch-theme.el ends here
