(setq inhibit-startup-message t)

(require 'package)

(setq package-enable-at-startup nil)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))

(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))


(use-package try :ensure t)


(use-package which-key
  :ensure t
  :config (which-key-mode))


;; Changing helm prefix from C-x c to C-c h. Must be set before
;; requiring helm.
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))

(use-package helm
  :ensure t
  :bind (("C-x b"   . helm-mini)
	 ("M-x"     . helm-M-x)
	 ("M-y"     . helm-show-kill-ring)
	 ("C-x C-f" . helm-find-files)
	 ("C-s"     . helm-occur)
	 :map helm-command-map
	 ("<tab>" . helm-execute-persistent-action)
	 ("C-z"   . helm-select-action))
  :config
  (require 'helm-config)
  (setq helm-split-window-in-side-p t)
  (setq helm-move-to-line-cycle-in-source t)
  (setq helm-source-names-using-follow '("Occur"))
  (setq helm-follow-mode-persistent t)
  (helm-autoresize-mode 1)
  (helm-mode 1))


(use-package js2-mode
  :ensure t
  :mode
  ("\\.js\\'" . js2-mode)
  :interpreter
  ("node"      . js2-mode)
  :init
  (add-hook 'js-mode-hook #'js2-imenu-extras-mode)
  (add-hook 'js-mode-hook
	    (lambda ()
	      (push '("() =>" . ?λ) prettify-symbols-alist)))
  :config
  (setq js-indent-level 2)
  (setq js-highlight-level 3)
  (setq js2-strict-missing-semi-warning nil)
  (setq js2-missing-semi-one-line-override nil)
  (setq js2-include-node-externs t))


(use-package js2-refactor
  :ensure t
  :init
  (add-hook 'js2-mode-hook #'js2-refactor-mode)
  :config
  (js2r-add-keybindings-with-prefix "C-c C-m"))


(use-package pdf-tools
  :ensure t
  :config
  (pdf-tools-install))


(use-package indium
  :ensure t
  :init
  (add-hook 'js-mode-hook #'indium-interaction-mode))


(use-package tern
  :ensure t
  :config
  (add-hook 'js-mode-hook
	    (lambda () (tern-mode t))))


(use-package company-tern
  :ensure t
  :config
  (add-to-list 'company-backends 'company-tern))


(use-package spacemacs-common
  :ensure spacemacs-theme
  :config
  (load-theme 'spacemacs-dark t))


(use-package ace-window
  :ensure t
  :bind (("C-x o" . ace-window)))


(use-package org
  :ensure t
  :bind (("C-c l"  .  org-store-link)
	 ("C-c a"  .  org-agenda))
  :config
  (setq org-hide-emphasis-markers t)
  (setq org-confirm-babel-evaluate nil)
  (setq org-src-fontify-natively t)
  (setq org-src-tab-acts-natively t)
  (setq org-log-done t)
  (setq org-format-latex-options
	(plist-put org-format-latex-options :scale 1.3))
  (add-to-list 'org-src-lang-modes '("js"  . js2))
  (add-to-list 'org-src-lang-modes '("nodejs" . js2))
  (org-babel-do-load-languages 'org-babel-load-languages
			       '((js . t)
				 (sh . t)
				 (dot . t)
				 (python . t))))

(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook
	    (lambda () (org-bullets-mode 1))))


;; Turn on auto fill mode as our default
(add-hook 'text-mode-hook #'turn-on-auto-fill)


;; Use company mode in all buffers
(add-hook 'after-init-hook #'global-company-mode)


;; Hook into some minor modes when programming
(add-hook 'prog-mode-hook #'electric-pair-mode)
(add-hook 'prog-mode-hook #'electric-indent-mode)
(add-hook 'prog-mode-hook #'linum-mode)
(add-hook 'prog-mode-hook
	  (lambda () (show-paren-mode 1)))


;; Highlights the whole enclosed expression
(setq show-paren-style 'expression)


;; Use spaces for tabs
(setq-default indent-tabs-mode t)


;; default frame(window) dimensions
(setq default-frame-alist
      '((top    .   0)
	(left   .   0) ; top-left corner
	(width  . 102) ; character
	(height .  46) ; lines
	(font   . "Source Code Pro for Powerline 11")
	))

(setq initial-frame-alist
      '(
	(top    .   0)
	(left   .   0) ; top-left corner
	(width  . 102) ; character
	(height .  46) ; lines
	(font   . "Source Code Pro for Powerline 11")
	))


;; remove the scrollbar 
(toggle-scroll-bar -1)


;; slow down/smooth out scrolling
(setq scroll-margin 5
      scroll-conservatively 9999
      scroll-step 1)


;; enable default Wind Move keys
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))


;; enable global prettify symbols mode
(global-prettify-symbols-mode)


;; default font setting
(set-default-font "Source Code Pro for Powerline 11")


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" "67e998c3c23fe24ed0fb92b9de75011b92f35d3e89344157ae0d544d50a63a72" "fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" default)))
 '(package-selected-packages
   (quote
    (org-bullets spacemacs-common zenburn-theme which-key use-package try spacemacs-theme pdf-tools js2-refactor indium helm company-tern ace-window))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
