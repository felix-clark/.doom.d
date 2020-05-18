;;; launch-chrome.el --- DAP launch configuration for chrome

;;; Commentary:
;;; This template can be dropped into the root of a js/ts application, where it can be
;;; executed with "SPC m e b". As of now it must be in root to resolve
;;; default-directory.

;;; Code:

(dap-register-debug-template "Chrome launch"
  (list :type "chrome"
    :name "Chrome launch"
    :request "launch"
    :mode "url"
    :url "http://localhost:4200"
    ;; should this be in src/? (apparently not, although resolving to the project directory is probably better)
    :webRoot default-directory
    )
  )

;; UNTESTED: attach to a running chrome process. This process must enable the debug port when launched:
;; chrome --remote-debugging-port 9222
(dap-register-debug-template "Chrome attach"
  (list :type "chrome"
    :name "Chrome attach (port 9222)"
    :request "attach"
    :port 9222
    :url "http://localhost:4200"
    :webRoot default-directory
    )
  )

(provide 'launch-chrome)
;;; launch-chrome.el ends here
