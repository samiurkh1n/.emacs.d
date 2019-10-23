;; Utils

(unless (fboundp 'package-cleanup)
  (require 'cl)
	
  (defun package-delete-by-name (package)
    (package-delete (symbol-name package)
                    (package-version-join (package-version-for package))))

  (defun package-maybe-install (name)
    (or (package-installed-p name) (package-install name)))

  (defun package-cleanup (packages)
    "Remove packages not explicitly declared"
    (let ((removes (set-difference (mapcar 'car package-alist) packages)))
      (mapc 'package-delete-by-name removes))))

(defun package-manifest (&rest packages)
  (package-initialize)
  (mapc 'package-maybe-install packages)
    (package-cleanup packages)
)

;;; Algorithm training functions
(defun usaco-setup()
  "Paste in a template for algorithm problems for USACO"
  (interactive)
  (defvar problem_name "")
  (defvar language "C++")
  (setq problem_name (read-string "Enter problem name: "))
  (setq language (read-string "Enter language (C/C++): "))
  (goto-char (point-min))
  (cond
   ((string-equal language "C++") (insert "/*\nID: samiurk1\nTASK: " problem_name "\nLANG: C++\n*/\n\n#include <fstream>\n#include <iostream>\n\nint main() {\n  return 0;\n}\n"))
   ((string-equal language "C") (insert "/*\nID: samiurk1\nTASK: " problem_name "\nLANG: C\n*/\n\n#include <stdio.h>\n\nint main() {\n  return 0;\n}\n"))
   (t (message "Unrecognized language for USACO Template. Needs to be \"C\" or \"C++\""))))

(provide 'init-utils)
