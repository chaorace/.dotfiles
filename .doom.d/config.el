;;; .doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here
(frames-only-mode)
(atomic-chrome-start-server)

;; Word Wrap
(+global-word-wrap-mode +1)
(add-to-list '+word-wrap-disabled-modes 'notmuch-tree-mode)
;;Wrap is already handled by mu4e view
(add-to-list '+word-wrap-disabled-modes 'mu4e-view-mode)

;; Disable autofill
(remove-hook 'text-mode-hook #'auto-fill-mode)

;;Fixes
(setq langtool-java-classpath "/usr/share/languagetool:/usr/share/java/languagetool/*")
(setq plantuml-jar-path "/usr/share/java/plantuml/plantuml.jar")
(setq org-plantuml-jar-path plantuml-jar-path)

;; Appearance
(use-package! doom-themes
  :config
  (setq doom-font "IosevkaEtoile-9")
  (load-theme 'doom-Iosvkem t)
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t)
  (doom-themes-visual-bell-config)
  (doom-themes-treemacs-config)
  (doom-themes-org-config))

(load! "+scrolling")

(defun cc-compose (&rest funs)
  "Return function composed of FUNS."
  (lexical-let ((lex-funs funs))
    (lambda (&rest args)
      (reduce 'funcall (butlast lex-funs)
              :from-end t
              :initial-value (apply (car (last lex-funs)) args)))))

(defun cc-trim-trailing-cr(string)
  (substring string 0 -1)
  )

(defalias 'cc-shell-command-to-string (cc-compose 'cc-trim-trailing-cr 'shell-command-to-string))

(defun cc-intersperse(seperator strings)
  (seq-reduce
   (lambda (x y)
     (concat x seperator y))
   strings
   ""))

(defun cc-lpass(&rest args)
  (cc-shell-command-to-string
   (cc-intersperse
    " "
    (cons
     "lpass"
     args))))

(defalias 'cc-lpass-user (apply-partially 'cc-lpass "show" "--username"))
(defalias 'cc-lpass-pass (apply-partially 'cc-lpass "show" "--password"))
(setq cc-lpass-work-email "Business/microsoftonline.com")
(setq cc-lpass-home-email "auth/gmail-app")
(defalias 'cc-fetch-work-email (apply-partially 'cc-lpass-user cc-lpass-work-email))
(defalias 'cc-fetch-work-password (apply-partially 'cc-lpass-pass cc-lpass-work-email))
(defalias 'cc-fetch-home-email (apply-partially 'cc-lpass-user cc-lpass-home-email))
(defalias 'cc-fetch-home-password (apply-partially 'cc-lpass-pass cc-lpass-home-email))

;;Mail
(setq user-full-name  "Christopher Crockett")
(setq smtpmail-smtp-service 587)
(setq mail-user-agent 'mu4e-user-agent)

(add-to-list 'load-path "/usr/share/emacs/site-lisp/mu4e")
(def-package! mu4e
  :commands mu4e~proc-view mu4e-update-index
  :init
  (provide 'html2text) ; disable obsolete package
  (setq mu4e-maildir "~/.mail"
        mu4e-attachment-dir "~/.mail/.attachments")
  (defun mu4e-quit()
    "Quit the mu4e session."
    (interactive)
    (if mu4e-confirm-quit
      (when (y-or-n-p (mu4e-format "Are you sure you want to quit?"))
      (mu4e~stop))
      (mu4e~stop))
    (switch-to-buffer notmuch-last-tree))

  (mu4e-update-index)
  :config
  (setq mu4e-update-interval nil
        mu4e-view-show-addresses t
        mu4e-sent-messages-behavior 'sent
        mu4e-hide-index-messages t
        ;; try to show images
        mu4e-view-show-images t
        mu4e-view-image-max-width 800
        ;; configuration for sending mail
        message-send-mail-function #'smtpmail-send-it
        message-kill-buffer-on-exit t ; close after sending
        ;; use helm/ivy
        mu4e-completing-read-function
        (cond ((featurep! :completion ivy) #'ivy-completing-read)
              ((featurep! :completion helm) #'completing-read)
              (t #'ido-completing-read))

        ;; no need to ask
        mu4e-confirm-quit nil
        ;; Make the email fields more outlook-like while viewing
        mu4e-view-fill-headers nil
        mu4e-view-fields '(:from :date :to  :cc :subject)
        mu4e-view-auto-mark-as-read nil
        )


  (setq mu4e-contexts
        `( ,(make-mu4e-context
             :name "work"
             :match-func (lambda (msg)
                           (when msg
                             (string-match-p "^/work" (mu4e-message-field msg :maildir))))
             :vars '((user-mail-address . (funcall 'cc-fetch-work-email))
                     (smtpmail-smtp-user . (funcall 'cc-fetch-work-email))
                     (smtpmail-smtp-server . "smtp.office365.com")
                     (mu4e-sent-folder . "/work/Sent Items")
                     (mu4e-drafts-folder . "/work/Drafts")
                     (org-msg-signature . (with-temp-buffer
                                            (insert-file-contents "~/.doom.d/mail/signature.org")
                                            (buffer-string)))))
           ,(make-mu4e-context
             :name "home"
             :match-func (lambda (msg)
                           (when msg
                             (string-match-p "^/gmail" (mu4e-message-field msg :maildir))))
             :vars '((user-mail-address . (funcall 'cc-fetch-home-email))
                     (smtpmail-smtp-user . (funcall 'cc-fetch-home-email))
                     (smtpmail-smtp-server . "smtp.gmail.com")
                     (mu4e-sent-folder . "/gmail/[Gmail]/Sent Mail")
                     (mu4e-drafts-folder . "/gmail/[Gmail]/Drafts")
                     (org-msg-signature . "")
                     ))))

  (setq mu4e-compose-complete-ignore-address-regexp
        "\\(no-?reply\\|adcom$\\|adcomolu\\|adcsolu\\|adcomso$\\|adcomsolutions.co$\\|adcomsoulutions\\|adcomsolutons\\)")
  (when (featurep! :tools flyspell)
    (add-hook 'mu4e-compose-mode-hook #'flyspell-mode))

  (add-hook 'mu4e-compose-mode-hook #'mu4e~request-contacts-maybe)

  ;; Wrap text in messages
  (setq-hook! 'mu4e-view-mode-hook truncate-lines nil)

  (when (fboundp 'imagemagick-register-types)
    (imagemagick-register-types))

  (setq mu4e-split-view 'single-window)
  )

(use-package! org-mu4e
  :commands org-mu4e-store-and-capture
  :init
  (map! :localleader
        :map mu4e-view-mode-map
        "c" 'org-mu4e-store-and-capture
        )
  )

(setq org-msg-options "html-postamble:nil H:5 num:nil ^:{} toc:nil")
(setq org-msg-startup "hidestars indent inlineimages")
;;(setq org-msg-greeting-fmt "\nHi %s,\n\n") TODO: Base response on time of day
(setq org-msg-greeting-fmt-mailto t)
(setq org-msg-enforce-css "~/.doom.d/mail/signature.css")

(def-package! htmlize)
(def-package! org-msg
  :after htmlize
  :load-path "/home/chao/.emacs.d/.local/straight/build/org-msg"
  :config
  (org-msg-mode)
  (add-hook 'org-msg-edit-mode-hook (defun cc-add-cc() (save-excursion
                                                         (message-add-header "Cc: Network Operations <noc@adcomsolutions.com>\n"))))
  (map! :map org-msg-edit-mode-map
        :n "G" #'org-msg-goto-body))

(setq ssh-directory-tracking-mode nil)
(load! "packages/ssh.el")
(load! "packages/powershell-mode.el")

(defun cisco-yank()
  (interactive)
  "Cisco stuff"
  (kill-new (buffer-substring
             (save-excursion
                (re-search-backward "sh clock")
                )
              (line-end-position))))

(map! :map ssh-mode :leader "y c" #'cisco-yank)
(map! :leader "w SPC" #'+popup/raise)

(defun dothenkillbuffer(fn buffer)
  (funcall fn)
  (kill-buffer buffer)
  )
(defun searchtotree()
  (dothenkillbuffer 'notmuch-tree-from-search-current-query (current-buffer))
  )

(def-package! notmuch
  :commands notmuch-poll
  :after mu4e)

(defun cc-kill-thread() (interactive)(notmuch-tree-tag-thread (list "+killed")))
(defun cc-unkill-thread() (interactive)(notmuch-tree-tag-thread (list "-killed")))

(after! notmuch
  (setq notmuch-saved-searches
        '((:name "inbox"   :query "tag:work/Inbox not tag:trash not tag:killed" :key "i")
          (:name "home inbox"   :query "tag:gmail/Inbox not tag:trash not tag:killed" :key "I")
          (:name "sent"    :query "tag:\"work/Sent Items\""                :key "s")
          (:name "flagged" :query "tag:flagged"             :key "f")
          (:name "me"      :query "tag:work/Inbox/Me not tag:trash not tag:killed"       :key "m")
          (:name "related" :query "tag:work/Inbox/Me/Related not tag:trash not tag:killed" :key "r")
          (:name "drafts"  :query "tag:draft"               :key "d")))
  (add-hook 'notmuch-search-hook 'searchtotree)
  (setq notmuch-mua-user-agent-function 'mu4e-user-agent)
  (setq mail-user-agent 'mu4e-user-agent)
  (setq notmuch-tree-show-out 't)
  (map! :map notmuch-tree-mode-map
        :nv "DEL" #'cc-kill-thread
        :nv "g r" #'notmuch-poll-and-refresh-this-buffer
        :nv "c" nil
        :nv "c" #'mu4e-compose-new)
  (defun notmuch-tree-show-message-out()
    (setq notmuch-last-tree (current-buffer))
    (mu4e~proc-view(car (last (split-string
                               (notmuch-show-get-message-id)
                               ":"))) 't 'f)))

(def-package! org-protocol-capture-html :after org-protocol)

(setq org-agenda-files '("~/org/gtd/inbox.org"
                         "~/org/gtd/gtd.org"
                         "~/org/gtd/tickler.org"))

(setq org-capture-templates '(("t" "Todo [inbox]" entry
                               (file+headline "~/org/gtd/inbox.org" "Tasks")
                               "* TODO %i%?")
                              ("m" "Todo from mail [inbox]" entry
                               (file+headline "~/org/gtd/inbox.org" "Tasks")
                               "* TODO %i%? \n %a")
                              ("T" "Tickler" entry
                               (file+headline "~/org/gtd/tickler.org" "Tickler")
                               "* %i%? \n %U")
                              ("j" "Journal" entry (file+datetree "~/org/journal.org")
                               "* %?\nEntered on %U\n  %i\n  %a")
                              ("w" "Web site" entry
                               (file+headline "~/org/gtd/inbox.org" "Tasks")
                               "* %a :website:\n\n%?\n\n%:initial")
                              ("c" "Ticket" entry
                               (file+headline "~/org/gtd/inbox.org" "Tickets")
                               "* TODO %a \n%?%:initial")
                              ))

(setq org-refile-targets '(("~/org/gtd/gtd.org" :maxlevel . 3)
                           ("~/org/gtd/someday.org" :level . 1)
                           ("~/org/gtd/tickler.org" :maxlevel . 2)
                           ("~/org/gtd/reference.org" :maxlevel . 10)))

(setq org-refile-allow-creating-parent-nodes 'confirm)

(advice-add 'org-refile :after
        (lambda (&rest _)
        (org-save-all-org-buffers)))

(setq org-todo-keywords '((sequence "TODO(t)" "WAIT(w)" "|" "DONE(d)" "DEAD(D)")))

(setq org-agenda-custom-commands
        '(("w" "Work tasks" tags-todo "@work"
           ((org-agenda-overriding-header  "Work" )
            (org-agenda-skip-function #'cc-org-agenda-skip-all-siblings-but-first)))
          ("h" "Home tasks" tags-todo "@home"
           ((org-agenda-overriding-header  "Home" )
            (org-agenda-skip-function #'cc-org-agenda-skip-all-siblings-but-first)))
          ("c" "Chores" tags-todo "@chores"
           ((org-agenda-overriding-header  "Chores" )
            (org-agenda-skip-function #'cc-org-agenda-skip-all-siblings-but-first)))
          ("o" "Shopping" tags-todo "shopping"
           ((org-agenda-overriding-header  "Shopping" )
            (org-agenda-skip-function #'cc-org-agenda-skip-all-siblings-but-first)))
          ))

(defun cc-org-current-is-todo ()
  (string= "TODO" (org-get-todo-state)))

(defun cc-org-agenda-skip-all-siblings-but-first ()
  "Skip all but the first non-done entry."
  (let (should-skip-entry)
    (unless (cc-org-current-is-todo)
      (setq should-skip-entry t))
    (save-excursion
      (while (and (not should-skip-entry) (org-goto-sibling t))
        (when (cc-org-current-is-todo)
          (setq should-skip-entry t))))
    (when should-skip-entry
      (or (outline-next-heading)
            (goto-char (point-max))))))

(after! org
  (map! :map org-mode-map
        :localleader "Q" #'org-change-tag-in-region))

(setq org-image-actual-width 400)

(setq shell-prompt-pattern "^[^#$%>λ\n]*[#$%>λ] *")
(setq comint-prompt-read-only 't)
(setenv "PAGER" "cat")
(setq comint-output-filter-functions
      (remove 'ansi-color-process-output comint-output-filter-functions))
(setq comint-terminfo-terminal "xterm-256color")
(add-hook 'shell-mode-hook
          (defun shell-colors-fix ()
            (add-hook 'comint-preoutput-filter-functions 'xterm-color-filter nil t)))

(def-package! native-complete
  :config
  (native-complete-setup-bash)
  (add-hook 'shell-mode-hook
            (defun shell-native-completion ()
              (push 'company-native-complete company-backends))))

(def-package! comint-intercept
  :init
  (add-hook 'shell-mode-hook 'comint-intercept-mode)
  :config
  (setq comint-intercept-prompt-regexp shell-prompt-pattern)
  (setq comint-intercept-term-commands
        '("top" "less" "vim")))

;;Elfeed
(after! elfeed
  (setq elfeed-search-filter "@2-week-ago -youtube")
  (add-hook 'elfeed-show-mode-hook 'mixed-pitch-mode)
  (setq elfeed-show-entry-switch #'switch-to-buffer)
  )

;;Popups
(after! popups
  (set-popup-rule! "^\\*WoMan" :ignore t)
  )

;;Modeline
(def-package! battery
  :config
  (when (and battery-status-function
            (not (string-match-p "N/A"
                                  (battery-format "%B"
                                                  (funcall battery-status-function)))))
    (display-battery-mode 1))
  )

(load! "+spotify")
