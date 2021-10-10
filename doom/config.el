(setq doom-font (font-spec :family "GoMono Nerd Font" :size 16)
      doom-variable-pitch-font (font-spec :family "GoMono Nerd Font" :size 16))

(setq doom-theme 'gruvbox-dark-soft)
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

;; Setting a TODO to DONE sets a Closed timestamp
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
  (set-face-attribute (car face) nil :font "GoMono Nerd Font" :weight 'regular :height (cdr face)))
  (setq org-ellipsis " ▾")
  (org-add-link-type "youtrack" #'make-youtrack-link))

;; Loads ox-gfm for github flavored markdown exports
(eval-after-load "org"
  '(require 'ox-gfm nil t))

(defun efs/exwm-update-class ()
  (exwm-workspace-rename-buffer exwm-class-name))

(use-package exwm
  :config
  ;; Set the default number of workspaces
  (setq exwm-workspace-number 5)

  ;; When window "class" updates, use it to set the buffer name
  ;; (add-hook 'exwm-update-class-hook #'efs/exwm-update-class)

  ;; These keys should always pass through to Emacs
  (setq exwm-input-prefix-keys
    '(?\C-x
      ?\C-u
      ?\C-h
      ?\M-x
      ?\M-`
      ?\M-&
      ?\M-:
      ?\C-\M-j  ;; Buffer list
      ?\C-\ ))  ;; Ctrl+Space

  ;; Ctrl+Q will enable the next key to be sent directly
  (define-key exwm-mode-map [?\C-q] 'exwm-input-send-next-key)

  ;; Set up global key bindings.  These always work, no matter the input state!
  ;; Keep in mind that changing this list after EXWM initializes has no effect.
  (setq exwm-input-global-keys
        `(
          ;; Reset to line-mode (C-c C-k switches to char-mode via exwm-input-release-keyboard)
          ([?\s-r] . exwm-reset)

          ;; Move between windows
          ([s-left] . windmove-left)
          ([s-right] . windmove-right)
          ([s-up] . windmove-up)
          ([s-down] . windmove-down)

          ;; Launch applications via shell command
          ([?\s-&] . (lambda (command)
                       (interactive (list (read-shell-command "$ ")))
                       (start-process-shell-command command nil command)))

          ;; Switch workspace
          ([?\s-w] . exwm-workspace-switch)

          ;; 's-N': Switch to certain workspace with Super (Win) plus a number key (0 - 9)
          ,@(mapcar (lambda (i)
                      `(,(kbd (format "s-%d" i)) .
                        (lambda ()
                          (interactive)
                          (exwm-workspace-switch-create ,i))))
                    (number-sequence 0 9))))

  (exwm-enable))
