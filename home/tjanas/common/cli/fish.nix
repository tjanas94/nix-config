{...}: {
  programs.fish = {
    enable = true;
    functions = {
      fish_greeting = {body = "";};
      fish_user_key_bindings = {
        body = ''
          fish_vi_key_bindings
          bind -M default \cf 'switch-project'
          bind -M insert \cf 'switch-project'
          bind -M visual \cf 'switch-project'
        '';
      };
    };
  };
}
