;;; .doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here
(atomic-chrome-start-server)

;; Appearance
(set-face-attribute 'default nil :font "OpenDyslexicMono-9" )
(after! doom-themes
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t)
  (load-theme 'doom-solarized-dark  t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)

  ;; Enable custom neotree theme (all-the-icons must be installed!)
  (doom-themes-neotree-config)

  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

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
(defalias 'cc-fetch-work-email (apply-partially 'cc-lpass-user cc-lpass-work-email))
(defalias 'cc-fetch-work-password (apply-partially 'cc-lpass-pass cc-lpass-work-email))

;;Mail
(setq user-mail-address (funcall 'cc-fetch-work-email)
      user-full-name  "Christopher Crockett")

(setq smtpmail-smtp-server "smtp.office365.com"
      smtpmail-smtp-service 587
      smtpmail-smtp-user (funcall 'cc-fetch-work-email)
      send-mail-function 'smtpmail-send-it
      message-send-mail-function 'smtpmail-send-it)

(setq mail-user-agent 'mu4e-user-agent)
(setq mu4e-sent-folder "/work/Sent Items")
(setq mu4e-drafts-folder "/work/Drafts")

(def-package! mu4e
  :commands mu4e~proc-view mu4e-update-index
  :init
  (provide 'html2text) ; disable obsolete package
  (setq mu4e-maildir "~/.mail"
        mu4e-attachment-dir "~/.mail/.attachments")
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
        (setq mu4e-compose-complete-ignore-address-regexp
              "\\(no-?reply\\|adcom$\\|adcomolu\\|adcsolu\\|adcomso$\\|adcomsolutions.co$\\|adcomsoulutions\\|adcomsolutons\\)")

        ;; no need to ask
        mu4e-confirm-quit nil
        ;; Make the email fields more outlook-like while viewing
        mu4e-view-fill-headers nil
        mu4e-view-fields
        '(:from :date :to  :cc :subject))

  (when (featurep! :tools flyspell)
    (add-hook 'mu4e-compose-mode-hook #'flyspell-mode))

  (add-hook 'mu4e-compose-mode-hook #'mu4e~request-contacts)

  ;; Wrap text in messages
  (setq-hook! 'mu4e-view-mode-hook truncate-lines nil)

  (when (fboundp 'imagemagick-register-types)
    (imagemagick-register-types))

  (map! :map mu4e-compose-mode-map
        :desc "send and exit" "s" #'message-send-and-exit
        :desc "kill buffer"   "d" #'message-kill-buffer
        :desc "save draft"    "S" #'message-dont-send
        :desc "attach"        "a" #'mail-add-attachment)
  (setq mu4e-split-view 'single-window)
  )

(setq org-msg-options "html-postamble:nil H:5 num:nil ^:{} toc:nil")
(setq org-msg-startup "hidestars indent inlineimages")
;;(setq org-msg-greeting-fmt "\nHi %s,\n\n") TODO: Base response on time of day
(setq org-msg-greeting-fmt-mailto t)
(setq org-msg-signature (with-temp-buffer
        (insert-file-contents "~/.doom.d/mail/signature.org")
        (buffer-string)))
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
  :commands notmuch-poll)

(after! notmuch
  (setq notmuch-saved-searches
        '((:name "inbox"   :query "tag:work/Inbox not tag:trash" :key "i")
          (:name "sent"    :query "tag:\"work/Sent Items\""                :key "s")
          (:name "flagged" :query "tag:flagged"             :key "f")
          (:name "me"      :query "tag:work/Inbox/Me"       :key "m")
          (:name "related" :query "tag:work/Inbox/Me/Related" :key "r")
          (:name "drafts"  :query "tag:draft"               :key "d")))
  (add-hook 'notmuch-search-hook 'searchtotree)
  (setq notmuch-mua-user-agent-function 'mu4e-user-agent)
  (setq mail-user-agent 'mu4e-user-agent)
  (setq notmuch-tree-show-out 't)
  (map! :map notmuch-tree-mode-map
        :nv "c" nil
        :nv "c" #'mu4e-compose-new)
  (defun notmuch-tree-show-message-out()
    (mu4e~proc-view(car (last (split-string
                               (notmuch-show-get-message-id)
                               ":"))) 't 'f)))
