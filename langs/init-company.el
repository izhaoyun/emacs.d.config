;;; init-company.el --- Company

;;; Commentary:

;;; Code:

;; Package: company
(el-get-bundle company-mode)
(require 'company)
(setq company-show-numbers t)
;; (add-hook 'prog-mode-hook 'company-mode)
(add-hook 'after-init-hook 'global-company-mode)

;; Package: company-quickhelp-mode
(el-get-bundle company-quickhelp)
(add-hook 'company-mode-hook 'company-quickhelp-mode)
;; (company-quick-mode 1)

;; solving conflicts in company and yasnippet.
;; http://www.emacswiki.org/emacs/CompanyMode
(defun check-expansion ()
  (save-excursion
    (if (looking-at "\\_>") t
      (backward-char 1)
      (if (looking-at "\\.") t
        (backward-char 1)
        (if (looking-at "->") t nil)))))

(defun do-yas-expand ()
 (let ((yas/fallback-behavior 'return-nil))
  (yas/expand)))

(defun tab-indent-or-complete ()
 (interactive)
 (if (minibufferp)
  (minibuffer-complete)
  (if (or (not yas/minor-mode)
       (null (do-yas-expand)))
   (if (check-expansion)
    (company-complete-common)
    (indent-for-tab-command)))))

(global-set-key [tab] 'tab-indent-or-complete)

(provide 'init-company)
;;; init-company.el ends here
