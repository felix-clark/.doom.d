;;; trello.el --- Org + Trello integration
;;; Code:

;; org-trello use and configuration
;; run org-trello-install-key-and-token and use the *username*, not the account email.
;; To connect a file/buffer to an existing board, run org-trello-install-board-metadata.
(use-package! org-trello
  :when (featurep! :lang org)
  :after org
  :config
  ;; Use org-trello mode for all files in ~/org/trello, resolving symlinks.
  (custom-set-variables '(org-trello-files
                          (mapcar (lambda (file) (or (file-symlink-p file) file))
                                   (directory-files-recursively "~/org/trello" (rx ".org" eos)))))

  ;; do the mapping using doom's map macros.
  ;; See https://org-trello.github.io/bindings.html for command suffixes.
  ;; I'm not sure how to make this smooth with evil mode so this is manual for now.
  ;; Many of these sync functions sync from the file to trello. To sync the other way,
  ;; prefix with the universal argument "<leader> u".
  (map! :localleader
        :map org-trello-mode-map
        ;; perhaps the x can be removed, as some of these are intended to override
        ;; normal org functions (?)
        :prefix ("x" . "trello")
        "v" #'org-trello-version
        "i" #'org-trello-install-key-and-token
        "I" #'org-trello-install-board-metadata
        "u" #'org-trello-update-board-metadata
        "b" #'org-trello-create-board-and-install-metadata
        "d" #'org-trello-check-setup
        "D" #'org-trello-delete-setup
        "c" #'org-trello-sync-card
        "s" #'org-trello-sync-buffer
        ;; This is normally bound to "C-c $" (as opposed to the C-c o $ implied here.).
        ;; perhaps (:localleader "$") would work.
        "$" #'org-trello-archive-card
        "A" #'org-trello-archive-cards
        "g" #'org-trello-abort-sync
        "k" #'org-trello-kill-entity
        "K" #'org-trello-kill-cards
        "a" #'org-trello-assign-me
        "C" #'org-trello-add-card-comment
        ;; with C-u modifier ("SPC u" in evil), the above is supposed to delete.
        ;; #'org-trello-delete-card-comment
        "l" #'org-trello-show-board-labels
        "j" #'org-trello-jump-to-trello-card
        "J" #'org-trello-jump-to-trello-board
        "h" #'org-trello-help-describing-bindings
        ))

(provide 'trello)
