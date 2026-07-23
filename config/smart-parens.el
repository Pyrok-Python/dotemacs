(use-package smartparens
  :ensure t
  :hook (((prog-mode geiser-repl-mode org-mode) . smartparens-mode)
         ((prog-mode geiser-repl-mode) . smartparens-strict-mode))
  :config (progn
			(sp-pair "\'" nil :actions nil)
			(setq sp-highlight-pair-overlay nil)
			(setq sp-highlight-wrap-overlay nil)
			(setq sp-highlight-wrap-tag-overlay nil)))
