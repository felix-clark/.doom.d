;;; email.el --- E-mail configuration
;;; Commentary:
;;; Code:

;; we need to tell where to look for mu4e.el, which was built from tarball.
;; note the path is site-lisp/mu4e, not site-lisp/mu/mu4e.
(add-load-path! "/usr/local/share/emacs/site-lisp/mu4e")

;; possibly:
;; This should only be relevant for queued email. By default it should send immediately.
;; if using smtpmail (defaults to "~/Mail/queue")
;; (setq smtpmail-queue-dir "...")

;; Each path is relative to ~/.mail
;; This macro sets up a new context
;; https://www.djcbsoftware.nl/code/mu/mu4e/Contexts-example.html#Contexts-example
(set-email-account! "Main Gmail"
                    ;; is mu4e-maildir automatically inferred? No, but it seems to work
                    ;; without it, at least with a single account.
                    '(;(mu4e-maildir       . "~/.mail/gmail-main")
                      ;; the account-specific subdir (gmail-main) could also be prepended to each of these.
                      (mu4e-sent-folder      . "/sent")
                      (mu4e-drafts-folder    . "/drafts")
                      (mu4e-trash-folder     . "/trash")
                      (mu4e-refile-folder    . "/all") ; could be "Archive"
                      (smtpmail-smtp-user    . "mfclark3690") ; no @gmail.com for Gmail accounts?
                      ;; (user-email-address . "mfclark3690@gmail.com") ; only needed for mu < 1.4
                      ;; (smtpmail-smtp-server  . "smtp.gmail.com") ; This seems to be set automatically.
                      ;; (smtpmail-smtp-service . 587) ;; port 587 for TLS on gmail. the SSL port is 465. The default of 25 works too, though.
                      (mu4e-compose-signature . "Felix Michael Clark, PhD.")
                      )
                    t) ;; this is the default account

(set-email-account! "Secondary Gmail"
                    '(;(mu4e-maildir       . "~/.mail/gmail-secondary")
                      (mu4e-sent-folder      . "/sent")
                      (mu4e-drafts-folder    . "/drafts")
                      (mu4e-trash-folder     . "/trash")
                      (mu4e-refile-folder    . "/all") ; could be "Archive"
                      (smtpmail-smtp-user    . "venustrapsflies") ; no @gmail.com for Gmail accounts?
                      (mu4e-compose-signature . "Felix Clark")
                      )
                    nil)

(provide 'email)
;;; email.el ends here
