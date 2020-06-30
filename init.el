; Emacs Configuration

; Increase gc limits to speed up startup
(defvar last-file-name-handler-alist file-name-handler-alist)
(setq gc-cons-threshold 402653184
      gc-cons-percentage 0.6
      file-name-handler-alist nil)

(let ((minver "24.4"))
  (when (version< emacs-version minver)
    (error "Your Emacs is too old -- this config requires v%s or higher" minver)))
(when (version< emacs-version "25.1")
  (message "Your Emacs is old, and some functionality in this config will be disabled. Please upgrade if possible."))

(set-language-environment "UTF-8")
(setq ring-bell-function 'ignore)

(add-to-list 'load-path (expand-file-name "init-scripts" user-emacs-directory))

(require 'init-utils)
(require 'init-site-lisp)
(require 'init-elpa)
(require-package 'diminish)

(require 'init-themes)
(require 'init-lang)
(require 'init-editing)
(require 'init-tags)
(require 'init-git)
(require 'init-compile)
(require 'init-exec-path)

; Emacs backup directory
(setq backup-by-copying t      ; don't clobber symlinks
      backup-directory-alist '(("." . "~/.emacs-saves/"))    ; don't litter my fs tree
      delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)       ; use versioned backups
(setq auto-save-file-name-transforms
      `((".*" "~/.emacs-saves/" t)))

(provide 'init)

; Reset gc after loading config
(setq gc-cons-threshold 16777216
      gc-cons-percentage 0.1
      file-name-handler-alist last-file-name-handler-alist)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
	("830877f4aab227556548dc0a28bf395d0abe0e3a0ab95455731c9ea5ab5fe4e1" default)))
 '(package-selected-packages
   (quote
	(go-autocomplete company-go exec-path-from-shell alert fullframe magit-todos magit yascroll whitespace-cleanup-mode multiple-cursors move-dup markdown-mode jedi goto-line-preview go-mode ggtags flycheck-color-mode-line elpy diminish company-quickhelp avy))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
