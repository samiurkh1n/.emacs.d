; Lang

; General

(require-package 'flycheck)
(add-hook 'after-init-hook 'global-flycheck-mode)
(setq flycheck-display-errors-function #'flycheck-display-error-messages-unless-error-list)

(when (maybe-require-package 'flycheck-color-mode-line)
  (add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode))

(setq tab-always-indent 'complete)
(add-to-list 'completion-styles 'initials t)

(require-package 'company)
(add-hook 'after-init-hook 'global-company-mode)
(with-eval-after-load 'company
  (dolist (backend '(company-eclim company-semantic))
    (delq backend company-backends))
  (diminish 'company-mode)
  (define-key company-mode-map (kbd "M-/") 'company-complete)
  (define-key company-active-map (kbd "M-/") 'company-other-backend)
  (define-key company-active-map (kbd "C-n") 'company-select-next)
  (define-key company-active-map (kbd "C-p") 'company-select-previous)
  (setq-default company-dabbrev-other-buffers 'all
		company-tooltip-align-annotations t))
(global-set-key (kbd "M-C-/") 'company-complete)
(when (maybe-require-package 'company-quickhelp)
  (add-hook 'after-init-hook 'company-quickhelp-mode))

; Markdown
(when (maybe-require-package 'markdown-mode)
  (add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
  (add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode)))

; C++
(require 'cc-mode)
(setq c-default-style "linux")
(setq c-basic-offset 4)
(require-package 'irony)
(require-package 'company-irony)
(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
;; Windows performance tweaks to make irony mode work better
(when (boundp 'w32-pipe-read-delay)
  (setq w32-pipe-read-delay 0))
;; Set the buffer size to 64K on Windows (from the original 4K)
(when (boundp 'w32-pipe-buffer-size)
  (setq irony-server-w32-pipe-buffer-size (* 64 1024)))
(eval-after-load 'company
  '(add-to-list 'company-backends 'company-irony))

; Go
(require-package 'go-mode)
(setenv "PATH" (concat (getenv "PATH") ":" "C:/dev/go/bin"))
(setq exec-path (append exec-path (list "C:/dev/go/bin")))
(add-hook 'before-save-hook 'gofmt-before-save)
(add-hook 'go-mode-hook (lambda ()
                          (local-set-key (kbd "C-c C-r") 'go-remove-unused-imports)
                          (local-set-key (kbd "C-c i") 'go-goto-imports)
                          (local-set-key (kbd "M-.") 'godef-jump)
			  (require-package 'company-go)
                          (require-package 'go-autocomplete)
                          (require-package 'auto-complete)
			  (company-mode)
			  (set (make-local-variable 'company-backends) '(company-go))
                          (ac-config-default)
                          (auto-complete-mode 1)))

; Python
(require-package 'jedi)
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)

(require-package 'elpy)
(elpy-enable)
(when (load "flycheck" t t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

; 6502
(require '6502-mode)
(add-to-list 'auto-mode-alist '("\\.s65" . 6502-mode))

(provide 'init-lang)
