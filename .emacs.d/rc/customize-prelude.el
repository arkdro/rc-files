;;;; PACKAGE ARCHIVES

; (require 'package)
;(package-initialize)

(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ;("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))
; M-x package-refresh-contents
; M-x package-install [RET] xxxxxxxxxx

;;;; F2 FOR SAVE

(global-set-key (kbd "<f2>") 'save-buffer)

;;;; FRAME PROPERTIES

(setq default-frame-alist
    '(
        (width . 128) (height . 36) ; sometimes doesn't work
        (font . "DejaVu Sans Mono 15")
        ;(font . "Go Mono 14")
        ;(font . "-rfx-fixed-medium-*-normal-*-24-170-100-100-*-*-iso10646-*")
    ))

;;;; REDO+

;; normal undo/redo
;(add-to-list 'load-path "~/.emacs.d/share/redoplus/elisp")
;(require 'redo+)
;(global-set-key (kbd "C-?") 'redo)
;(setq undo-no-redo t)

;;;; UNDO-TREE

(global-undo-tree-mode)

;;;; SMART PARENS

(require 'smartparens-config)

(global-unset-key (kbd "<menu>"))
(global-set-key (kbd "<menu> <left>") 'sp-forward-barf-sexp)
(global-set-key (kbd "<menu> <right>") 'sp-forward-slurp-sexp)

;;;; misc
(modify-syntax-entry ?_ "w")
(global-visual-line-mode 1)

(add-hook 'visual-line-mode-hook
  (defun local-warp-prefix ()
    "Set `wrap-prefix' for all buffers."
    (setq wrap-prefix "  ")))

(setq scroll-step 1
  maximum-scroll-margin 0.0
  scroll-up-aggressively 0.0
  scroll-down-aggressively 0.0
  scroll-conservatively 11000)

;; scroll one line at a time (less "jumpy" than defaults)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-step 1) ;; keyboard scroll one line at a time

(centaur-tabs-mode t)

;; -------- key bindings ------------

(global-set-key '[C-up] (lambda () (interactive) (scroll-down 1)))
(global-set-key '[C-down] (lambda () (interactive) (scroll-up 1)))

(global-set-key (kbd "C-<prior>")   'centaur-tabs-backward)
(global-set-key (kbd "C-<next>")    'centaur-tabs-forward)
;;(global-set-key (kbd "C-S-<prior>") 'xxxx)
;;(global-set-key (kbd "C-S-<next>")  'xxxx)

;; evil numbers

(require 'evil-numbers)
(global-set-key (kbd "C-c +") 'evil-numbers/inc-at-pt)
(global-set-key (kbd "C-c -") 'evil-numbers/dec-at-pt)
(global-set-key (kbd "C-c C-+") 'evil-numbers/inc-at-pt)
(global-set-key (kbd "C-c C--") 'evil-numbers/dec-at-pt)

;; show matching brace
(show-paren-mode t)
(setq show-paren-style 'parenthesis) ; valid: parenthesis, expression, mixed

;; jump to matching brace
(defun forward-or-backward-sexp (&optional arg)
  "Go to the matching parenthesis character if one is adjacent to point."
  (interactive "^p")
  (cond ((looking-at "\\s(") (forward-sexp arg))
        ((looking-back "\\s)" 1) (backward-sexp arg))
        ;; Now, try to succeed from inside of a bracket
        ((looking-at "\\s)") (forward-char) (backward-sexp arg))
        ((looking-back "\\s(" 1) (backward-char) (forward-sexp arg))))
(global-set-key (kbd "C-\\") 'forward-or-backward-sexp)

;; show line numbers globally
(global-display-line-numbers-mode 1)

;; switch between two recently used buffers
(global-set-key [f12]  'mode-line-other-buffer)

;; Ctrl-Tab switches between buffers
(global-set-key '[C-tab]  'other-window)

;;;; KILL BUFFER

(defun kill-this-buffer-volatile ()
    "Kill current buffer, even if it has been modified."
    (interactive)
    (set-buffer-modified-p nil)
    (kill-this-buffer))
(global-set-key [(super ?k)] 'kill-this-buffer-volatile)
(global-set-key (kbd "s-<delete>") 'kill-this-buffer-volatile)

;; highlight current line globally
(global-hl-line-mode 1)
(set-face-attribute 'hl-line nil :inherit nil :background "#404040")

(defalias 'yes-or-no-p 'y-or-n-p)
(setq-default indent-tabs-mode nil)
(setq-default show-trailing-whitespace t)
(setq
    tab-width 4
    echo-keystrokes 0.1
    mouse-yank-at-point t
    tabbar-local-mode t
    case-fold-search t
    isearch-allow-scroll 'unlimited
    completion-ignore-case t
    read-file-name-completion-ignore-case t
    read-buffer-completion-ignore-case t
)
;; show eof marker
(set-default 'indicate-empty-lines t)

(save-place-mode 1)

(setq default-tab-width 4)

;;;; SWITCHING WINDOWS

;;;; CLOSE OTHER WINDOW KEY

; simulate one IDE on closing the windows that are not in the focus
(global-set-key [(shift escape)] 'delete-other-windows)

;;;; DUMB JUMP

; first activate dumb-jump mode to use these keys:
; (dumb-jump-mode)

(add-hook 'dumb-jump-mode-hook
          (lambda ()
            (define-key dumb-jump-mode-map (kbd "M-g M-.") 'dumb-jump-go)
            (define-key dumb-jump-mode-map (kbd "M-g M-,") 'dumb-jump-back)))

;; kill whole line
;(global-set-key (kbd "C-w") 'kill-whole-line)
;(require 'whole-line-or-region)
(whole-line-or-region-global-mode)


;; color of selection
;(set-face-attribute 'region nil :background "#bbbb55" :foreground "#000000")

;;;; THEMES

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
;(load-theme 'classic t t)
;(enable-theme 'classic)
(add-to-list 'default-frame-alist '(cursor-color . "coral"))

(load-theme 'jetbrains-darcula t t)
(enable-theme 'jetbrains-darcula)

;; make current line number smaller
(set-face-attribute 'line-number-current-line nil :height 96)

;; make other line numbers smaller (from 128 to 96)
(set-face-attribute 'line-number nil :height 96)

(blink-cursor-mode 0)
(column-number-mode t)
(tool-bar-mode nil)

;; show menu bar (hidden by 'better-defaults')
(menu-bar-mode 1)

;;;; INITIAL GEOMETRY AND LOOK

(add-hook 'window-setup-hook
  (lambda ()
    (set-frame-position (selected-frame) 2300 50)
    (set-frame-width (selected-frame) 124 t)
    (set-frame-height (selected-frame) 36 t)
    (delete-other-windows)
    ))

;;;; override prelude

(defun my-prog-mode-hook ()
  (modify-syntax-entry ?_ "w")
  )
(add-hook 'prog-mode-hook #'my-prog-mode-hook)

(global-set-key (kbd "<C-backspace>") 'backward-kill-word)

;; override smartparens from prelude
(define-key smartparens-mode-map (kbd "C-<left>") nil)
(define-key smartparens-mode-map (kbd "C-<right>") nil)

;; shut up a noisy guy giving a useless and _wrong_ (study anatomy first) advice.
(setq prelude-guru nil)

