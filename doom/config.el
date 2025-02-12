(defun efs/org-babel-tangle-config()
  (when (string-equal (file-name-directory (buffer-file-name))
                      (expand-file-name "~/dotfiles/doom/"))
    (let ((org-confirm-babel-evaluate nil))
      (org-babel-tangle))))

(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 16)
      doom-variable-pitch-font (font-spec :family "JetBrainsMono Nerd Font" :size 18))

(setq doom-theme 'gruvbox-dark-hard)
(setq doom-themes-treemacs-theme "doom-colors")

(set-frame-parameter (selected-frame) 'alpha '(92 . 90))
(add-to-list 'default-frame-alist '(alpha . (92 . 90)))

(setq display-line-numbers-type t)

;; nohlsearch is baked into my brain
(map! :leader
      :desc "nohlsearch"
      "s c " #'evil-ex-nohighlight)
;; Org Mode update all dblocks TODO: Change this to only apply to org mode
(map! :map org-mode-map
      :leader
      :desc "Update All Dblocks"
      "m u" #'org-update-all-dblocks)
;; Comment the damn line
(map! :leader
      :desc "Comment Line"
      "c l " #'comment-line)
;; Left and Right move to linting errors
(map! :n "<left>" #'flycheck-previous-error)
(map! :n "<right>" #'flycheck-next-error)

;; Credit to https://github.com/Vidianos-Giannitsis
(setq counsel-linux-app-format-function 'counsel-linux-app-format-function-name-pretty)
 (defun emacs-run-launcher ()
   "Create and select a frame called emacs-run-launcher which consists only of a minibuffer and has specific dimensions. Run counsel-linux-app on that frame, which is an emacs command that prompts you to select an app and open it in a dmenu like behaviour. Delete the frame after that command has exited"
   (interactive)
   (custom-set-variables
   '(ivy-fixed-height-minibuffer nil))
   (with-selected-frame (make-frame '((name . "emacs-run-launcher")
				       (minibuffer . only)
				       (width . 120)
				       (height . 11)))
     (unwind-protect
	  (counsel-linux-app)
	(delete-frame))))

(setq evil-split-window-right t)
(setq evil-split-window-below t)

(setq auth-sources '("~/.authinfo"))

;; (setq tide-tsserver-process-environment '("TSS_LOG=-level verbose -file /tmp/tss.log"))
(add-hook 'js2-mode-hook 'eslintd-fix-mode)
(require 'dap-node)
(setq dap-node-debug-program "~/tools/vscode-node-debug2/out/src/nodeDebug.js")
;; (setq lsp-log-io t)
(setq dap-print-io t)
(dap-register-debug-template
  "Attach to node process "
  (list :type "node"
        :request "attach"
        :program "__ignored"
        :port 9230
        :name "Attach to node process in docker container"))
 ;(defun you-track-integration ()
  ;(interactive)
  ;(insert (shell-command-to-string (format "python3 %s" buffer-file-name))))

(setq org-directory "~/notes/org/")
(setq org-log-done 'time)
(setq org-log-into-drawer t)
(setq org-agenda-start-with-log-mode t)

(setq org-agenda-files
'("~/notes/org/habit.org"
  "~/notes/org/todo.org"
  "~/notes/org/notes.org"
  "~/notes/org/organizer.org"
  "~/notes/org/projects.org"
  "~/notes/org/schedule.org"
  "~/notes/org/standups.org"))

(defun make-youtrack-link (yt_id)
  (browse-url (concat "https://growmies.myjetbrains.com/youtrack/issue/GA-" yt_id)))
(after! org
  ;; Org Habit
  (require 'org-habit)
  (add-to-list 'org-modules 'org-habit)
  (setq org-habit-graph-column 60)
  ;; Replace list hyphen with dot
  (defun efs/org-font-setup ()
  (font-lock-add-keywords 'org-mode
                          '(("^ *\\([-]\\) "
                          (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•")))))))
  ;; Set faces for heading levels
  (dolist (face '((org-level-1 . 1.5)
                  (org-level-2 . 1.3)
                  (org-level-3 . 1.1)
                  (org-level-4 . 1.0)
                  (org-level-5 . 0.9)
                  (org-level-6 . 0.9)
                  (org-level-7 . 0.9)
                  (org-level-8 . 0.9)))
  (set-face-attribute (car face) nil :font "JetBrainsMono Nerd Font" :weight 'regular :height (cdr face)))
  (setq org-ellipsis " ▾")
  (org-add-link-type "youtrack" #'make-youtrack-link))

;; Loads ox-gfm for github flavored markdown exports
(eval-after-load "org"
  '(require 'ox-gfm nil t))

;; Each path is relative to the path of the maildir you passed to mu
(set-email-account! "moatcozza@gmail.com"
  '((mu4e-sent-folder       . "/gmail/Sent Mail")
    (mu4e-drafts-folder     . "/gmail/Drafts")
    (mu4e-trash-folder      . "/gmail/Trash")
    (mu4e-refile-folder     . "/gmail/All Mail")
    (smtpmail-smtp-user     . "moatcozza@gmail.com")
    (mu4e-compose-signature . "---\nJimmy Cozza"))
  t)

;; if "gmail" is missing from the address or maildir, the account must be listed here
(setq +mu4e-gmail-accounts '(("moatcozza@gmail.com" . "/moatcozza")))

;; don't need to run cleanup after indexing for gmail
(setq mu4e-index-cleanup nil
      ;; because gmail uses labels as folders we can use lazy check since
      ;; messages don't really "move"
      mu4e-index-lazy-check t)
