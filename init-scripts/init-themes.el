; Theme

(mapcar #'disable-theme custom-enabled-themes)

(add-to-list 'default-frame-alist '(font . "DejaVu Sans Mono 11"))
(set-face-attribute 'default t :font "DejaVu Sans Mono 11")
(set-face-attribute 'font-lock-builtin-face nil :foreground "#DAB98F")
(set-face-attribute 'font-lock-comment-face nil :foreground "gray50")
(set-face-attribute 'font-lock-constant-face nil :foreground "olive drab")
(set-face-attribute 'font-lock-doc-face nil :foreground "gray50")
(set-face-attribute 'font-lock-function-name-face nil :foreground "burlywood3")
(set-face-attribute 'font-lock-keyword-face nil :foreground "DarkGoldenrod3")
(set-face-attribute 'font-lock-string-face nil :foreground "olive drab")
(set-face-attribute 'font-lock-type-face nil :foreground "burlywood3")
(set-face-attribute 'font-lock-variable-name-face nil :foreground "burlywood3")
(setq-default header-line-format mode-line-format)
(setq-default mode-line-format nil)

(when (maybe-require-package 'yascroll)
  (global-yascroll-bar-mode 1))

;;; (when (maybe-require-package 'solarized-theme)
;;;   (load-theme 'solarized-gruvbox-dark t)
;;; )

(defun post-load-stuff ()
  (interactive)
  (setq inhibit-splash-screen t)
  (toggle-frame-maximized)
  (balance-windows)
  (menu-bar-mode -1)
  (tool-bar-mode -1)
  (toggle-scroll-bar -1)
  (global-hl-line-mode 1)
  (set-fringe-mode '(1 . 1))
  (set-cursor-color "red") ; alt is green #40FF40
  (set-face-background 'hl-line "black")
  (set-foreground-color "burlywood3")
  (set-background-color "#161616")
)
(add-hook 'window-setup-hook 'post-load-stuff t)

(provide 'init-themes)
