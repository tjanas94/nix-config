(setopt initial-major-mode 'org-mode
        use-short-answers t
        confirm-kill-emacs 'yes-or-no-p)

(setopt delete-selection-mode t
        electric-indent-mode nil
        electric-pair-mode t
        indent-tabs-mode nil
        blink-cursor-mode nil
        global-auto-revert-mode t
        dired-kill-when-opening-new-dired-buffer t
        recentf-mode t
        tab-width 4
        make-backup-files nil
        auto-save-default nil)

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
  (setq magit-display-buffer-function #'magit-display-buffer-fullframe-status-v1))

(use-package which-key
  :config
  (which-key-mode))
