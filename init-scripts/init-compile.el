; Compile

(setq-default compilation-scroll-output t)

(require-package 'alert)

(defun alert-after-compilation-finish (buf result)
  "Use `alert' to report compilation RESULT if BUF is hidden."
  (when (buffer-live-p buf)
    (unless (catch 'is-visible
              (walk-windows (lambda (w)
                              (when (eq (window-buffer w) buf)
                                (throw 'is-visible t))))
              nil)
      (alert (concat "Compilation " result)
             :buffer buf
             :category 'compilation))))

(with-eval-after-load 'compile
  (add-hook 'compilation-finish-functions
            'alert-after-compilation-finish))

(defvar last-compilation-buffer nil
  "The last buffer in which compilation took place.")

(with-eval-after-load 'compile
  (defun save-compilation-buffer (&rest _)
    "Save the compilation buffer to find it later."
    (setq last-compilation-buffer next-error-last-buffer))
  (advice-add 'compilation-start :after 'save-compilation-buffer)

  (defun find-prev-compilation (orig &optional edit-command)
    "Find the previous compilation buffer, if present, and recompile there."
    (if (and (null edit-command)
             (not (derived-mode-p 'compilation-mode))
             last-compilation-buffer
             (buffer-live-p (get-buffer last-compilation-buffer)))
        (with-current-buffer last-compilation-buffer
          (funcall orig edit-command))
      (funcall orig edit-command)))
  (advice-add 'recompile :around 'find-prev-compilation))

(global-set-key [f5] 'compile)
(global-set-key [f6] 'recompile)

(with-eval-after-load 'compile
  (require 'ansi-color)
  (defun /colourise-compilation-buffer ()
    (when (eq major-mode 'compilation-mode)
      (ansi-color-apply-on-region compilation-filter-start (point-max))))
  (add-hook 'compilation-filter-hook '/colourise-compilation-buffer))

(when (maybe-require-package 'cmake-ide)
  (cmake-ide-setup))

(provide 'init-compile)
