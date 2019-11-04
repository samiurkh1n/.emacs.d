; Lang

; General

(when (maybe-require-package 'flycheck)
  (add-hook 'after-init-hook 'global-flycheck-mode)
  (setq flycheck-display-errors-function #'flycheck-display-error-messages-unless-error-list)

  (when (maybe-require-package 'flycheck-color-mode-line)
    (add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode)))

(setq tab-always-indent 'complete)
(add-to-list 'completion-styles 'initials t)

(when (maybe-require-package 'company)
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
    (add-hook 'after-init-hook 'company-quickhelp-mode)))

; Markdown
(when (maybe-require-package 'markdown-mode)
  (add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
  (add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode)))
  
; C++
(require 'cc-mode)
(setq c-default-style "linux")
(setq c-basic-offset 2)
(setq gdb-many-windows t)
(setq gdb-show-main t)

; Go
(when (maybe-require-package 'go-mode)
  (if (or (eq system-type 'ms-dos) (eq system-type 'windows-nt))
      (progn
        (setenv "PATH" (concat (getenv "PATH") ":" "C:/Users/samiu/Developer/go/bin"))
        (setq exec-path (append exec-path (list "C:/Users/samiu/Developer/go/bin")))))
  (add-hook 'before-save-hook 'gofmt-before-save)
  (add-hook 'go-mode-hook (lambda ()
                            (local-set-key (kbd "C-c C-r") 'go-remove-unused-imports)
                            (local-set-key (kbd "C-c i") 'go-goto-imports)
                            (local-set-key (kbd "M-.") 'godef-jump)
                            (require-package 'go-autocomplete)
                            (require-package 'auto-complete)
                            (ac-config-default)
                            (auto-complete-mode 1))))

; Python
(when (maybe-require-package 'jedi)
  (add-hook 'python-mode-hook 'jedi:setup)
  (setq jedi:complete-on-dot t))
(when (maybe-require-package 'elpy)
  (elpy-enable)
  (when (load "flycheck" t t)
    (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
    (add-hook 'elpy-mode-hook 'flycheck-mode)))

(provide 'init-lang)
