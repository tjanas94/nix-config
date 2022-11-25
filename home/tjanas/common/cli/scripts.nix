{ ... }: {
  home = {
    file.".local/bin" = {
      source = ../../../../bin;
      recursive = true;
    };

    sessionPath = [ "$HOME/.local/bin" ];
  };
}
