(setopt initial-major-mode 'org-mode
        use-short-answers t
        confirm-kill-emacs 'yes-or-no-p)

(setopt indent-tabs-mode nil
        blink-cursor-mode nil
        global-auto-revert-mode t
        dired-kill-when-opening-new-dired-buffer t
        recentf-mode t
        tab-width 4
        make-backup-files nil
        auto-save-default nil
        create-lockfiles nil
        show-paren-mode 0)

(setopt enable-recursive-minibuffers t
        completion-cycle-threshold 1
        completions-detailed t
        tab-always-indent 'complete
        completion-styles '(basic initials substring)
        completion-auto-help 'always
        completions-max-height 20
        completions-format 'one-column
        completions-group t
        completion-auto-select 'second-tab)

(setopt line-number-mode t
        column-number-mode t
        display-line-numbers-type 'relative
        display-line-numbers-width 3
        global-display-line-numbers-mode t)

(use-package emacs
  :config
  (load-theme 'modus-vivendi)
  (savehist-mode)
  (windmove-default-keybindings 'control)
  :bind
  (("C-x k" . kill-this-buffer)
  :map minibuffer-mode-map
  ("TAB" . minibuffer-complete)))

(use-package magit
  :config
  (setopt magit-display-buffer-function #'magit-display-buffer-fullframe-status-v1))

(use-package which-key
  :config
  (which-key-mode))

(use-package org
  :config
  (setopt org-confirm-babel-evaluate nil)
  (add-to-list 'org-modules 'org-tempo)
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (http . t))))

(use-package paredit
  :hook
  ((emacs-lisp-mode . paredit-mode)
   (eval-expression-minibuffer-setup . paredit-mode)
   (ielm-mode . paredit-mode)
   (lisp-interaction-mode . paredit-mode)
   (lisp-mode . paredit-mode)
   (slime-repl-mode . paredit-mode)
   (slime-repl-mode . override-slime-del-key))
  :config
  (defun override-slime-del-key ()
    (define-key slime-repl-mode-map
      (read-kbd-macro paredit-backward-delete-key) nil)))

(use-package slime
  :config
  (setopt inferior-lisp-program "sbcl"))
