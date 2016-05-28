(setq sentence-end
      "\\([。！？]\\|……\\|[.?!][]\"')}]*\\($\\|[ \t]\\)\\)[ \t\n]*")
(setq sentence-end-double-space nil)

(defun init-org-babel ()
  "settings for org-babel."
  (use-package ob-C          :ensure org)
  (use-package ob-awk        :ensure org)
  (use-package ob-dot        :ensure org)
  (use-package ob-sed        :ensure org)
  (use-package ob-sql        :ensure org)
  (use-package ob-ruby       :ensure org)
  (use-package ob-shell      :ensure org)
  (use-package ob-python     :ensure org)
  (use-package ob-emacs-lisp :ensure org)
  (use-package ob-plantuml
    :ensure org
    :init
    (setq org-plantuml-jar-path "/opt/plantuml/plantuml.jar"))
  (use-package ob-ditaa
    :ensure org
    :init
    (setq org-ditaa-jar-path "/usr/share/java/ditaa/ditaa-0_9.jar"))

  (use-package ob            :ensure org
    :init
    (org-babel-do-load-languages
     'org-babel-load-languages
     '((C          . t)
       (awk        . t)
       (dot        . t)
       (sed        . t)
       (sql        . t)
       (ruby       . t)
       (ditaa      . t)
       (shell      . t)
       (python     . t)
       (plantuml   . t)
       (emacs-lisp . t))
     )))

(defun init-org-export ()
  "settings for export"
  (progn
    (use-package ox-beamer :ensure org)
    (use-package ox-gfm    :ensure org-plus-contrib)
    (use-package ox-html   :ensure org
      :init
      (use-package htmlize))
    (use-package ox-latex
      :ensure org
      :init
      (setq org-latex-listings 'minted)
      (setq org-latex-minted-options
            '(("frame"      "single")
              ("breaklines" "")))
      (setq org-latex-pdf-process
            '("xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"
              "xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"
              "xelatex -shell-escape -interaction nonstopmode -output-directory %o %f")))
    )

  (defun clear-single-linebreak-in-cjk-string (string)
    "clear single line-break between cjk characters that is
usually soft line-breaks"
    (let* ((regexp "\\([\u4E00-\u9FA5]\\)\n\\([\u4E00-\u9FA5]\\)")
           (start (string-match regexp string)))
      (while start
        (setq string (replace-match "\\1\\2" nil nil string)
              start (string-match regexp string start))))
    string)

  (defun ox-html-clear-single-linebreak-for-cjk (string backend info)
    (when (org-export-derived-backend-p backend 'html)
      (clear-single-linebreak-in-cjk-string string)))
  
  (use-package ox
    :ensure org
    :init
    (setq org-export-default-language "zh-CN")
    (setq org-latex-compiler "xelatex")
    :config
    (add-to-list 'org-export-filter-final-output-functions
                 'ox-html-clear-single-linebreak-for-cjk))
  )

(defun init-org-bullets ()
  (use-package org-bullets
    :ensure org-plus-contrib
    :init
    (org-bullets-mode 1))
  )

(defun init-org-publish ()
  (use-package ox-publish
    :ensure org
    :init
    (setq org-publish-project-alist
          '("org-notes"
            :base-directory "~/org-notes/"
            :base-extension "org"
            :publishing-directory "~/public_html/"
            :recursive t
            :publishing-function org-html-publish-to-html
            :auto-preamble t
            ))
    )
  )

(use-package org
  :mode (("\\.org$" . org-mode)
         ("\\.txt$" . org-mode))
  :bind
  (("C-c a" . org-agenda)
   ("C-c b" . org-iswitchb)
   ("C-c c" . org-capture)
   ("C-c l" . org-store-link))
  :init
  (setq org-src-fontify-natively t)
  (setq org-src-tab-acts-natively t)
  ;; (add-hook 'org-mode-hook 'init-org-bullets)

  ;; (font-lock-add-keywords 'org-mode
  ;;                         '(("^ +\\([-*]\\) "
  ;;                            (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))
  ;; (let* ((variable-tuple (cond ((x-list-fonts "Source Sans Pro") '(:font "Source Sans Pro"))
  ;;                              ((x-list-fonts "Lucida Grande")   '(:font "Lucida Grande"))
  ;;                              ((x-list-fonts "Verdana")         '(:font "Verdana"))
  ;;                              ((x-family-fonts "Sans Serif")    '(:family "Sans Serif"))
  ;;                              (nil (warn "Cannot find a Sans Serif Font.  Install Source Sans Pro."))))
  ;;        (base-font-color     (face-foreground 'default nil 'default))
  ;;        (headline           `(:inherit default :weight bold :foreground ,base-font-color)))
  ;;   (custom-theme-set-faces 'user
  ;;                           `(org-level-8 ((t (,@headline ,@variable-tuple))))
  ;;                           `(org-level-7 ((t (,@headline ,@variable-tuple))))
  ;;                           `(org-level-6 ((t (,@headline ,@variable-tuple))))
  ;;                           `(org-level-5 ((t (,@headline ,@variable-tuple))))
  ;;                           `(org-level-4 ((t (,@headline ,@variable-tuple :height 1.1))))
  ;;                           `(org-level-3 ((t (,@headline ,@variable-tuple :height 1.35))))
  ;;                           `(org-level-2 ((t (,@headline ,@variable-tuple :height 1.55))))
  ;;                           `(org-level-1 ((t (,@headline ,@variable-tuple :height 1.7))))
  ;;                           `(org-documentt-itle ((t (,@headline ,@variable-tuple :height 1.5 :underline nil))))))
  :config
  ;; alist of packages to be inserted in every LaTeX header.
  (add-to-list 'org-latex-packages-alist '("" "ctex"))
  (add-to-list 'org-latex-packages-alist '("" "minted"))
  (add-to-list 'org-latex-packages-alist '("" "color"))
  (add-to-list 'org-latex-packages-alist '("" "geometry"))
  (add-to-list 'org-latex-packages-alist '("" "tabularx"))
  (add-to-list 'org-latex-packages-alist '("" "tabu"))
  (add-to-list 'org-latex-packages-alist '("" "fancyhdr"))
  (add-to-list 'org-latex-packages-alist '("" "natbib"))
  (add-to-list 'org-latex-packages-alist '("" "titlesec"))

  (add-hook 'org-mode-hook 'init-org-publish)
  (add-hook 'org-mode-hook 'init-org-babel)
  (add-hook 'org-mode-hook 'init-org-export))

(use-package calfw)
(use-package calfw-org
  :ensure calfw)

(provide 'setup-org)
