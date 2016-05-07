;; general userinterface and appearance
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(setq visible-bell t)
(setq inhibit-startup-message t)
(global-hl-line-mode 1)
(global-font-lock-mode 1)

;; cursor and mouse
(blink-cursor-mode -1)
(setq track-eol nil)
(setq mouse-yank-at-point t)
(setq scroll-preserve-screen-position t)
(mouse-avoidance-mode 'jump)
(set-cursor-color "blue")
(column-number-mode 1)
(mouse-wheel-mode 1)

;; files and sessions
(setq auto-save-timeout 90)
(setq make-backup-files nil)
(setq read-file-name-completion-ignore-case t)

;; tabs, spaces, lines and parenthesis
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)
(setq-default tab-always-indent 'complete)

(setq sentence-end-double-space nil)
(setq truncate-partial-width-windows nil)
(setq-default indicate-empty-lines t)
(setq require-final-newline t)
(global-linum-mode 1)

;; insert parenthesis by pair
(setq electric-pair-pairs '((?\" . ?\")
                            (?\{ . ?\})))
(electric-pair-mode 1)
;; auto highlight parenthesis
(setq show-paren-style 'expression)
(custom-set-faces '(show-paren-match ((((class color) (background light)) (:background "yellow1")))))
(show-paren-mode 1)

;; buffers and windows
(setq frame-title-format "%b - emacs")
;; (global-set-key (kbd "C-x C-b") 'ibuffer)
;; (icomplete-mode t)
(setq read-buffer-completion-ignore-case t)

;; key bindings
(global-unset-key "\C-x\C-v")
(global-set-key (kbd "M-/") 'hippie-expand)
(global-set-key (kbd "RET") 'newline-and-indent)
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; backups
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))
(setq delete-old-versions -1)
(setq version-control t)
(setq vc-make-backup-files t)
(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/auto-save-list/" t)))

;; history
(setq savehist-file "~/.emacs.d/savehist")
(savehist-mode 1)
(setq history-length t)
(setq history-delete-duplicates t)
(setq savehist-save-minibuffer-history 1)
(setq savehist-additional-variables '(kill-ring
                                      search-ring
                                      regexp-search-ring))

;; miscellaneous
(add-hook 'text-mode-hook 'turn-on-auto-fill)
(defalias 'yes-or-no-p 'y-or-n-p)
(setq gc-cons-threshold (* 100 1024 1024))

(provide 'setup-custom)