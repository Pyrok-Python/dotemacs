(use-package ef-themes
  :ensure t
  :demand t
  :config (progn
	    (load-theme 'ef-bio :no-confirm)
	    (global-set-key (kbd "C-S-n") #'ef-themes-load-random-dark)))
