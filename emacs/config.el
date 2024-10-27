(require 'package)

;; LIST OF PACKAGES TO INSTALL ON SYSTEM IF MISSING
(setq package-list '(dtrt-indent hydra pretty-hydra markdown-mode grip-mode pdf-tools typescript-mode vue-mode vue-html-mode treemacs-icons-dired treemacs-all-the-icons base16-theme auto-complete babel ob-http company-org-block counsel ivy-posframe ivy-rich org-bullets yaml-mode multiple-cursors quelpa-use-package gruvbox-theme ))

(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
        ("elpa" . "https://elpa.gnu.org/packages/")
        ("nongnu" . "https://elpa.nongnu.org/nongnu/")))

(package-initialize)
;;(package-refresh-contents)

;; fetch the list of packages available
(unless package-archive-contents
  (package-refresh-contents))

;; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

(quelpa
 '(quelpa-use-package
   :fetcher git
   :url "https://github.com/quelpa/quelpa-use-package.git"))
(require 'quelpa-use-package)


;; === STYLE ===

;; SET THEME
;; (load-theme 'base16-colors) ;; Good High contrast
(load-theme 'gruvbox-dark-hard) ;; Soothing colors
(set-frame-parameter nil 'alpha-background 87)
(add-to-list 'default-frame-alist '(alpha-background . 87))

;; (use-package fira-code-mode
  ;; :ensure t)

;; Fancy icons mainly for modeline
;; To install fonts run:
;; M-x nerd-icons-install-fonts
(use-package nerd-icons
  ;; The Nerd Font you want to use in GUI
  ;; "Symbols Nerd Font Mono" is the default and is recommended
  ;; but you can use any other Nerd Font if you want
  :ensure t
  :custom
  (nerd-icons-font-family "Symbols Nerd Font Mono")
  )


;; === GENERAL SETTINGS ===

(setq inhibit-startup-screen t)
(tool-bar-mode 0)
(menu-bar-mode 0)
;;(linum-mode 1)
(global-display-line-numbers-mode 0)
(ac-config-default)
(which-function-mode 1)

(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)


;; === LANGUAGE SUPPORT ===

;; ;; Automatically install and use tree-sitter for syntax highlighting
;; (use-package treesit-auto
;;   :ensure t
;;   :custom
;;   (treesit-auto-install 'prompt)
;;   :config
;;   (treesit-auto-add-to-auto-mode-alist 'all)
;;   (global-treesit-auto-mode))


(use-package nix-mode
  :ensure t
  :mode "\\.nix\\'")

(use-package cmake-mode
  :ensure t)

;; VUE-MODE disable ugly background
;;(add-to-list 'auto-mode-alist '("\\.vue\\'" . vue-mode))
(add-hook 'vue-mode-hook
          (lambda ()
            (set-face-background 'mmm-default-submode-face nil)))

;; === PACKAGES ===

;; DOOM Themed modeline
(use-package doom-modeline
  :ensure t
  :after nerd-icons
  :custom
  (doom-modeline-project-detection 'auto)
  (doom-modeline-enable-word-count t)
  (doom-modeline-continuous-word-count-modes '(markdown-mode gfm-mode org-mode))
  :init
  (doom-modeline-mode 1))


;; Startup screen/dashboard
(use-package dashboard
  :ensure t
  :after nerd-icons
  :config
  (dashboard-setup-startup-hook)
  :custom
  (initial-buffer-choice (lambda () (get-buffer-create "*dashboard*")))
  (dashboard-banner-logo-title "Welcome to Emacs")
  (dashboard-startup-banner 3) ;;"~/configs/files/KGP_Agent.png")
  ;; Value can be:
  ;;  - 'official which displays the official emacs logo.
  ;;  - 'logo which displays an alternative emacs logo.
  ;;  - an integer which displays one of the text banners
  ;;    (see dashboard-banners-directory files).
  ;;  - a string that specifies a path for a custom banner
  ;;    currently supported types are gif/image/text/xbm.
  ;;  - a cons of 2 strings which specifies the path of an image to use
  ;;    and other path of a text file to use if image isn't supported.
  ;;    ("path/to/image/file/image.png" . "path/to/text/file/text.txt").
  ;;  - a list that can display an random banner,
  ;;    supported values are: string (filepath), 'official, 'logo and integers.

  (dashboard-center-content t)
  (dashboard-items '((agenda  . 5)
                     (recents  . 5)
                     (bookmarks . 5)))
  (dashboard-set-navigator t)
  (dashboard-set-init-info nil)
  (dashboard-display-icons-p t)
  (dashboard-icon-type 'nerd-icons)
  (dashboard-set-file-icons t)
  (dashboard-set-heading-icons t)
  )


;; MAGIT
(use-package magit
  :ensure t
  :config
  ;; Always show word differences in Magit diffs
  (setq magit-diff-refine-hunk 'all
        magit-diff-refine-ignore-whitespace 1
        magit-diff-use-fringe-diffs nil)
  :custom (magit-display-buffer-function 'magit-display-buffer-same-window-except-diff-v1))

(use-package hl-todo
  :ensure t
  :hook (prog-mode . hl-todo-mode)
  :config
  (setq hl-todo-highlight-punctuation ":"
        hl-todo-keyword-faces
        `(("TODO"       warning bold)
          ("FIXME"      error bold)
          ("HACK"       font-lock-constant-face bold)
          ("REVIEW"     font-lock-keyword-face bold)
          ("NOTE"       success bold)
          ("DEPRECATED" font-lock-doc-face bold))))

(use-package magit-todos
  :ensure t
  :after magit
  :config (magit-todos-mode 1))


;; Maximise window temorarily with C-x <up>
(use-package zoom-window
  :ensure t
  :custom
  (zoom-window-mode-line-color "chocolate4")
  :bind ("C-x <up>" . zoom-window-zoom))

;; Workspace manager
(use-package eyebrowse
  :ensure t
  :config (eyebrowse-mode t)
  :bind (("C-S-<right>" . eyebrowse-next-window-config)
         ("C-S-<left>" . eyebrowse-prev-window-config)
         ("C-c w" . eyebrowse-transient)
         :map org-mode-map
         ("C-S-<right>" . eyebrowse-next-window-config)
         ("C-S-<left>" . eyebrowse-prev-window-config)
         ))

(transient-define-prefix eyebrowse-transient ()
  "Window management"
  [["Workspace"
    ("c" "Create" eyebrowse-create-window-config :transient nil)
    ("qq" "Close" eyebrowse-close-window-config :transient nil)
    ("f" "Switch" eyebrowse-switch-to-window-config :transient nil)
    ("m" "Move" eyebrowse-move-window-config :transient nil)
    ("n" "Rename" eyebrowse-rename-window-config :transient t)
    ("<right>" "Next" eyebrowse-next-window-config :transient t)
    ("<left>" "Previous" eyebrowse-prev-window-config :transient t)]
   ])


;; EAT Terminal emulator
;; To setup shell integration for GNU Bash, put the following at the end of your .bashrc:
;; [ -n "$EAT_SHELL_INTEGRATION_DIR" ] && \
;;   source "$EAT_SHELL_INTEGRATION_DIR/bash"
;; For Zsh, put the following in your .zshrc:
;; [ -n "$EAT_SHELL_INTEGRATION_DIR" ] && \
;;   source "$EAT_SHELL_INTEGRATION_DIR/zsh"
(use-package eat
  :ensure t
  )


;; ORG-MODE BEAUTIFYING
(setq org-hide-emphasis-markers t)
(setq org-image-actual-width nil)
(setq org-startup-with-inline-images t)
(setq org-return-follows-link t)
;; (setq org-link-frame-setup '((file . find-file)))

;; (use-package org-modern
;;   :ensure t
;;   :custom
;;   (global-org-modern-mode t)
;;   )
(font-lock-add-keywords 'org-mode
                          '(("^ *\\([-]\\) "
                             (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

;; (let* ((variable-tuple
;;           (cond ((x-list-fonts "ETBembo")         '(:font "ETBembo"))
;;                 ((x-list-fonts "Source Sans Pro") '(:font "Source Sans Pro"))
;;                 ((x-list-fonts "Lucida Grande")   '(:font "Lucida Grande"))
;;                 ((x-list-fonts "Verdana")         '(:font "Verdana"))
;;                 ((x-family-fonts "Sans Serif")    '(:family "Sans Serif"))
;;                 (nil (warn "Cannot find a Sans Serif Font.  Install Source Sans Pro."))))
;;          (base-font-color     (face-foreground 'default nil 'default))
;;          (headline           `(:inherit default :weight bold :foreground ,base-font-color)))

;;     (custom-theme-set-faces
;;      'user
;;      `(org-level-8 ((t (,@headline ,@variable-tuple))))
;;      `(org-level-7 ((t (,@headline ,@variable-tuple))))
;;      `(org-level-6 ((t (,@headline ,@variable-tuple))))
;;      `(org-level-5 ((t (,@headline ,@variable-tuple))))
;;      `(org-level-4 ((t (,@headline ,@variable-tuple :height 1.05))))
;;      `(org-level-3 ((t (,@headline ,@variable-tuple :height 1.05))))
;;      `(org-level-2 ((t (,@headline ,@variable-tuple :height 1.1))))
;;      `(org-level-1 ((t (,@headline ,@variable-tuple :height 1.2))))
;;      `(org-document-title ((t (,@headline ,@variable-tuple :height 2.0 :underline nil))))))


;; Focus on active text in org-mode
(use-package focus
  :ensure t
  ;; Below does not work...
  :custom
  (focus-mode-to-thing '((prog-mode . defun)
                         (text-mode . paragraph)
                         (org-mode . org-element)))
  )


;; Centering text in org-mode
;; Might affect magit to open in wrong window orientation...
(use-package olivetti
  :ensure t
  :hook (org-mode . olivetti-mode)
  :custom (olivetti-body-width 110)
  )


;; ORG ROAM
(use-package org-roam
  :ensure t
  :init
  (setq org-roam-v2-ack t)
  :custom
  (org-roam-directory "~/dotfiles/notes")
  (org-roam-completion-everywhere t)
  (org-agenda-files (list org-roam-directory))
  :bind
  (("C-c n" . org-roam-transient)
   :map org-mode-map
   ("C-M-i" . completion-at-point))
  :config
  (org-roam-setup))

(transient-define-prefix org-roam-transient ()
  "Org Roam note manager."
  [["Open note"
    ("n" "Find" org-roam-node-find :transient nil)
    ;; ("g" "Find (General)" (org-roam-node-find nil "General") :transient nil)
    ("b" "Find (branch)" org-roam-branch :transient nil)]
   ["Links"
    ("l" "Show backlinks" org-roam-buffer-toggle :transient nil)
    ("r" "Insert roam link" org-roam-node-insert :transient nil)
    ("s" "Store file link" org-store-link :transient nil)
    ("i" "Insert stored link" org-insert-link :transient nil)]
   ["Insert"
    ("c" "Code block" org-insert-structure-template :transient nil)
    ("t" "Time stamp" org-time-stamp :transient nil)]
   ["Focus"
    ("ff" "Focus mode" focus-mode :transient nil)
    ("fp" "Pin" focus-pin :transient nil)
    ("fu" "Unpin" focus-unpin :transient nil)
    ("fc" "Change Thing" focus-change-thing :transient nil)]
   ])


;; EGLOT
(use-package eglot
  :ensure t
  :defer t
  :hook (python-ts-mode . eglot-ensure)
  (javascript-mode . eglot-ensure))


;; DAPE debugger
(use-package dape
  :ensure t
  :init
  (setq dape-buffer-window-arrangment 'left)
  :config
  ;; By default dape uses gdb keybinding prefix
  (setq dape-key-prefix "\C-x\C-a")
  )

(transient-define-prefix dape-transient ()
  "Transient for dape."
  [["Stepping"
    ("n" "Next" dape-next :transient t)
    ("i" "Step in" dape-step-in :transient t)
    ("o" "Step out" dape-step-out :transient t)
    ("c" "Continue" dape-continue :transient t)
    ("r" "restart" dape-restart :transient t)]
   ["Breakpoints"
    ("bb" "Toggle" dape-breakpoint-toggle :transient t)
    ("bd" "Remove" dape-remove-breakpoint-at-point :transient t)
    ("bD" "Remove all" dape-breakpoint-remove-all :transient t)
    ("bl" "Log" dape-breakpoint-log :transient t)]
   ["Info"
    ("Ii" "Info" dape-info :transient t)
    ("Im" "Memory" dape-read-memory :transient t)
    ("Is" "Select Stack" dape-select-stack :transient nil)
    ("R" "Repl" dape-repl :transient t)]
   ["Session"
    ("ss" "Start" dape :transient nil)
    ("sq" "Quit" dape-quit :transient nil)
    ("sk" "Kill" dape-kill :transient nil)]
   ["Navigation"
    ("<up>" "Prev" previous-line :transient t)
    ("<down>" "Next" next-line :transient t)
    ("q" "Close" transient-quit-all :transient nil)]
   ])

;; IVY SEARCH MODE
(use-package ivy
  :ensure t
  :defer 0.1
  :bind ("C-<return>" . ivy-immediate-done)
  :config
  (ivy-mode 1)
  (ivy-posframe-mode 1)
  (ivy-rich-mode 1))

;; AMX Added information to ivy frame
(use-package amx
  :ensure t
  :after ivy
  :custom
  (amx-backend 'auto)
  :config
  (amx-mode 1))


;; INDENTING STUFF.
(setq-default indent-tabs-mode nil) ;; No tabs only spaces
(dtrt-indent-global-mode 1)


;; CHATGPT-SHELL
;; For authetication add your OpenAI key to ~/.authinfo
;; Ex:
;; machine openai.com password [key from platform.openai.com]
(use-package chatgpt-shell
  :ensure t
  :custom
  ((chatgpt-shell-openai-key
    (lambda ()
      (auth-source-pick-first-password :host "openai.com")))))

;; Adds color matching brackets
(use-package rainbow-delimiters
  :ensure t
  :defer t
  :hook (prog-mode . rainbow-delimiters-mode))

;; Colorize color names in buffers
(use-package rainbow-mode
  :ensure t
  :hook (prog-mode text-mode))


;; Trim unnecessary whitespace when file is saved
;; (use-package ws-butler
;;   :ensure t
;;   :hook (prog-mode))


;; GRIP CONFIG (Org-mode and Markdown-mode preview)
(setq grip-update-after-change nil)
;; TODO: Log in to GitHub account


;; ORG-BABEL Execute ORG code blocks
(setq org-confirm-babel-evaluate nil) ;; Don't prompt execution
(org-babel-do-load-languages
 'org-babel-load-languages '((emacs-lisp . t)
                             (shell . t)
                             (C . t)
                             (python . t)
                             (http . t)
                             (gnuplot . t)))

(use-package gnuplot
  :ensure t) ;; TODO: Add gnuplot-mode also?

;; COMPANY-ORG-BLOCK (Auto complete of org-mode code blocks)
;; TODO: Remove?
(use-package company-org-block
  :ensure t
  :custom
  (company-org-block-edit-style 'inline) ;; 'auto, 'prompt, or 'inline
  :hook ((org-mode . (lambda ()
                       (setq-local company-backends '(company-org-block))
                       (company-mode +1)))))



;; CUSTOM FUNCTIONS

;; SELF DEFINED RECURSIVE FILE SEARCH
(defun my-counsel-file-jump (&optional arg)
  ;;"Forward to `counsel-file-jump'.
  ;;When prefix ARG is nil, pass non-nil prefix argument to
  ;;`counsel-file-jump'.  Otherwise, pass nil prefix argument."
  (interactive)
  (setq current-prefix-arg (and (not arg) '(4)))
  (call-interactively #'counsel-file-jump))

(defun treesit-install-language-grammar-all ()
  (interactive)
  (mapc #'treesit-install-language-grammar (mapcar #'car treesit-language-source-alist)))

(defun notes ()
  (interactive)
  (find-file "~/notes/notes.org"))

;; defun for opening org roam for active git branch
(defun org-roam-branch ()
  (interactive)
  (let ((branch (magit-get-current-branch)))
    (org-roam-node-find nil branch)))

;; CUSTOM KEYBINDINGS

;; Scroll with keyboard
(global-set-key (kbd "M-<up>") 'scroll-down-line)
(global-set-key (kbd "M-<down>") 'scroll-up-line)

;; Comment line in and out
(global-set-key (kbd "C-;") 'comment-line)

;; Open GIT client magit
(global-set-key (kbd "C-c g") 'magit) ;; "C-x g" also works

;; Aligns selected section by regex
(global-set-key (kbd "C-c C-q") 'align-regexp)

;; Reqursive search
(global-set-key (kbd "C-S-s") 'rgrep)

;; DAPE debugger
(global-set-key (kbd "<f5>")  'dape-transient)
(global-set-key (kbd "C-c d") 'dape-transient)
(global-set-key (kbd "C-c D") 'dape)


;; Swap to recursive file search by default
;; define-key has higher priority than global-set-key
(define-key (current-global-map) (kbd "C-x C-S-f") 'find-file)
(define-key (current-global-map) (kbd "C-x C-f") 'project-find-file)

;; Starts webserver for live preview of org and md files
(add-hook 'org-mode-hook
          '(lambda ()
             (local-set-key (kbd "C-x C-g") 'grip-mode)))
(add-hook 'markdown-mode-hook
          '(lambda ()
             (local-set-key (kbd "C-x C-g") 'grip-mode)))

;; Change active buffer window
;; Change with shift-arrows
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))
;; Shange with C-c C-arrows
(global-set-key (kbd "C-c C-<left>")  'windmove-left)
(global-set-key (kbd "C-c C-<right>") 'windmove-right)
(global-set-key (kbd "C-c C-<up>")    'windmove-up)
(global-set-key (kbd "C-c C-<down>")  'windmove-down)

;; Multiple cursors
(global-set-key (kbd "C-S-<mouse-1>") 'mc/add-cursor-on-click)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)


;; CUSTOM HYDRA MENUS
(use-package hydra
  :ensure t
  :defer 2
  :bind ("C-c c" . major-hydra/body)
  :bind ("C-c s" . package-hydra/body))

;;(defvar major-hydra--title (with-faicon "Window Management" 1 -0.05))
(pretty-hydra-define major-hydra (:color blue :foreign-keys warn :title "Major mode" :quit-key "q")
  ("Actions"
   (("s" rgrep "Search recursive")
    ("a" align-regexp "Align regex (C-c C-q)")
    ("r" query-replace "Replace (M-S-5)" :color pink)
    ("u" undo "Undo (C-_)" :color pink)
    ("c" comment-region "Comment region (M-;)")
    ("C" uncomment-region "unComment region (M-;)"))

   "File"
   (("f" project-find-file "open File in project (C-x C-f)")
    ("F" find-file "open File (C-x C-F)"))

   "System"
   (("e" eshell "open Emacs shell"))
   ))
;;    ("p" package-hydra/body "Package handler (C-c s)"))))

(pretty-hydra-define package-hydra (:color blue :foreign-keys warn :title "Package handler" :quit-key "q")
  ("Settings"
   (("s" (find-file "~/nixos-conf/emacs/emacs.el") "Open emacs settings")
    ("l" (find-file "~/nixos-conf/emacs/emacs_local.el") "Open local emacs settings")
    ("u" (load-file "~/.emacs") "Reload config"))
   "Packages"
   (("L" package-list-packages "List all")
    ("i" package-install "Install" :color pink)
    ("r" package-delete "Remove" :color pink)
    ("U" package-refresh-contents "Update package list" :color pink))))
