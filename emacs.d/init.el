(add-to-list 'load-path "~/.emacs.d")

(defvar dotfiles-cache-dir "~/.emacs.d/cache")

(require 'dotfiles-packages)

(dotfiles-install-packages '(css-mode
                             expand-region
                             haml-mode
                             js2-mode
                             magit
                             markdown-mode
                             rinari
                             rvm
                             sass-mode
                             scss-mode
                             yaml-mode))

(global-set-key (kbd "M-@") 'er/expand-region)
(global-set-key (kbd "M-#") 'er/contract-region)

;; store all backup and autosave files in the tmp dir
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; create cache dir if it doesn't exist
(unless (file-exists-p dotfiles-cache-dir)
  (make-directory dotfiles-cache-dir))

;; store bookmarks in cache dir
(setq bookmark-default-file (concat dotfiles-cache-dir "bookmarks")
      bookmark-save-flag 1)

;; store eshell alias and history info in cache dir
(setq eshell-directory-name (concat dotfiles-cache-dir "/eshell/"))

;; store semantic (emacs parser) db in cache dir
(setq semanticdb-default-save-directory
      (concat dotfiles-cache-dir "semanticdb"))

;; don't indent using tabs
(setq-default indent-tabs-mode nil)

;; config changes made through the customize UI will be store here
(setq custom-file "~/.emacs.d/custom.el")

;; ido-mode
(ido-mode t)
(setq ido-enable-prefix nil
      ido-enable-flex-matching t
      ido-create-new-buffer 'always
      ido-use-filename-at-point 'guess
      ido-max-prospects 10
      ido-save-directory-list-file dotfiles-cache-dir
      ido-default-file-method 'selected-window)

;; whitespace-mode
(global-whitespace-mode t)
(setq whitespace-style (quote (face trailing tabs lines empty)))

;; rhtml-mode
(add-to-list 'load-path "~/.emacs.d/vendor/rhtml")
(require 'rhtml-mode)
(add-to-list 'auto-mode-alist '("\\.html\\.erb\\'" . rhtml-mode))

;; ruby mode
(font-lock-add-keywords
 'ruby-mode
 '(("\\<extend\\|include\\|require\\>" . font-lock-keyword-face) ;; keywords
   ("\\<\\([0-9]+\\([eE][+-]?[0-9]*\\)?\\)\\>" 1 font-lock-string-face))) ;; numbers

;; faces
(custom-set-faces
 '(erb-exec-face ((t nil)))
 '(erb-out-face ((t nil)))
 '(font-lock-string-face ((t (:foreground "blue"))))
 '(highlight ((t (:background "black"))))
 '(region ((t (:background "black")))))

(require 'custom)

;; enable dired directory navigation in without opening a buffer per directory
;; (bound to a)
(put 'dired-find-alternate-file 'disabled nil)

;; enable dired omit mode (hide temporary files)
(require 'dired-x)
(setq-default dired-omit-files-p t)
;; only hide emacs temp files (by default hides dotfiles too)
(setq dired-omit-files "^\\.?#")

(defun indent-whole-buffer ()
  "indent whole buffer and untabify it"
  (interactive)
  (delete-trailing-whitespace)
  (indent-region (point-min) (point-max) nil)
  (untabify (point-min) (point-max)))

(setq scss-compile-at-save nil)
(put 'upcase-region 'disabled nil)
