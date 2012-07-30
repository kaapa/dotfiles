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

(load-theme 'solarized-dark t)
