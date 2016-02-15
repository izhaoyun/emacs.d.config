;;; init.el

(setq gc-cons-threshold 100000000)

;; el-get
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(add-to-list 'el-get-recipe-path "~/.emacs.d/recipes")
;(el-get 'sync)
;(package-initialize)

;; load settings for Emacs
(add-to-list 'load-path (concat user-emacs-directory "settings"))
(require 'init-basic)
(require 'init-yasnippet)
(require 'init-swiper)

;; load modules for different programming languages
(add-to-list 'load-path (concat user-emacs-directory "langs"))
(require 'init-org)
(require 'init-cc)
