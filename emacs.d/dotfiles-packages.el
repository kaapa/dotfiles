;; Adaptation of Emacs Prelude package installer
;; http://batsov.com/emacs-prelude
(require 'cl)
(require 'package)

(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)

(package-initialize)

(setq url-http-attempt-keepalives nil)

(defun dotfiles-packages-installed-p(packages)
  (loop for p in packages
	when (not (package-installed-p p)) do (return nil)
	finally (return t)))

(defun dotfiles-install-packages(packages)
  (unless (dotfiles-packages-installed-p packages)
    ;; check for new packages (package versions)
    (message "%s" "Emacs is now refreshing its package database...")
    (package-refresh-contents)
    (message "%s" " done.")
    ;; install the missing packages
    (dolist (p packages)
      (unless (package-installed-p p)
	(package-install p)))))

(provide 'dotfiles-packages)
