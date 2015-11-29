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

;; load packages
(add-to-list 'load-path "~/.emacs.d/lisp")
;; basic editor settings
(require 'init-window)
(require 'init-helm)
(require 'init-misc)
;; developing section
(require 'init-prog)                    ; programming settings
(require 'init-org)
(require 'init-cpp)                     ; c/c++
(require 'init-python)                  ; python
(require 'init-ruby)                    ; ruby
(require 'init-latex)                   ; latex
(require 'init-html)                    ; html
