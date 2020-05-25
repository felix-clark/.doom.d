;;; attach-python.el --- Attach to a remote python session

;;; Commentary:
;;; Drop this in the root of a containerized application and edit the directories below.
;;; Open and execute it with "SPC m e b".
;;; See https://github.com/emacs-lsp/dap-mode/issues/155

;;; Code:

;; Taken from https://donjayamanne.github.io/pythonVSCodeDocs/docs/debugging_remote-debugging/
;; UNTESTED
(dap-register-debug-template "Python attach remote"
  (list :type "python"
    :name "Python attach (remote debug)"
    :request "attach"
    :localRoot default-directory
    ;; Assumes the project source is in /app in the remote container
    :remoteRoot "/app"
    ;; The default port for remote debugging is usually 5678
    :port 5678
    ;; :secret "debug auth pass phrase"
    ;; This may need tweaking. TRAMP needs the leading /
    :host "/docker:<CONTAINER NAME>"
    ;; perhaps the host should be localhost?
    )
  )

(provide 'attach-python)
;;; attach-python.el ends here
