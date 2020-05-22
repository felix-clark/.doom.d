;;; email.el --- E-mail configuration
;;; Commenary:
;;; Code:

;; we need to tell where to look for mu4e.el, which was built from tarball.
;; note the path is site-lisp/mu4e, not site-lisp/mu/mu4e.
(add-load-path! "/usr/local/share/emacs/site-lisp/mu4e")

;; TODO: move to separate file
;; Each path is relative to ~/.mail
;; for multiple accounts, contexts should be set up.
;; https://www.djcbsoftware.nl/code/mu/mu4e/Contexts-example.html#Contexts-example
(set-email-account! "Gmail main"
                    '((mu4e-sent-folder   . "/sent")
                      (mu4e-drafts-folder . "/drafts")
                      (mu4e-trash-folder  . "/trash")
                      (mu4e-refile-folder . "/all") ; could be "Archive"
                      (smtpmail-smtp-user . "mfclark3690") ; no @gmail.com for Gmail accounts?
                      (user-email-address . "mfclark3690@gmail.com")
                      (mu4e-compose-signature . "---\nFelix Michael Clark")
                      )
                    )

(provide 'email)
;;; email.el ends here
