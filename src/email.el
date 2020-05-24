;;; email.el --- E-mail configuration
;;; Commentary:
;;; Code:

;; we need to tell where to look for mu4e.el, which was built from tarball.
;; note the path is site-lisp/mu4e, not site-lisp/mu/mu4e.
(add-load-path! "/usr/local/share/emacs/site-lisp/mu4e")

;; outgoing mail can be configured by encrypting ~/.authinfo -> ~/.authinfo.gpg
;; The unencrypted file should be of the following form, although the IMAP lines are
;; probably unecessary since that is configured in .mbsyncrc:
;; machine imap.<server>.com login <email> port 993 password <passwd>
;; machine smtp.<server>.com login <email> port 587 password <passwd>
;; after encrypting (gpg -r <id> -e .authinfo) make sure the permissions are
;; 600 for read/write only for user.

;; possibly:
;; This should only be relevant for queued email. By default it should send immediately.
;; if using smtpmail (defaults to "~/Mail/queue")
(setq smtpmail-queue-dir "~/.mail/queue")
;; the queue dir is set now but is not activated.

;; automatic update interval in seconds can be set with this. nil disables automatic retrieval.
(setq mu4e-update-interval 180)

;; consider mstmp for sending, although this might be outdated.
;; https://www.ict4g.net/adolfo/notes/emacs/reading-imap-mail-with-emacs.html


;; `mu init` must be ran with all addresses specified at once:
;; mu init -v --maildir ~/.mail/ --my-address mfclark3690@gmail.com --my-address venustrapsflies@gmail.com

;; Each path is relative to ~/.mail
;; This macro sets up a new context
;; https://www.djcbsoftware.nl/code/mu/mu4e/Contexts-example.html#Contexts-example


;; This must be last to be the default
(set-email-account! "Main Gmail"
                    ;; is mu4e-maildir automatically inferred? No, but it seems to work
                    ;; without it, at least with a single account.
                    ;; The variable is obsolete.
                    ;; (mu4e-maildir       . "~/.mail/gmail-main")
                    '(;; the account-specific subdir (gmail-main) could also be prepended to each of these.
                      (mu4e-sent-folder       . "/gmail-main/sent")
                      (mu4e-drafts-folder     . "/gmail-main/drafts")
                      (mu4e-trash-folder      . "/gmail-main/trash")
                      (mu4e-refile-folder     . "/gmail-main/all") ; could be "Archive"
                      (smtpmail-smtp-user     . "mfclark3690") ; no @gmail.com for Gmail accounts?
                      ; supposedly only needed for mu < 1.4, but it seems to be required
                      ; to set the "send from" based on the context.
                      (user-mail-address      . "mfclark3690@gmail.com")
                      ; This seems to be set automatically.
                      ;; (smtpmail-smtp-server   . "smtp.gmail.com")
                      ;; This is starttls by default but if it is specified for one
                      ;; address it must be specified for them all.
                      (smtpmail-stream-type   . starttls)
                      ;; The default port of 25 seems to work too, for this account but
                      ;; not all. The SSL port is 465.
                      (smtpmail-smtp-service  . 587)
                      (mu4e-compose-signature . "Felix Michael Clark, PhD.")
                      )
                    t) ;; this is the default account

(provide 'email)
;;; email.el ends here
