; trying to keep one frame with one window for text and other frame with
; one console for debug. Almost without success...
; Trying don't split windows (now it creates new frames...
; little better but still "fucking idiocy")
(setq split-window-preferred-function nil)
(setq display-buffer-reuse-frames t)
(setq pop-up-windows nil)
(setq pop-up-frames nil)
; window splitting disabled, and fun below is nil. So can't create frame
; to jump on tags
;(setq pop-up-frame-function nil)

; try:
;(setq same-window-regexps '(".*")) ; or "."?
; same-window-buffer-names and/or same-window-regexps and same-window-p
; special-display-buffer-names, speical-display-regexps,
; special-display-function, display-buffer-function.

(defalias 'yes-or-no-p 'y-or-n-p)
(put 'upcase-region 'disabled nil)
(setq-default indent-tabs-mode nil)
(tabbar-mode t)
(recentf-mode 1)
(setq-default show-trailing-whitespace t)
(setq
    tab-width 4
    echo-keystrokes 0.1
    mouse-yank-at-point t
    tabbar-local-mode t
    case-fold-search t
    completion-ignore-case t
    read-file-name-completion-ignore-case t
    read-buffer-completion-ignore-case t
)
(show-ws-toggle-show-tabs)
;(toggle-show-trailing-whitespace-show-ws)
(set-default 'indicate-empty-lines t)

;; scroll one line at a time (less "jumpy" than defaults)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-step 1) ;; keyboard scroll one line at a time

(add-to-list 'load-path "~/.emacs.d/share/misc/elisp")

(require 'evil-numbers)
(global-set-key (kbd "C-c +") 'evil-numbers/inc-at-pt)
(global-set-key (kbd "C-c -") 'evil-numbers/dec-at-pt)

(require 'dired+)
(require 'thingatpt+)
(require 'smooth-scroll)
(smooth-scroll-mode t)
(global-set-key [(control  down)]  'scroll-up-1)
(global-set-key [(control  up)]    'scroll-down-1)

; make window dedicated (one-way function)
(require 'sticky-windows)
(global-set-key (kbd "C-x <f9>") 'sticky-window-keep-window-visible)

(desktop-save-mode 1)
(setq desktop-globals-to-save
    (append '((extended-command-history . 30)
        (file-name-history        . 100)
        (grep-history             . 30)
        (compile-history          . 30)
        (minibuffer-history       . 50)
        (query-replace-history    . 60)
        (read-expression-history  . 60)
        (regexp-history           . 60)
        (regexp-search-ring       . 20)
        (search-ring              . 20)
        (shell-command-history    . 50)
        tags-file-name
        register-alist)))

(savehist-mode 1)
(setq savehist-additional-variables
    '(kill-ring search-ring regexp-search-ring))
;;(setq savehist-file "~/.emacs.d/tmp/savehist")

(require 'icicles)
(icy-mode 1)
(require 'lacarte)
(global-set-key [?\e ?\M-x] 'lacarte-execute-command)
(global-set-key [?\M-`] 'lacarte-execute-command)
;;(require 'ido)
;;(setq ido-enable-flex-matching 't)
(global-set-key [(super ?\])] 'find-tag)
(global-set-key [(super ?t)] 'pop-tag-mark)

(add-to-list 'load-path "~/.emacs.d/share/dabbrev/elisp")
(require 'dabbrev-expand-multiple)
(global-set-key "\M-/" 'dabbrev-expand-multiple)
(setq dabbrev-case-fold-search t)

(add-to-list 'load-path "~/.emacs.d/share/whole-line-or-region/elisp")
(transient-mark-mode t)
(require 'whole-line-or-region)
(whole-line-or-region-mode 1)

(setq default-frame-alist
    '(
        (width . 80) (height . 26)
        (font . "-rfx-fixed-medium-*-normal-*-24-170-100-100-*-*-iso10646-*")
    ))

;;(set-face-font 'default "-rfx-fixed-medium-*-normal-*-24-170-100-100-*-*-iso10646-*")
;;(set-frame-font "-rfx-fixed-medium-*-normal-*-24-170-100-100-*-*-iso10646-*")
;; -rfx-fixed-medium-*-normal-*-24-230-75-75-*-*-iso10646-*
(require 'color-theme)
;;(setq color-theme-choices '(
;;	color-theme-deep-blue
;;	color-theme-standard
;;	Arjen
;;	Classic
;;  Clarity and Beauty
;;	Gnome 2
;;	Gray1
;;	Gray30
;;	Late Night
;;	Midnight
;;	Taylor
;;	White On Grey
;;	))
(color-theme-initialize)
;;(setq theme-default 'color-theme-gnome2)
;;(eval-after-load "color-theme" '(color-theme-gnome2))
(color-theme-classic)
;(color-theme-arjen)
;(color-theme-taylor)
;;(add-to-list 'default-frame-alist '(foreground-color . "white"))
;;(add-to-list 'default-frame-alist '(background-color . "black"))
(add-to-list 'default-frame-alist '(cursor-color . "coral"))
;;(add-to-list 'default-frame-alist '(height . 24))
;;(add-to-list 'default-frame-alist '(width . 80))

;; normal undo/redo
(add-to-list 'load-path "~/.emacs.d/share/redoplus/elisp")
(require 'redo+)
(global-set-key (kbd "C-?") 'redo)
(setq undo-no-redo t)

(load-file "~/.emacs.d/rc/.emacs-ampl")
;(load-file "~/.emacs.d/rc/.emacs-erlang")
(add-hook 'erlang-mode-hook
    '(lambda ()
        ; (add-hook HOOK FUNCTION &optional APPEND LOCAL) <- LOCAL=t
        (load-file "~/.emacs.d/rc/.emacs-erlang")
        nil 'make-it-local))
(load-file "~/.emacs.d/rc/.emacs-clojure")
;(load-file "~/.emacs.d/rc/.emacs-ocaml")
(add-hook 'tuareg-mode-hook
    '(lambda ()
        ; (add-hook HOOK FUNCTION &optional APPEND LOCAL) <- LOCAL=t
        (load-file "~/.emacs.d/rc/.emacs-ocaml")
        nil 'make-it-local))

(load-file "~/.emacs.d/rc/.emacs-python")
; the following hooker doesn't work
;(add-hook 'python-mode-hook (lambda ()
;                             (load-file "~/.emacs.d/rc/.emacs-python")
;							  nil 'make-it-local))

;(add-to-list 'load-path "~/.emacs.d/share/sunrise-commander/elisp")
;(require 'sunrise-commander)

; easy buffer switching
; note: since buffers are listed in LRU way, their numbers are changing. So...
(require 'ebs)
(ebs-initialize)
(global-set-key [(control tab)] 'ebs-switch-buffer)

; http://www.emacswiki.org/emacs/SearchAtPoint
; Another variation that is very vim-like
(defun my-isearch-word-at-point ()
  (interactive)
  (call-interactively 'isearch-forward-regexp))

(defun my-isearch-yank-word-hook ()
  (when (equal this-command 'my-isearch-word-at-point)
    (let ((string (concat "\\<"
                          (buffer-substring-no-properties
                           (progn (skip-syntax-backward "w_") (point))
                           (progn (skip-syntax-forward "w_") (point)))
                          "\\>")))
      (if (and isearch-case-fold-search
               (eq 'not-yanks search-upper-case))
          (setq string (downcase string)))
      (setq isearch-string string
            isearch-message
            (concat isearch-message
                    (mapconcat 'isearch-text-char-description
                               string ""))
            isearch-yank-flag t)
      (isearch-search-and-update))))

(add-hook 'isearch-mode-hook 'my-isearch-yank-word-hook)
(global-set-key (kbd "C-*") 'my-isearch-word-at-point)
(global-set-key (kbd "C-<kp-multiply>") 'my-isearch-word-at-point)

(require 'yasnippet)

(global-set-key (kbd "<f2>") 'save-buffer)

(setq-default save-place t)
(setq default-tab-width 4)
;; git
(autoload 'magit-status "magit" nil t)

;; moving between windows
(defun select-next-window ()
  "Switch to the next window" 
  (interactive)
  (select-window (next-window)))

(defun select-previous-window ()
  "Switch to the previous window" 
  (interactive)
  (select-window (previous-window)))

(global-set-key (kbd "M-<right>") 'select-next-window)
(global-set-key (kbd "M-<left>")  'select-previous-window)

;; make same buffer names look different
(require 'uniquify)
;; moving these options outside of custom block makes emacsclient ignore them
;; it's weird in fact
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(blink-cursor-mode nil)
 '(column-number-mode t)
 '(modify-syntax-entry 95 t)
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(uniquify-buffer-name-style (quote forward) nil (uniquify)))

;(require 'server)
;(setq frame-title-format (list server-name " - %b"))

(autoload 'paredit-mode "paredit"
	"Minor mode for pseudo-structurally editing Lisp code."
	t)
(add-hook 'clojure-mode-hook (lambda () (paredit-mode +1)))

(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(font-lock-comment-face ((t (:foreground "grey50"))))
 '(py-number-face ((t (:foreground "pink"))))
 '(py-variable-name-face ((t (:foreground "blue")))))
