;;; org-trello

(when (maybe-require-package 'org)
  (add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode)))

(maybe-require-package 'org-trello)

(provide 'init-trello)
