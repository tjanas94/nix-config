{...}: {
  programs.readline = {
    enable = true;
    bindings = {
      "\\e[A" = "history-search-backward";
      "\\e[B" = "history-search-forward";
      "\\C-l" = "clear-screen";
    };
    variables = {
      colored-stats = true;
      completion-ignore-case = true;
      completion-prefix-display-length = 3;
      editing-mode = "vi";
      keymap = "vi-insert";
      mark-symlinked-directories = true;
      show-all-if-ambiguous = true;
      show-all-if-unmodified = true;
      show-mode-in-prompt = true;
      visible-stats = true;
    };
  };
}
