;; -*- no-byte-compile: t; -*-
;;; .doom.d/packages.el

;;; Examples:
;; (package! some-package)
;; (package! another-package :recipe (:host github :repo "username/repo"))
;; (package! builtin-package :disable t)
(disable-packages! undo-tree )
(package! atomic-chrome)
(package! mu4e)
(package! htmlize)
(package! org-msg)
(package! doom-themes)
(package! frames-only-mode)
(package! undo-propose)
(package! undo-redo :recipe (:host github :repo "clemera-dev/undo-redo"))
(package! xterm-color)
