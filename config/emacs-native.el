;;;; Set some basic config vars.

;; Custom init buffer.
(setq inhibit-startup-screen t)
(setq initial-buffer-choice t)
(setq initial-scratch-message nil)
(setq initial-major-mode 'org-mode)

;; Change font
(set-frame-font "Hack Nerd Font 14")

;; Fonts for emacsclient.
(add-to-list 'default-frame-alist '(font . "Hack Nerd Font 14"))

;; Disable ring-bell.
;;(setq ring-bell-function #'ignore)

;; Disable tool-bar.
(tool-bar-mode -1)

;; Enable line numbers in all buffers.
(global-display-line-numbers-mode -1)

;; Disable scroll-bar, line-numbers are good enough.
;; A minimap like in VS-Code would be more useful.
(scroll-bar-mode -1)

;; Disable menu-bar. I never used it in the first two weeks of using Emacs.
(menu-bar-mode -1)

;; Inserting text while the mark is active
;; causes the selected text to be deleted first.
(delete-selection-mode 1)

;; Set common-lisp backend to SBCL
;; To start sly faster, we can point sbcl to a custom core with Slynk dependencies preloaded.
;; Reference: https://joaotavora.github.io/sly/#Loading-Slynk-faster
;;(setq inferior-lisp-program "sbcl --dynamic-space-size 4096")

;; Actually close help buffers (and others) when you press 'q'.
(defadvice quit-window (before quit-window-always-kill)
  "When running `quit-window', always kill the buffer."
  (when (called-interactively-p 'interactive) (ad-set-arg 0 t)))
(ad-activate 'quit-window)

;; Move cursor to recently open help window
(setq help-window-select t)

;; Hide cursor in non-selected window
(setq-default cursor-in-non-selected-windows nil)

;; Allow scrolling during isearch
(setq isearch-allow-scroll 'unlimited)

;; Set tab width to 4 (default is 8)
(setq-default tab-width 4
              indent-tabs-mode t)

(setq backward-delete-char-untabify-method nil)
