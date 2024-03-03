(defvar old-file-name-handler file-name-handler-alist)
(setq file-name-handler-alist nil
      gc-cons-threshold most-positive-fixnum)

(add-hook 'after-init-hook (lambda nil
                             (setq gc-cons-threshold (* 2 1024 1024)
                                   file-name-handler-alist old-file-name-handler)))

(setopt menu-bar-mode nil
        scroll-bar-mode nil
        tool-bar-mode nil
        inhibit-startup-screen t
        initial-scratch-message nil)
