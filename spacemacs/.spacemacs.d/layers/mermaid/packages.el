;;; packages.el ---                                  -*- lexical-binding: t; -*-

;; Copyright (C) 2024

;; Author:  <cole@garuda>
;; Keywords:

(defconst mermaid-packages
  '(mermaid-mode))

(defun mermaid/init-mermaid-mode ()
  (use-package mermaid
    :commands (mermaid-mode)))
