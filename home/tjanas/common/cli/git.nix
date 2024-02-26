{
  programs.git = {
    enable = true;
    userName = "Tomasz Janas";
    userEmail = "tomek@janas.dev";
    signing = {
      key = "837FDAFB013D15D9!";
      # key = "EC48ED8BCF7E7E6B!";
      # key = "77D475DAB183F4D7!";
      # key = "A22B68DB843C5CB5!";
      # key = "6A2CC42E4E64130E!";
      signByDefault = true;
    };
    aliases.wip = "commit -nm 'WIP'";
    extraConfig = {
      apply.whitespace = "nowarn";
      branch.autoSetupMerge = "inherit";
      checkout.defaultRemote = "origin";
      init.defaultBranch = "master";
      merge = {
        tool = "vimdiff";
        conflictStyle = "diff3";
      };
      mergetool = {
        keepBackup = false;
        prompt = false;
      };
      pull.ff = "only";
      push = {
        default = "current";
        autoSetupRemote = true;
      };
      tag.gpgSign = true;
      worktree.guessRemote = true;
    };
    ignores = [
      "node_modules/"
      "__pycache__/"
      ".direnv/"
      "*.bak"
      "*.env"
      "*.log"
      "*.py[cod]"
      "*.retry"
      "*.swp"
      "*.tmp"
      "*~"
    ];
    delta = {
      enable = true;
      options = {
        line-numbers = true;
        navigate = true;
      };
    };
  };
}
