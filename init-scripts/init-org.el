;;; org

(when (maybe-require-package 'org)
  (add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
  (load-library "find-lisp")
  (with-eval-after-load 'org
    (maybe-require-package 'htmlize)
    (maybe-require-package 'ob-C)
    (maybe-require-package 'ob-go)
    (maybe-require-package 'ox-latex)
    (require-package 'calfw)
    (require-package 'calfw-org)
    (setq org-directory "~/Dropbox/Org/")
    (setq org-agenda-files
          (find-lisp-find-files "~/Dropbox/Org" "\.org$"))
    (setq org-export-coding-system 'utf-8)
    (setq org-agenda-skip-deadline-prewarning-if-scheduled t)
    (org-babel-do-load-languages
     'org-babel-load-languages
     '((python . t)
       (C . t)
       (go . t)))
    (define-key global-map (kbd "C-c a") 'org-agenda)
    (define-key global-map (kbd "C-c c") 'org-capture)))

(provide 'init-org)
