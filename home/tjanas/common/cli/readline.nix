{
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
      mark-symlinked-directories = true;
      show-all-if-ambiguous = true;
      show-all-if-unmodified = true;
      visible-stats = true;
    };
  };
}
