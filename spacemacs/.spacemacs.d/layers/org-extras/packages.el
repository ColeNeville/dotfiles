(defconst org-extras-packages
  '(bibtex
    org
    (org-ref :require (org))
    (org-roam :toggle org-enable-roam-support)
    (org-roam-bibtex
     :toggle org-enable-roam-bibtex
     :require '(org-roam bibtex org-ref))))

(defun org-extras/init-org-ref ()
  (use-package org-ref
    :after (org)))

(defun org-extras/init-org-roam-bibtex ()
  (use-package org-roam-bibtex
    :after (org-roam org-ref)
    :commands (org-roam-bibtex-mode)
    :custom
    (orb-roam-ref-format 'org-ref-v3)))

(defun org-extras/post-init-org ()
  (add-hook 'org-mode-hook 'org-indent-mode)
  (add-hook 'org-mode-hook 'visual-line-mode))

(defun org-extras/post-init-org-roam ()
  (add-hook 'org-roam-mode 'org-roam-bibtex-mode)
  (eval-after-load 'org-roam (org-roam-db-autosync-enable)))
