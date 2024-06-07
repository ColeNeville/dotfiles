(defconst diminish-packages
  '(diminish))

(defun diminish/init-diminish ()
  (use-package diminish
    :config
    (dolist (mode diminish-modes)
      (diminish mode))))
