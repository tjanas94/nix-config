(setopt menu-bar-mode nil
        scroll-bar-mode nil
        tool-bar-mode nil
        inhibit-startup-screen t
        initial-scratch-message nil)

(setopt initial-major-mode 'org-mode
        use-short-answers t
        confirm-kill-emacs 'yes-or-no-p)

(setopt indent-tabs-mode nil
        tab-width 4
        global-auto-revert-mode t
        global-auto-revert-non-file-buffers t
        dired-kill-when-opening-new-dired-buffer t
        recentf-mode t
        savehist-mode t
        save-place-mode t
        make-backup-files nil
        create-lockfiles nil)

(setopt fido-vertical-mode t
        enable-recursive-minibuffers t
        completion-styles '(flex)
        completion-ignore-case t
        read-file-name-completion-ignore-case t
        read-buffer-completion-ignore-case t
        read-extended-command-predicate #'command-completion-default-include-p)

(setopt line-number-mode t
        column-number-mode t
        display-line-numbers-type 'relative
        display-line-numbers-width 3
        global-display-line-numbers-mode t)

(setopt which-key-mode t)

(load-theme 'ef-elea-dark t)

(defun tjanas/refresh-project-list ()
  (interactive)
  (setq project--list '())
  (seq-do
   (lambda (d) (project-remember-project (list 'vc 'Git d)))
   (magit-list-repos)))

(use-package magit
  :config
  (require 'magit-extras)
  (setopt magit-repository-directories '(("~/workspace" . 4))))

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

(unless (and (fboundp 'server-running-p)
             (server-running-p))
  (server-start))
