;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Felix Clark"
      user-mail-address "mfclark3690@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "monospace" :size 14))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.


;;;;;;;;;;;;;;;;;
;; My additions
;;;;;;;;;;;;;;;;;

;; Using a non-bash shell can cause projectile to be quite slow. NVM could be
;; the culprit; see https://github.com/syl20bnr/spacemacs/issues/4207
(setq shell-file-name "/bin/bash")
;; It might even be worth it to use sh instead, although bash seems to solve the
;; problem for now.
;; (setq shell-file-name "/bin/sh")

;; Make column filling a little less narrow (default is 80). The python
;; formatter black uses 88 (a 10% increase) which seems reasonable.
(setq-default fill-column 88)

;; The default delay for which-key is a full second. This must be set *before*
;; which-key is activated.
(setq which-key-idle-delay 0.5)

;; Try to get flycheck to check more aggressively, as it tends to quit after
;; file save when using LSP.
;; Likely related to https://github.com/hlissner/doom-emacs/issues/2060.
;; This includes all possible events, and by itself does not solve the problem.
;; NOTE: These approaches did not work. For possible workarounds see:
;; https://github.com/emacs-lsp/lsp-mode/issues/1476
;; (after! flycheck
;;   (setq flycheck-check-syntax-automatically
;;         ;; '(save idle-change idle-buffer-switch new-line mode-enabled )))
;;         nil))
;; (after! lsp-ui
;;   ;; (setq lsp-prefer-flymake :none))
;;   (setq lsp-diagnostic-package :flycheck))
