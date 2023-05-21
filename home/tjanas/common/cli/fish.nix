_: {
  programs = {
    fish = {
      enable = true;
      functions = {
        fish_greeting = {body = "";};
      };
    };

    bash.initExtra = ''
      if [[ $(ps --no-header --pid=$PPID --format=comm) != "fish" && -z "$BASH_EXECUTION_STRING" ]]; then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec fish $LOGIN_OPTION
      fi
    '';
  };
}
