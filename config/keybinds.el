(defun my/translate-keys (&optional frame) ; Reason:
  (keyboard-translate ?\C-i ?\s-i)       ; C-i = TAB
  (keyboard-translate ?\C-\[ ?\s-\[))    ; C-[ = M-w 
(add-hook 'after-make-frame-functions #'my/translate-keys)
(my/translate-keys)

;; Unbinds
(keymap-unset lisp-interaction-mode-map "C-M-i")
(keymap-unset emacs-lisp-mode-map "C-M-i")
(dolist (key '("C-z" "C-a" "C-n" "C-o" "C-p"
               "C-t" "C-]" "H-[" "M-e"
               "C-k" "C-l" "H-i" "C-j"
               "s-j" "s-l" "s-i" "s-k" "s-["))
  (keymap-global-unset key t)
  (keymap-unset lisp-interaction-mode-map key t))

;; Quick Help
(global-set-key (kbd "M-h") (kbd "C-h o <return>"))

(global-set-key (kbd "C-a") #'mark-whole-buffer)
(global-set-key (kbd "C-v") #'yank)
(global-set-key (kbd "C-z") #'undo)

(global-set-key (kbd "M-<left>") #'windmove-left)
(global-set-key (kbd "M-h") #'windmove-left)
(global-set-key (kbd "M-<right>") #'windmove-right)
(global-set-key (kbd "M-l") #'windmove-right)
(global-set-key (kbd "M-<up>") #'windmove-up)
(global-set-key (kbd "M-k") #'windmove-up)
(global-set-key (kbd "M-<down>") #'windmove-down)
(global-set-key (kbd "M-j") #'windmove-down)
