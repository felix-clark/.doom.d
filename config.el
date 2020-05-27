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

;; Using a non-bash shell can cause projectile to be quite slow. NVM could be the
;; culprit; see https://github.com/syl20bnr/spacemacs/issues/4207
(setq shell-file-name "bash")
;; It might even be worth it to use sh instead, although bash seems to solve the problem
;; for now.
;; (setq shell-file-name "/bin/sh")

;; Make column filling a little less narrow (default is 80). The python formatter black
;; uses 88 (a 10% increase) which seems reasonable.
(setq-default fill-column 88)

;; The default delay for which-key is a full second. This must be set *before*
;; which-key is activated.
(setq which-key-idle-delay 0.5)

;; fish's auto features don't play nice in the terminal emulator
(after! multi-term
  (setq multi-term-program "bash"))

;; The company-lsp backend is no longer recommended. see:
;; https://github.com/hlissner/doom-emacs/issues/2589

;; Try using yapf as a formatter
;; This seems to work but we're using black anyway
;; (after! format
;;   (set-formatter! 'yapf "yapf -q" :modes '(python-mode)))

;; TODO: There are some difficulties activating a pipenv from a subdirectory. The pipenv.el
;; package is no longer maintained, but it seems to be a known issue.
;; This might be able to be worked around by setting python-shell-virtualenv-root ,
;; perhaps on projectile load.

;; Add some shortcuts for using lsp-treemacs
(use-package! lsp-treemacs
  :after (lsp-mode treemacs)
  :config
  (map! :map lsp-command-map
        "gs" #'lsp-treemacs-symbols
        ;; "gr" is mapped to lsp-find-reference; this is probably similar but uses
        ;; treemacs interface. "Gr" uses the peak interface.
        "gR" #'lsp-treemacs-references
        ;; There are more shortcuts useful in other languages (particularly Java)
        )
  ;; set sync mode on by default
  ;; not totally sure what this does. might be causing treemacs errors on magit
  ;; operations.
  ;; (lsp-treemacs-sync-mode 1)
  ;; workaround for extra spaces in lsp-treemacs-symbols list, which was supposedly
  ;; fixed in https://github.com/syl20bnr/spacemacs/issues/12880 but still persists. It
  ;; may be able to be removed eventually.
  (setq-hook! lsp-treemacs-generic-mode treemacs-space-between-root-nodes nil))

(after! lsp-ui
  ;; Turn off the sidebar for lsp-ui as the company childframe is preferred.
  ;; company childframe (I think) looks malformed so I'll turn that off for now instead
  ;; (setq lsp-ui-sideline-enable nil)
  ;; enable normal vim/evil keys for navigating ui-peek menu
  (map! :map lsp-ui-peek-mode-map
        ;; "j" #'lsp-ui-peek--select-next
        ;; "k" #'lsp-ui-peek--select-prev
        "C-j" #'lsp-ui-peek--select-next
        "C-k" #'lsp-ui-peek--select-prev))

;; Use rust-analyzer over RLS.
(after! lsp-rust
  (if (executable-find "rust-analyzer")
      ;; For some reason it's the rustic-lsp-server that needs to be set. See:
      ;; https://github.com/hlissner/doom-emacs/issues/2195
      (setq rustic-lsp-server 'rust-analyzer)))
;; (progn
;;   (setq rustic-lsp-server 'rust-analyzer)
;; This one might not be necessary:
;; (setq lsp-rust-server 'rust-analyzer)
;; )
;; ))

;; detect nvm version automatically for JS modes
(use-package! nvm
  :hook ((js2-mode typescript-mode) . nvm-use-for-buffer))

;; add custom elisp to the load path
(add-load-path! (expand-file-name "src" default-directory))
;; Load the email configuration
(require 'email)

;; Debugging via DAP works well locally but there is confusion about how to set it up
;; remotely.
;; define function for evaluation based on region-mode or not
;;;###autoload
(defun +debugger/dap-eval ()
  "Evaluate the expression at point or selected region."
  (interactive)
  (if (use-region-p)
      (dap-eval-region)
    (dap-eval-thing-at-point)))
;; Set some keybindings for debugging. See:
;; https://github.com/hlissner/doom-emacs/issues/2808
(map! :map dap-mode-map
      :leader
      ;; These should follow the dap-hydra. Not sure how to engage it directly.
      ;; This could also be incorporated into a custom hydra; we just want to add "d" to
      ;; start the debugging.
      ;; (:map :desc "debug" "d" #'dap-hydra
      ;; (:desc "debug" "d" #'dap-hydra
      ;; (:desc "debug" "d" (lambda () (call-interactively #'dap-hydra))
      (:prefix-map ("d" . "debugger")
       :desc "Debug" "d" #'dap-debug
       :desc "Continue" "c" #'dap-continue
       :desc "Next" "n" #'dap-next
       :desc "Step in" "i" #'dap-step-in
       :desc "Step out" "o" #'dap-step-out
       :desc "Disconnect" "Q" #'dap-disconnect
       :desc "Restart frame" "r" #'dap-restart-frame
       :desc "Evaluate" "e" #'+debugger/dap-eval
       (:prefix ("b" . "breakpoint")
        :desc "Toggle breakpoint" "b" #'dap-breakpoint-toggle
        :desc "Add breakpoint" "a" #'dap-breakpoint-add
        :desc "Delete breakpoint" "d" #'dap-breakpoint-delete
        :desc "Delete all breakpoints" "D" #'dap-breakpoint-delete-all
        :desc "Set/unset breakpoint condition" "c" #'dap-breakpoint-condition
        :desc "Set/unset breakpoint hit condition" "h" #'dap-breakpoint-hit-condition
        :desc "Set log message" "l" #'dap-breakpoint-log-message
        )
       ;; Consider moving these to the "s" prefix to match the hydra. There are other
       ;; switching functions in there too.
       (:prefix ("l" . "list")
        :desc "List locals" "l" #'dap-ui-locals
        :desc "List breakpoints" "b" #'dap-ui-breakpoints
        :desc "List sessions" "s" #'dap-ui-sessions
        )
       )
      )
;; See https://github.com/emacs-lsp/dap-mode#Usage for instructions on how to
;; automatically engage a hydra on a breakpoint.
;; This feels somewhat invasive for web debugging.
;; (add-hook 'dap-stopped-hook
;;           (lambda (arg) (call-interactively #'dap-hydra)))

;; setup web debuggers when their corresponding packages are loaded.
(after! dap-node
  (unless (file-exists-p (car (last dap-node-debug-program)))
    (dap-node-setup)))
(after! dap-gdb-lldb
  (unless (file-exists-p (car (last dap-gdb-lldb-debug-program)))
    (dap-gdb-lldb-setup)))
(after! dap-chrome
  (unless (file-exists-p (car (last dap-chrome-debug-program)))
    (dap-chrome-setup)))
(after! dap-firefox
  (unless (file-exists-p (car (last dap-firefox-debug-program)))
    (dap-firefox-setup)))

;; TODO: For using the angular language server see:
;; https://github.com/emacs-lsp/lsp-mode/wiki/Install-Angular-Language-server
;; this probably requires angular-mode, as installing the angular language server
;; appears to remove the typescript LS ? maybe not -- this was probably an environment issue.

(require 'trello)
