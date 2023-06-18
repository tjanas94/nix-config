;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Tomasz Janas"
      user-mail-address "tomek@janas.dev")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
(setq doom-font (font-spec :family "Hasklug Nerd Font Mono" :size 15)
      doom-variable-pitch-font (font-spec :family "Hasklug Nerd Font" :size 15)
      doom-big-font (font-spec :family "Hasklug Nerd Font Mono" :size 24))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-gruvbox)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type `relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(defun tjanas/default-project-name (project-root)
  (string-replace (expand-file-name "~/workspace/") "" (directory-file-name project-root)))

(after! projectile
  (setq
   projectile-project-search-path '(("~/workspace" . 4))
   projectile-project-name-function #'tjanas/default-project-name))

(after! elfeed
  (setq elfeed-goodies/entry-pane-size 0.5)
  (evil-define-key 'normal elfeed-show-mode-map
    (kbd "J") 'elfeed-goodies/split-show-next
    (kbd "K") 'elfeed-goodies/split-show-prev)
  (evil-define-key 'normal elfeed-search-mode-map
    (kbd "J") 'elfeed-goodies/split-show-next
    (kbd "K") 'elfeed-goodies/split-show-prev)
  (add-hook! 'elfeed-search-mode-hook #'elfeed-update))

(use-package! elfeed-tube
  :after elfeed
  :config
  (elfeed-tube-setup))

(use-package elfeed-tube-mpv
  :config
  (evil-define-key 'normal elfeed-show-mode-map
    (kbd "m") 'elfeed-tube-mpv)
  (evil-define-key 'normal elfeed-search-mode-map
    (kbd "m") 'elfeed-tube-mpv))

(after! org-mime
  (setq org-mime-export-options '(:section-numbers nil
                                  :with-author nil
                                  :with-toc nil)))

(setq
 +notmuch-sync-backend 'mbsync
 +notmuch-home-function (lambda () (notmuch-search "tag:inbox")))

(add-to-list 'auto-mode-alist '("\\.cdt\\'" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.ctp\\'" . php-mode))
(add-to-list 'auto-mode-alist '("\\.jqtpl\\'" . web-mode))

(mapc 'load (file-expand-wildcards "~/.config/doom/local/*.el"))
