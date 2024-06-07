(defconst org+extras-packages
  '(org
    (org-ref :require (org))
    (org-roam :toggle org-enable-roam-support)
    (org-roam-bibtex
     :toggle org+extras-enable-roam-bibtex
     :require '(org-roam bibtex org-ref))))

(defun org+extras/init-org-ref ()
  (use-package org-ref
    :after org))

(defun org+extras/init-org-roam-bibtex ()
  (use-package org-roam-bibtex
    :after
    (org-roam
     org-ref)
    :commands
    (org-roam-bibtex-mode)
    :custom
    (orb-roam-ref-format 'org-ref-v3)))

(defun org+extras/init-org ()
  (use-package org
    :defer t
    :config
    (add-hook 'org-mode-hook 'org-indent-mode)
    (add-hook 'org-mode-hook 'visual-line-mode)))

(defun org+extras/init-org-roam ()
  (use-package org-roam
    :defer t
    :after org
    :custom
    (org-roam-directory org+extras-roam-directory)
    (org-roam-dailies-directory org+extras-roam-dailies-directory)
    :config
    (add-hook 'org-roam-mode 'org-roam-bibtex-mode)
    (org-roam-db-autosync-enable)))
