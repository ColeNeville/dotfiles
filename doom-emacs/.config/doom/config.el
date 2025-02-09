;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-gruvbox)
(setq doom-font (font-spec :family "CaskaydiaCove Nerd Font" :size 14))
(setq doom-symbol-font (font-spec :family "CaskaydiaCove Nerd Font" :size 16))

(when (string= (system-name) "garuda-v2")
  (setq doom-font (font-spec :family "CaskaydiaCove Nerd Font" :size 26))
  (setq doom-symbol-font (font-spec :family "CaskaydiaCove Nerd Font" :size 30)))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")
(setq org-roam-directory "~/org/roam")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.


;; This configuration file sets up various settings and packages for Doom Emacs, including indentation levels, formatting options, language servers, and custom configurations for specific modes.

(after! which-key
  ;; Set the idle delay for which-key to 0 for immediate display of keybindings.
  (setq which-key-idle-delay 0))

;; Basic offset settings for different shells.
(setq sh-basic-offset 2)
(setq standard-indent 2)

;; Indentation levels for specific modes: TypeScript, JavaScript, YAML, and Web mode.
(setq typescript-indent-level 2)
(setq js-indent-level 2)
(setq yaml-indent-offset 2)
(setq web-mode-css-indent-offset 2)

;; Add YAML and TypeScript modes to the list of disabled formats for on-save formatting.
(add-to-list '+format-on-save-disabled-modes 'yaml-mode)
(add-to-list '+format-on-save-disabled-modes 'typescript-mode)

;; Enable headerline breadcrumb in lsp mode.
(add-hook 'lsp-mode-hook 'lsp-headerline-breadcrumb-enable)

;; Configuration for the dape debugger to attach to a Ruby application running on homer-docker.
(use-package! dape
  :config
  (add-to-list
   'dape-configs
   '(homer-docker
     modes nil
     host "localhost"
     port 1234
     prefix-local "/Users/cneville/projects/homer"
     :type "Ruby"
     :request "attach")))

;; Configuration for the gptel package to interact with an Ollama model.
(use-package! gptel
  :commands
  (gptel gptel-menu)
  :config
  ;; Define a connection to Titan Ollama (VPN) and specify models available.
  (gptel-make-ollama "Titan Ollama (VPN)"
                     :host "titan.vpn.coleslab.ca:11434"
                     :stream t
                     :models '(deepseek-r1:32b
                               deepseek-coder-v2:16b))
  ;; Define a connection to Titan Ollama and specify models available.
  (gptel-make-ollama "Titan Ollama"
                     :host "titan.local.coleslab.ca:11434"
                     :stream t
                     :models '(deepseek-r1:32b
                              deepseek-coder-v2:16b)))
