
;;;; FRAMES/WINDOWS



; trying to keep one frame with one window for text and other frame with
; one console for debug. Almost without success...
; Trying don't split windows (now it creates new frames...
; little better but still "fucking idiocy")
;(setq split-window-preferred-function nil)
;(setq display-buffer-reuse-frames t)
(setq pop-up-windows nil)
;(setq pop-up-frames nil)
; window splitting disabled, and fun below is nil. So can't create frame
; to jump on tags
;(setq pop-up-frame-function nil)

; try:
;(setq same-window-regexps '(".*")) ; or "."?
; same-window-buffer-names and/or same-window-regexps and same-window-p
; special-display-buffer-names, speical-display-regexps,
; special-display-function, display-buffer-function.

;;;; DEFAULTS

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
    isearch-allow-scroll t
    completion-ignore-case t
    read-file-name-completion-ignore-case t
    read-buffer-completion-ignore-case t
)

;;;; TABBAR

(global-set-key (kbd "C-<prior>") 'tabbar-backward)
(global-set-key (kbd "C-<next>") 'tabbar-forward)

;;;; SHOW EMPTY LINES

;(toggle-show-trailing-whitespace-show-ws)
(set-default 'indicate-empty-lines t)

;;;; SCROLL

;; scroll one line at a time (less "jumpy" than defaults)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-step 1) ;; keyboard scroll one line at a time

;;;; LOAD DIRS

; bind default-directory to a dir and add all subdirs (and single files) to load-path.
; !!! Little dangerous to add everything to the load path.
(let ((default-directory  "~/.emacs.d/elpa/"))
  (normal-top-level-add-to-load-path '("."))
  (normal-top-level-add-subdirs-to-load-path))

(add-to-list 'load-path "~/.emacs.d/share/misc/elisp")

;;;; HIGHLIGHT CHARS

(require 'highlight-chars)
(hc-highlight-tabs)

;;;; EVIL NUMBERS

(require 'evil-numbers)
(global-set-key (kbd "C-c +") 'evil-numbers/inc-at-pt)
(global-set-key (kbd "C-c -") 'evil-numbers/dec-at-pt)

;;;; DIRED+

(require 'dired+)

;;;; THING AT POINT+

(require 'thingatpt+)

;;;; SMOOTH SCROLL

(require 'smooth-scroll)
(smooth-scroll-mode t)
(global-set-key [(control  down)]  'scroll-up-1)
(global-set-key [(control  up)]    'scroll-down-1)

;;;; DESKTOP VARS

; make window dedicated (one-way function)
;(require 'sticky-windows)
;(global-set-key (kbd "C-x <f9>") 'sticky-window-keep-window-visible)

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

;;;; ICICLES

(require 'icicles)
;; icy-mode meddles with frame/window creation. So, activate it only when necessary.
;(icy-mode 1)

;(require 'lacarte)
;(global-set-key [?\e ?\M-x] 'lacarte-execute-command)
;(global-set-key [?\M-`] 'lacarte-execute-command)

;;(require 'ido)
;;(setq ido-enable-flex-matching 't)

;;;; JUMP FORTH/BACK TAG

(global-set-key [(super ?\])] 'find-tag)
(global-set-key [(super ?t)] 'pop-tag-mark)

;(add-to-list 'load-path "~/.emacs.d/share/auto-complete")
;(add-to-list 'load-path "~/.emacs.d/share/dabbrev/elisp")

;;;; AUTO COMPLETE

(require 'auto-complete)
(global-auto-complete-mode t)
(require 'auto-complete-config)
(ac-config-default)
;(require 'ac-dabbrev)
;(add-to-list 'ac-sources 'ac-source-dabbrev)
;(defun ac-dabbrev-expand ()
;  (interactive)
;  (auto-complete '(ac-source-dabbrev)))
;(global-set-key "\M-/" 'ac-dabbrev-expand)
(add-to-list 'ac-modes 'erlang-mode)

;;;; WHOLE LINE OR REGION

(add-to-list 'load-path "~/.emacs.d/share/whole-line-or-region/elisp")
(transient-mark-mode t)
(require 'whole-line-or-region)
(whole-line-or-region-mode 1)

;;;; FRAME PROPERTIES

(setq default-frame-alist
    '(
        (width . 80) (height . 36)
        (font . "DejaVu Sans Mono 15")
        ;(font . "-rfx-fixed-medium-*-normal-*-24-170-100-100-*-*-iso10646-*")
    ))

;;(set-face-font 'default "-rfx-fixed-medium-*-normal-*-24-170-100-100-*-*-iso10646-*")
;;(set-frame-font "-rfx-fixed-medium-*-normal-*-24-170-100-100-*-*-iso10646-*")
;; -rfx-fixed-medium-*-normal-*-24-230-75-75-*-*-iso10646-*
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'classic t t)
(enable-theme 'classic)
(add-to-list 'default-frame-alist '(cursor-color . "coral"))
;;(add-to-list 'default-frame-alist '(height . 24))
;;(add-to-list 'default-frame-alist '(width . 80))

;;;; REDO+

;; normal undo/redo
(add-to-list 'load-path "~/.emacs.d/share/redoplus/elisp")
(require 'redo+)
(global-set-key (kbd "C-?") 'redo)
(setq undo-no-redo t)

;;;; OTHER LANGUAGES

(load-file "~/.emacs.d/rc/.emacs-ampl")
;(load-file "~/.emacs.d/rc/.emacs-erlang")
(add-hook 'erlang-mode-hook (lambda ()
                          (load-file "~/.emacs.d/rc/.emacs-erlang")
                        ))
(load-file "~/.emacs.d/rc/.emacs-clojure")
(add-hook 'go-mode-hook (lambda ()
                          (load-file "~/.emacs.d/rc/.emacs-go")
                        ))

;(load-file "~/.emacs.d/rc/.emacs-ocaml")
(add-hook 'tuareg-mode-hook
    '(lambda ()
        ; (add-hook HOOK FUNCTION &optional APPEND LOCAL) <- LOCAL=t
        (load-file "~/.emacs.d/rc/.emacs-ocaml")
        nil 'make-it-local))

;(load-file "~/.emacs.d/rc/.emacs-python")
; the following hooker doesn't work. Now it works.
(add-hook 'python-mode-hook (lambda ()
                             (load-file "~/.emacs.d/rc/.emacs-python")
                            ))
;;							  nil 'make-it-local))

(add-hook 'haskell-mode-hook '(lambda ()
                          (global-set-key (kbd "M-.") 'inferior-haskell-find-definition)
 						  nil 'make-it-local))

;(add-to-list 'load-path "~/.emacs.d/share/structured-haskell-mode/elisp")
;(require 'shm)
;(add-hook 'haskell-mode-hook 'structured-haskell-mode)
;(setq shm-program-name "/home/user1/.emacs.d/share/structured-haskell-mode/dist/build/structured-haskell-mode/structured-haskell-mode") ; full path here

;(add-to-list 'load-path "~/.emacs.d/share/sunrise-commander/elisp")
;(require 'sunrise-commander)

; easy buffer switching
; note: since buffers are listed in LRU way, their numbers are changing. So...
;(require 'ebs)
;(ebs-initialize)
;(global-set-key [(control tab)] 'ebs-switch-buffer)

;;;; SEARCH AT POINT

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

;;;; YASNIPPET

(require 'yasnippet)
(yas-global-mode 1)

;;;; F2 FOR SAVE

(global-set-key (kbd "<f2>") 'save-buffer)

;;;; SAVE PLACE

(setq-default save-place t)

;;;; TAB WIDTH

(setq default-tab-width 4)

;;;; GIT

;; git
(autoload 'magit-status "magit" nil t)

;;;; SWITCHING WINDOWS

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

;;;; UNIQ BUFFER NAMES

;; make same buffer names look different
(require 'uniquify)

;;;; CUSTOM VARS

;; moving these options outside of custom block makes emacsclient ignore them
;; it's weird in fact
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(blink-cursor-mode nil)
 '(column-number-mode t)
 '(flycheck-idle-change-delay 5)
 '(flymake-no-changes-timeout 5)
 '(haskell-indentation-ifte-offset 4)
 '(haskell-indentation-left-offset 4)
 '(haskell-indentation-starter-offset 4)
 '(haskell-indentation-where-post-offset 4)
 '(haskell-indentation-where-pre-offset 4)
 '(modify-syntax-entry 95 t)
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(uniquify-buffer-name-style (quote forward) nil (uniquify)))

;(require 'server)
;(setq frame-title-format (list server-name " - %b"))

;;;; PAREDIT

(autoload 'paredit-mode "paredit"
	"Minor mode for pseudo-structurally editing Lisp code."
	t)
(add-hook 'clojure-mode-hook (lambda () (paredit-mode +1)))

;;;; KILL BUFFER

(defun kill-this-buffer-volatile ()
    "Kill current buffer, even if it has been modified."
    (interactive)
    (set-buffer-modified-p nil)
    (kill-this-buffer))
(global-set-key [(super ?k)] 'kill-this-buffer-volatile)
(global-set-key (kbd "s-<delete>") 'kill-this-buffer-volatile)

;;;; PACKAGE ARCHIVES

; (require 'package)
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))
; M-x package-refresh-contents
; M-x package-install [RET] xxxxxxxxxx

;;;; SWITCH BUFFERS KEY

(defun switch-to-previous-buffer ()
      (interactive)
      (switch-to-buffer (other-buffer (current-buffer) 1)))
(global-set-key [(f12)] 'switch-to-previous-buffer)
(global-set-key (kbd "<C-return>") 'switch-to-previous-buffer)

;;;; CUSTOM FACE

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(highlight-symbol-face ((t (:background "DeepSkyBlue4"))))
 '(font-lock-comment-face ((t (:foreground "grey51")))))

;;;; FLYCHECK

(global-flycheck-mode)

;;;; NEO TREE

(require 'neotree)
(global-set-key [f8] 'neotree-toggle)
(setq neo-smart-open t)

;;;; FIND FILE IN PROJECT

(global-set-key [f7] 'find-file-in-project)
(global-set-key (kbd "C-S-n") 'find-file-in-project)

;;;; CLOSE OTHER WINDOW KEY

; simulate one IDE on closing the windows that are not in the focus
(global-set-key [(shift escape)] 'delete-other-windows)

;;;; DIRED

; sort order for dired
(setq dired-listing-switches "-alv  --group-directories-first")

;;;; HIGHLIGHT AT POINT

; highlight symbol at point
(require 'highlight-symbol)
(global-set-key [(super f3)] 'highlight-symbol)
(global-set-key [f3] 'highlight-symbol-next)
(global-set-key [(shift f3)] 'highlight-symbol-prev)
(global-set-key [(meta f3)] 'highlight-symbol-query-replace)

;; It doesn't start using just (highlight-symbol-mode 1) from .emacs file.
;; Although, it starts when called manually (highlight-symbol-mode 1).
;; So, for starting from .emacs, the lambda is necessary.
(define-global-minor-mode my-global-highlight-symbol-mode
  highlight-symbol-mode
  (lambda () (highlight-symbol-mode 1)))
(my-global-highlight-symbol-mode)

;;;; DUMB JUMP

; first activate dumb-jump mode to use these keys:
; (dumb-jump-mode)

(add-hook 'dumb-jump-mode-hook
          (lambda ()
            (define-key dumb-jump-mode-map (kbd "M-g M-.") 'dumb-jump-go)
            (define-key dumb-jump-mode-map (kbd "M-g M-,") 'dumb-jump-back)))

;;; .emacs ends here
