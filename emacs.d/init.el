(add-to-list 'load-path "~/.emacs.d")

(require 'dotfiles-packages)

(dotfiles-install-packages '(color-theme-solarized
			     css-mode
			     haml-mode
			     js2-mode
			     magit
			     markdown-mode
			     rinari
			     sass-mode
			     scss-mode
			     yaml-mode))
                             expand-region

(load-theme 'solarized-dark t)

(global-set-key (kbd "M-@") 'er/expand-region)
(global-set-key (kbd "M-#") 'er/contract-region)
