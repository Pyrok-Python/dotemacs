(use-package no-littering
  :ensure t
  :demand t
  :config
  ;; Redirect auto-save files (#filename#) to var/auto-save/
  (setq auto-save-file-name-transforms
        `((".*" ,(no-littering-expand-var-file-name "auto-save/") t)))

  ;; Redirect backup files (filename~) to var/backup/
  (setq backup-directory-alist
        `((".*" . ,(no-littering-expand-var-file-name "backup/")))))

;; Hide UI elements
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(global-display-line-numbers-mode -1)

;; Editing and navigation behavior
(delete-selection-mode 1)                         ; Replace selected text when typing
(setq isearch-allow-scroll 'unlimited)            ; Allow scrolling during isearch
(setq help-window-select t)                       ; Automatically focus *Help* windows
(setq-default cursor-in-non-selected-windows nil) ; Hide cursor in inactive windows

(add-to-list 'default-frame-alist '(font . "Hack Nerd Font-12"))
(set-face-attribute 'default nil :font "Hack Nerd Font-12")

(setq inhibit-startup-screen t)
(setq initial-scratch-message nil)
(setq initial-major-mode 'org-mode)

(setq-default tab-width 4)
(setq-default indent-tabs-mode t)
(setq backward-delete-char-untabify-method nil)

(define-advice quit-window (:before (&optional kill window) always-kill)
  "Ensure `quit-window' always kills the buffer when called interactively."
  (when (called-interactively-p 'interactive)
    (setq kill t)))

;;(setq native-comp-async-report-warnings-errors nil)
;;(setq warning-minimum-level :error)

(use-package ef-themes
  :ensure t
  :demand t
  :init
  ;; Load the default theme before displaying frames
  (load-theme 'ef-bio :no-confirm)
  :bind
  (("C-S-n" . ef-themes-load-random-dark)
   ("C-S-p" . (lambda ()
                (interactive)
                (load-theme 'ef-bio :no-confirm)))))

(use-package doom-modeline
  :ensure t
  :demand t
  :init
  (doom-modeline-mode 1)
  :custom
  (doom-modeline-icon t)                 ; Display icons in the mode line
  (doom-modeline-height 25)              ; Set modeline height
  (doom-modeline-buffer-file-name-style 'truncate-with-project)
  
  ;; --- Useful Additions ---
  (doom-modeline-major-mode-icon t)      ; Show icon for major mode (e.g. Python, Lisp, Org)
  (doom-modeline-buffer-encoding t)      ; Show encoding (UTF-8) only when non-standard
  (doom-modeline-indent-info t)          ; Show indentation type (e.g. 4 Spaces / Tabs)
  (doom-modeline-vcs-max-length 15))     ; Truncate long Git branch names cleanly

(use-package display-line-numbers
  :hook (prog-mode . display-line-numbers-mode))

(use-package dired
  :ensure nil
  :commands (dired dired-jump)
  :hook (dired-mode . dired-hide-details-mode)
  :bind ("C-d" . dired-jump)
  :custom
  (dired-listing-switches "-agho --group-directories-first"))

;; File and folder icons in Dired
(use-package all-the-icons-dired
  :ensure t
  :hook (dired-mode . all-the-icons-dired-mode))

;; Colorize permissions, dates, and file sizes
(use-package diredfl
  :ensure t
  :hook (dired-mode . diredfl-mode))

;; Orderless: Match search terms in any order (fuzzy searching)
(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles partial-completion)))))

;; Consult: Powerful search and navigation commands (Telescope alternative)
(use-package consult
  :ensure t
  :bind
  ;; File and Buffer Search
  (("C-b"   . consult-buffer)             ; Enhanced buffer switcher with preview
   ("C-c f"   . consult-fd)               ; Find files using 'fd' (very fast)
   ("C-c g"   . consult-ripgrep)          ; Live grep inside files with ripgrep
   ("C-s"     . consult-line)             ; Search text inside current buffer with preview
   :map minibuffer-local-map
   ("M-s"     . consult-history))
  :init
  ;; Live preview setup
  (setq consult-preview-key 'any))

(use-package company
  :ensure t
  :defer t
  :hook ((prog-mode . company-mode)
         (geiser-repl-mode . company-mode))
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0)
  (company-selection-wrap-around t)
  (company-tooltip-align-annotations t)
  :bind
  (("C-SPC" . company-complete)
   :map company-active-map
   ("M-j" . company-select-next)
   ("M-k" . company-select-previous)
   ("<tab>" . company-complete-selection)
   ("TAB" . company-complete-selection)
   ("<enter>" . nil)
   ("RET" . nil)
   ("C-h" . nil)))

(use-package smartparens
  :ensure t
  :hook (((prog-mode geiser-repl-mode org-mode) . smartparens-mode)
         ((prog-mode geiser-repl-mode) . smartparens-strict-mode))
  :config
  (require 'smartparens-config)
  
  ;; Disable single-quote auto-pairing specifically for programming and Lisp modes
    (sp-with-modes '(prog-mode geiser-repl-mode emacs-lisp-mode lisp-interaction-mode)
      (sp-local-pair "'" nil :actions nil))

    ;; Enable auto-pairing for Org-specific formatting tags
    (sp-with-modes 'org-mode
      (sp-local-pair "*" "*")
      (sp-local-pair "=" "=")
      (sp-local-pair "~" "~")
      (sp-local-pair "/" "/"))

  ;; Disable overlay highlights
  (setq sp-highlight-pair-overlay nil)
  (setq sp-highlight-wrap-overlay nil)
  (setq sp-highlight-wrap-tag-overlay nil))

(use-package rainbow-delimiters
  :ensure t
  :hook ((prog-mode geiser-repl-mode) . rainbow-delimiters-mode))

;; Vertico: Modern completion UI
(use-package vertico
  :ensure t
  :init
  (vertico-mode 1)
  :custom
  (vertico-cycle t))                   ; Cycle candidates infinitely

;; Marginalia: Rich contextual annotations next to commands
(use-package marginalia
  :ensure t
  :init
  (marginalia-mode 1))

;; Vertico-Posframe: Renders Vertico as a centered floating overlay
(use-package vertico-posframe
  :ensure t
  :after vertico
  :init
  (vertico-posframe-mode 1)
  :custom
  (vertico-posframe-poshandler #'posframe-poshandler-frame-center)
  (vertico-posframe-border-width 2)
  (vertico-posframe-parameters
   '((left-fringe . 8)
     (right-fringe . 8))))

;; Add local ob-racket directory to load-path before loading Babel languages
(add-to-list 'load-path (expand-file-name "ob-racket" user-emacs-directory))

(use-package org
  :ensure nil
  :hook (org-mode . visual-line-mode)
  :bind (:map org-mode-map
              ("s-i" . (lambda () (interactive) (insert "#+begin_src \n#+end_src") (forward-line -1) (end-of-line))))
  :custom
  ;; Babel execution settings
  (org-confirm-babel-evaluate nil)
  (org-edit-src-content-indentation 0)
  
  :config
  ;; Load Org Babel languages
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((python . t)
     (js . t)
     (racket . t))))

(use-package ob-racket
  :after org
  :pin manual)

(use-package org-modern
  :ensure t
  :demand t
  :hook (org-mode . org-modern-mode)
  :custom
  (org-auto-align-tags nil)
  (org-tags-column 0)
  (org-catch-invisible-edits 'show-and-error)
  (org-special-ctrl-a/e t)
  (org-insert-heading-respect-content t)
  (org-hide-emphasis-markers t)
  (org-pretty-entities t)
  (org-agenda-tags-column 0)
  (org-ellipsis " ")
  :config
  (global-org-modern-mode 1))

(use-package toc-org
  :ensure t
  :hook (org-mode . toc-org-enable))

(defun my/translate-keys (&optional frame)
  "Translate raw C-i and C-[ sequences to avoid collisions with TAB and ESC."
  (keyboard-translate ?\C-i ?\s-i)
  (keyboard-translate ?\C-\[ ?\s-\[))

(add-hook 'after-make-frame-functions #'my/translate-keys)
(my/translate-keys)

;; Unbind mode-specific C-M-i bindings
(keymap-unset lisp-interaction-mode-map "C-M-i" t)
(keymap-unset emacs-lisp-mode-map "C-M-i" t)

;; Global and mode-specific unbinds
(dolist (key '("C-z" "C-a" "C-n" "C-o" "C-p"
               "C-t" "C-]" "H-[" "M-e"
               "C-k" "C-l" "H-i" "C-j"
               "s-j" "s-l" "s-i" "s-k" "s-["))
  (keymap-global-unset key t)
  (keymap-unset lisp-interaction-mode-map key t))

(bind-keys
 ;; Common editing shortcuts
 ("C-a" . mark-whole-buffer)
 ("C-v" . yank)
 ("C-z" . undo)

 ;; Quick Help (replaces C-h o / describe-symbol)
 ("s-h" . describe-symbol)

 ;; Window Navigation (Vim style + Arrow keys)
 ("M-<left>"  . windmove-left)
 ("M-h"       . windmove-left)
 ("M-<right>" . windmove-right)
 ("M-l"       . windmove-right)
 ("M-<up>"    . windmove-up)
 ("M-k"       . windmove-up)
 ("M-<down>"  . windmove-down)
 ("M-j"       . windmove-down))
