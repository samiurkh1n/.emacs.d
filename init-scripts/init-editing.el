; Editing

(setq buffer-file-coding-system "unix")
(setq-default indent-tabs-mode nil)

(global-set-key (kbd "RET") 'newline-and-indent)

(when (maybe-require-package 'goto-line-preview)
  (global-set-key [remap goto-line] 'goto-line-preview)
    (when (fboundp 'display-line-numbers-mode)
    (defun with-display-line-numbers (f &rest args)
      (let ((display-line-numbers t))
        (apply f args)))
    (advice-add 'goto-line-preview :around #'with-display-line-numbers)))
(global-set-key (kbd "M-g") 'goto-line)

(when (fboundp 'display-line-numbers-mode)
  (setq-default display-line-numbers-width 3)
  (add-hook 'prog-mode-hook 'display-line-numbers-mode))

(add-hook 'after-init-hook 'show-paren-mode) ; show matching parens

;; avy
(when (maybe-require-package 'avy)
  (global-set-key (kbd "C-;") 'avy-goto-char-timer))

;; multiple-cursors
(require-package 'multiple-cursors)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-+") 'mc/mark-next-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
;; From active region to multiple cursors:
(global-set-key (kbd "C-c m r") 'set-rectangular-region-anchor)
(global-set-key (kbd "C-c m c") 'mc/edit-lines)
(global-set-key (kbd "C-c m e") 'mc/edit-ends-of-lines)
(global-set-key (kbd "C-c m a") 'mc/edit-beginnings-of-lines)

;; moving lines with keyboard
(require-package 'move-dup)
(global-set-key [M-up] 'md-move-lines-up)
(global-set-key [M-down] 'md-move-lines-down)
(global-set-key [M-S-up] 'md-move-lines-up)
(global-set-key [M-S-down] 'md-move-lines-down)

(global-set-key (kbd "C-c d") 'md-duplicate-down)
(global-set-key (kbd "C-c u") 'md-duplicate-up)

;; backspace++
(defun kill-back-to-indentation ()
  "Kill from point back to the first non-whitespace character on the line."
  (interactive)
  (let ((prev-pos (point)))
    (back-to-indentation)
    (kill-region (point) prev-pos)))

(global-set-key (kbd "C-M-<backspace>") 'kill-back-to-indentation)

;;; Whitespace
(setq-default show-trailing-whitespace nil)

(defun show-trailing-whitespace ()
  (setq-local show-trailing-whitespace t))

(dolist (hook '(prog-mode-hook text-mode-hook))
  (add-hook hook 'show-trailing-whitespace))

(require-package 'whitespace-cleanup-mode)
(add-hook 'after-init-hook 'global-whitespace-cleanup-mode)
(with-eval-after-load 'whitespace-cleanup-mode
  (diminish 'whitespace-cleanup-mode))

;; Move around buffers with shift + arrow key
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))

;; 80 line column
(when (maybe-require-package 'fill-column-indicator)
  (define-globalized-minor-mode global-fci-mode fci-mode (lambda () (fci-mode 1)))
  (setq fci-rule-column 80)
  (global-fci-mode 1))

;; jump to top or bottom
(global-set-key (kbd "<home>") 'beginning-of-buffer)
(global-set-key (kbd "<end>") 'end-of-buffer)

(provide 'init-editing)
