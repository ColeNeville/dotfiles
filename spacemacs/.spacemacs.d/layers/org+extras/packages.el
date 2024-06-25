(defconst org+extras-packages
  '((org-modern-indent
     :require (org org-modern)
     :location (recipe
                :fetcher github
                :repo "jdtsmith/org-modern-indent"))
    (org-ref :require (org))
    (org-roam-bibtex
     :toggle org+extras-enable-roam-bibtex
     :require '(org-roam bibtex org-ref))))

(defun org+extras/init-org-modern-indent ()
  (use-package org-modern-indent
    :config ; add late to hook
    (add-hook 'org-mode-hook #'org-modern-indent-mode 90)))

(defun org+extras/init-org-ref ()
  (use-package org-ref))

(defun org+extras/init-org-roam-bibtex ()
  (use-package org-roam-bibtex
    :commands
    (org-roam-bibtex-mode)
    :custom
    (orb-roam-ref-format 'org-ref-v3)))


(eval-after-load 'org
  (lambda ()
    (setq org-startup-indented t)

    (add-hook 'org-mode-hook 'visual-line-mode)))

(eval-after-load 'org-roam
  (lambda ()
    (setq org-roam-directory org+extras-roam-directory)
    (setq org-roam-dailies-directory org+extras-roam-dailies-directory)

    (add-hook 'org-roam-mode-hook 'org-roam-bibtex-mode)
    (org-roam-db-autosync-enable)))

(eval-after-load 'org-modern
  (lambda ()
    (setq org-modern-hide-stars nil)
    (setq org-modern-table nil)

    (add-hook 'org-mode-hook 'org-modern-mode)
    (add-hook 'org-agenda-finalize-hook 'org-modern-adjenda)))
