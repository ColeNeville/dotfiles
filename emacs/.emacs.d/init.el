(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

;; Keymaps
(use-package evil
  :demand t
  :config
  (evil-mode 1)
  (evil-set-leader '(kbd "SPC"))
  (evil-set-localleader '(kbd ",")))

(use-package general
  :demand t
  :config)

(use-package which-key
  :demand t)

;; Basic packages
(use-package treemacs
  :demand t
  :bind (("<leader>T" . treemacs))
  :config
  (treemacs))

(setq inhibit-startup-screen t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(treemacs which-key)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
