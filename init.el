(load-theme 'deeper-blue t)

;;; install required packages
(require 'package)

(setq package-archives '(("elpa" . "http://tromey.com/elpa/")
                         ("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "https://marmalade-repo.org/packages/")
                         ("org" . "http://orgmode.org/elpa/")))
(package-initialize)

;(unless (not package-archive-contents)
(or (file-exists-p package-user-dir)
  (package-refresh-contents))

(setq package-list '(js2-mode
                     django-mode
                     flycheck
                     auto-complete
                     markdown-mode))

(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))
;;; 
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(case-fold-search t)
 '(column-number-mode t)
 '(cua-mode t nil (cua-base))
 '(current-language-environment "English")
 '(font-lock-global-modes t)
 '(font-lock-maximum-decoration t)
 '(global-font-lock-mode t nil (font-lock))
 '(package-selected-packages
   (quote
    (ido-mode yasnippet yafolding virtualenvwrapper markdown-mode js2-mode jedi flycheck django-mode)))
 '(python-check-command "pycheckers")
 '(query-user-mail-address nil)
 '(show-paren-mode t)
 '(text-mode-hook (quote (text-mode-hook-identify))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(setq-default indent-tabs-mode nil)
(setq display-warning-minimum-level 'error
        log-warning-minimal-level 'info)
(setq default-tab-width 4)
(setq fill-column 80)
(setq-default truncate-lines 1)

(setq python-shell-interpreter "/usr/local/lib/python3.5")

(put 'upcase-region 'disabled nil)

;; colored #hexa
(defvar hexcolour-keywords
  '(("#[abcdef[:digit:]]\\{6\\}"
     (0 (put-text-property
         (match-beginning 0)
         (match-end 0)
         'face (list :background
                     (match-string-no-properties 0)))))))
(defun hexcolour-add-to-font-lock ()
  (font-lock-add-keywords nil hexcolour-keywords))
(add-hook 'css-mode-hook 'hexcolour-add-to-font-lock)
(add-hook 'html-mode-hook 'hexcolour-add-to-font-lock)


(setq next-line-add-newlines nil)
(font-lock-mode t)
 ; Make all "yes or no" prompts show "y or n" instead
(fset 'yes-or-no-p 'y-or-n-p)
(setq inhibit-splash-screen t)
(setq-default indent-tabs-mode nil)

(global-set-key [home] 'beginning-of-line)
(global-set-key [end] 'end-of-line)
(global-set-key [C-prior] 'beginning-of-buffer)
(global-set-key [C-next] 'end-of-buffer) 

; turn off the tool and menu bars
(tool-bar-mode -1)
(menu-bar-mode -1)
;(set-frame-font "Ubuntu Mono-8")

(prefer-coding-system 'mule-utf-8)

(require 'ido)
(ido-mode t)
(add-to-list 'ido-ignore-files "\\.pyc")

;; (add-to-list 'load-path
;;              "~/.emacs.d/plugins")

(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/plugins//ac-dict")
(ac-config-default)

(add-to-list 'load-path
             "~/.emacs.d/plugins/js2-mode")

(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

; (require 'json-mode)

;(load-library "~/.emacs.d/init_python")
;(add-to-list 'load-path
;              "~/.emacs.d/plugins/web-mode")
;(require 'web-mode)
;(add-to-list 'auto-mode-alist '("\\.html$" . web-mode))

(add-hook 'after-init-hook #'global-flycheck-mode)

;; ;(require 'mercurial)
;; (require 'tramp)

; use < and > when a region is selected to indent by 4 space exactly (to avoid crappy auto indent)
(defun my-indent-region (N)
  (interactive "p")
  (if (use-region-p)
      (progn (indent-rigidly (region-beginning) (region-end) (* N 4))
             (setq deactivate-mark nil))
    (self-insert-command N)))

(defun my-unindent-region (N)
  (interactive "p")
  (if (use-region-p)
      (progn (indent-rigidly (region-beginning) (region-end) (* N -4))
             (setq deactivate-mark nil))
    (self-insert-command N)))

(global-set-key ">" 'my-indent-region)
(global-set-key "<" 'my-unindent-region)
