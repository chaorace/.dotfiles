;;; ~/.doom.d/+scrolling.el -*- lexical-binding: t; -*-

(autoload 'View-scroll-half-page-forward "view")
(autoload 'View-scroll-half-page-backward "view")
(map! :nv "C-d" #'View-scroll-half-page-forward
      :nv "C-u" #'View-scroll-half-page-backward)

(setq scroll-preserve-screen-position 'always)

(advice-add #'View-scroll-half-page-forward :around
            #'cc-indicate-scroll-forward)

(advice-add #'View-scroll-half-page-backward :around
            #'cc-indicate-scroll-backward)

(defun cc-indicate-scroll-get-line (pos)
  (save-excursion
    (goto-char pos)
    (string-to-number (format-mode-line "%l"))))

(defun cc-indicate-scroll (linep f args)
  (let ((linen (cc-indicate-scroll-get-line linep))
        (pulse-flag 't)
        (pulse-iterations 10)
        (pulse-delay 0.03))
    (save-excursion
      (goto-line linen)
      (pulse-momentary-highlight-one-line (point) 'highlight))
    (sit-for 0.05)
    (apply f args)))

(defun cc-indicate-scroll-forward (f &rest args)
  (cc-indicate-scroll (1- (window-end)) f args))

(defun cc-indicate-scroll-backward (f &rest args)
  (cc-indicate-scroll (window-start) f args))
