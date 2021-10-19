;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.

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
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-zenburn)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")
;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type `relative)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
;;
;;Keybindings
(map! :leader
      (:prefix-map ("i" . "insert")
       :desc "Insert Bible verse" "b" #'dtk-bible)
      (:prefix-map ("T" . "Time")
       ;; Timeclock keybindings
       :desc "Clock In" "i" #'timeclock-in
       :desc "Clock Out" "o" #'timeclock-out
       :desc "Remaining Time in Workday" "r" #'timeclock-workday-remaining-string
       :desc "When to leave" "w" #'timeclock-when-to-leave-string
       ;; Timestamp related bindings
       :desc "Insert Timestamp" "I" #'org-time-stamp)
      (:prefix-map ("j" . "journal")
       :desc "Create new journal entry" "j" #'org-journal-new-entry
       :desc "Open previous entry" "p" #'org-journal-open-previous-entry
       :desc "Open next entry" "n" #'org-journal-open-next-entry
       :desc "Search journal" "s" #'org-journal-search-forever)
      (:prefix-map ("r" . "Ranger/Neotree")
       :desc "Open Ranger in Current Directory" "r" #'ranger
       :desc "Toggle Neotree" "n" #'neotree-toggle))




;; Org Roam config
(use-package org-roam
  :ensure t
  :custom
  (org-roam-directory "~/org/roam")
  :config
  (org-roam-setup))

(use-package org-roam-bibtex
  :after org-roam
  :config
  (require 'org-ref))

;; Mu4e config

(use-package mu4e
  :ensure t
  ;; :load-path "/usr/share/emacs/site-lisp/mu4e"
  :config

  ;; This is set to 't' to avoid mail syncing issues when using mbsync
  (setq mu4e-change-filenames-when-moving t)

  ;; Refresh mail using isync every 10 minutes
  (setq mu4e-update-interval (* 10 60))
  (setq mu4e-get-mail-command "mbsync -a")
  (setq mu4e-root-maildir "~/.mail")
  (setq mu4e-context-policy 'pick-first)
  (setq mu4e-compose-context-policy 'always-ask)
  (setq mu4e-compose-format-flowed t)

  ;;Configure function for sending mail
  (setq message-send-mail-function 'smtpmail-send-it)

  (setq mu4e-contexts
        (list
         ;;GMAIL Account
         (make-mu4e-context
          :name "Gmail"
          :match-func
          (lambda (msg)
            (when msg
              (string-prefix-p "/GMail" (mu4e-message-field msg :maildir))))
          :vars '((user-mail-address . "josephraub98@gmail.com")
                  (user-full-name . "Joseph Raub")
                  (smtpmail-smtp-server . "smtp.gmail.com")
                  (smtpmail-smtp-service . 465)
                  (smtpmail-stream-type . ssl)
                  (mu4e-drafts-folder . "/GMail/[Gmail].Drafts")
                  (mu4e-sent-folder . "/GMail/[Gmail].Sent Mail")
                  (mu4e-refile-folder . "/GMail/[Gmail].All Mail")
                  (mu4e-trash-folder . "/GMail/[Gmail].Trash")
                  (mu4e-maildir-shortcuts . (("/GMail/Inbox"             . ?i)
                                             ("/GMail/[Gmail].Sent Mail" . ?s)
                                             ("/GMail/[Gmail].Trash"     . ?t)
                                             ("/GMail/[Gmail].Drafts"    . ?d)
                                             ("/GMail/[Gmail].All Mail" . ?a)))))

         (make-mu4e-context
          :name "NHBC"
          :match-func
          (lambda (msg)
            (when msg
              (string-prefix-p "/NHBC" (mu4e-message-field msg :maildir))))
          :vars '((user-mail-address . "jraub@nhbcwylie.org")
                  (user-full-name . "Joseph Raub")
                  (smtpmail-smtp-server . "smtp.gmail.com")
                  (smtpmail-smtp-service . 465)
                  (smtpmail-stream-type . ssl)
                  (mu4e-drafts-folder . "/NHBC/[Gmail].Drafts")
                  (mu4e-sent-folder . "/NHBC/[Gmail].Sent Mail")
                  (mu4e-refile-folder . "/NHBC/[Gmail].All Mail")
                  (mu4e-trash-folder . "/NHBC/[Gmail].Trash")
                  (mu4e-compose-signature . "")
                  (mu4e-maildir-shortcuts . (("/NHBC/Inbox"             . ?i)
                                             ("/NHBC/[Gmail].Sent Mail" . ?s)
                                             ("/NHBC/[Gmail].Trash"     . ?t)
                                             ("/NHBC/[Gmail].Drafts"    . ?d)
                                             ("/NHBC/[Gmail].All Mail" . ?a))))))))

(use-package org-mime
  :ensure t
  :config
  (setq org-mime-export-options '(:section-numbers nil
                                  :with-author nil
                                  :with-toc nil)))


  (use-package alert
  :commands (alert)
  :init
  (setq alert-default-style 'notifier))

(use-package! websocket
  :after org-roam)

(use-package! org-roam-ui
  :after org-roam
  :hook (after-init . org-roam-ui-mode)
  :config
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t;
        org-roam-ui-open-on-start nil))

(use-package dtk
  :custom
  (dtk-module "KJV")
  (dtk-module-category "Biblical Texts")
  (dtk-word-wrap t)
  (dtk-compact-view nil))

(use-package timeclock
  :custom
  (timeclock-file "~/ledger/timelog")
  (timeclock-project-list '("NHBC")))

(use-package org-journal
  :custom
  (org-journal-dir "~/org/journal/")
  (org-journal-find-file 'find-file)
  (org-journal-enable-encryption t)
  (org-journal-file-type 'monthly))

;; (use-package org-super-agenda
;;   :after org-agenda
;;   :init
;;   (setq org-agenda-skip-scheduled-if-done t
;;         org-agenda-skip-deadline-if-done t
;;         org-agenda-include-deadlines t
;;         org-agenda-block-separator nil
;;         org-agenda-compact-blocks t
;;         org-agenda-start-day nil
;;         org-agenda-span 1
;;         org-agenda-start-on-weekday nil)
;;   (setq org-agenda-custom-commands
;;         '(("c" "Super view"
;;            ((agenda "" ((org-agenda-overriding-header "")
;;                         (org-super-agenda-groups
;;                          '((:name "Today"
;;                             :time-grid t
;;                             :date today
;;                             :order 1)))))
;;             (alltodo "" ((org-agenda-overriding-header "")
;;                          (org-super-agenda-groups
;;                           (:auto-tags t))))))))
;;   :config
;;   (org-super-agenda-mode))


(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (ledger . t)
   (python . t)
   (sh . t)))

;; (require 'org)
;; (require 'org-habit)
;; (add-to-list 'org-modules "org-habit")
;; (setq org-habit-preceding-days 7
;;       org-habit-following-days 1
;;       org-habit-graph-column 80
;;       org-habit-show-habits-only-for-today t
;;       org-habit-show-all-today t)

(ranger-override-dired-mode t)

; Display Battery status in modeline
(unless (equal "Battery status not available"
               (battery))
  (display-battery-mode 1))

; Maximize window
(if (eq initial-window-system 'x)
    (toggle-frame-maximized)
  (toggle-frame-fullscreen))

(use-package lsp-mode
  :ensure
  :commands lsp
  :custom
  (lsp-rust-analyzer-cargo-watch-command "clippy")
  (lsp-eldoc-render-all t)
  (lsp-idle-delay 0.6)
  (lsp-rust-analyzer-server-display-inlay-hints t)
  :config
  (add-hook 'lsp-mode-hook 'lsp-ui-mode))

(use-package lsp-ui
  :ensure
  :commands lsp-ui-mode
  :custom
  (lsp-ui-peek-always-show t)
  (lsp-ui-sideline-show-hover t)
  (lsp-ui-doc-enable nil))

(use-package company
  :ensure
  :custom
  (company-idle-delay 0.5))

(use-package flycheck :ensure)

(use-package rustic
  :ensure
  :config
  (setq rustic-format-on-save nil)
  (add-hook 'rustic-mode-hok 'rk/rustic-mode-hook))

(defun rk/rustic-mode-hook ()
  (when buffer-file-name
    (setq-local buffer-save-without-query)))

(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))
