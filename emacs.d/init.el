(add-to-list 'load-path "~/.emacs.d")

(require 'dotfiles-packages)

(dotfiles-install-packages '(color-theme-solarized
                             css-mode
                             expand-region
                             haml-mode
                             js2-mode
                             magit
                             markdown-mode
                             rinari
                             sass-mode
                             scss-mode
                             yaml-mode))

(load-theme 'solarized-dark t)

(global-set-key (kbd "M-@") 'er/expand-region)
(global-set-key (kbd "M-#") 'er/contract-region)

;; store all backup and autosave files in the tmp dir
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; don't indent using tabs
(setq-default indent-tabs-mode nil)

;; config changes made through the customize UI will be store here
(setq custom-file "~/.emacs.d/custom.el")
