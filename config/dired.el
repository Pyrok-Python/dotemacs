x(use-package dired
  :ensure nil
  :commands (dired dired-jump)
  :bind (("C-d" . dired-jump))
  :custom ((dired-listing-switches "-agho --group-directories-first")))

(add-hook 'dired-mode-hook #'dired-hide-details-mode)
