; Tags

(require-package 'ggtags)
(setq ggtags-executable-directory "c:/Program Files/GNU/ggtags/bin")
(add-hook 'c-mode-common-hook
          (lambda ()
            (when (derived-mode-p 'c-mode 'c++-mode 'java-mode 'asm-mode 'python-mode)
              (ggtags-mode 1))))

(eval-after-load "ggtags" '(progn
                             (define-key ggtags-mode-map (kbd "C-c g s") 'ggtags-find-other-symbol)
                             (define-key ggtags-mode-map (kbd "C-c g h") 'ggtags-view-tag-history)
                             (define-key ggtags-mode-map (kbd "C-c g r") 'ggtags-find-reference)
                             (define-key ggtags-mode-map (kbd "C-c g f") 'ggtags-find-file)
                             (define-key ggtags-mode-map (kbd "C-c g c") 'ggtags-create-tags)
                             (define-key ggtags-mode-map (kbd "C-c g u") 'ggtags-update-tags)
                             (define-key ggtags-mode-map (kbd "M-,") 'pop-tag-mark)))

(provide 'init-tags)
