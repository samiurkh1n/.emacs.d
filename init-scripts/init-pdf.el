;;; PDF Tooling

(require-package 'pdf-tools)
(with-eval-after-load 'pdf-tools
  (pdf-tools-install)
  (setq-default pdf-view-display-size 'fit-page))

(provide 'init-pdf)
