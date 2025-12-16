{ pkgs, ... }: {
  programs = {
    git = {
      enable = true;
      signing = {
        key = "837FDAFB013D15D9!";
        # key = "EC48ED8BCF7E7E6B!";
        # key = "77D475DAB183F4D7!";
        # key = "A22B68DB843C5CB5!";
        # key = "6A2CC42E4E64130E!";
        signByDefault = true;
      };
      settings = {
        aliases = {
          wip = "commit -nm 'WIP'";
          r2p = "reset --hard @{push}";
          r2u = "reset --hard @{upstream}";
        };
        apply.whitespace = "nowarn";
        branch = {
          autoSetupMerge = "inherit";
          sort = "-committerdate";
        };
        checkout.defaultRemote = "origin";
        commit.verbose = true;
        diff.algorithm = "histogram";
        init.defaultBranch = "master";
        merge = {
          tool = "vimdiff";
          conflictStyle = "zdiff3";
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
        rebase = {
          autoSquash = true;
          updateRefs = true;
        };
        rerere.enabled = true;
        tag.gpgSign = true;
        user.name = "Tomasz Janas";
        user.email = "tomek@janas.dev";
        worktree.guessRemote = true;
      };
      ignores = [
        "node_modules/"
        "__pycache__/"
        ".direnv/"
        ".clj-kondo"
        ".lsp"
        ".nrepl-port"
        "*.bak"
        "*.env"
        "*.log"
        "*.py[cod]"
        "*.retry"
        "*.sock"
        "*.swp"
        "*.tmp"
        "*~"
      ];
    };
    delta = {
      enable = true;
      enableGitIntegration = true;
      package = pkgs.delta;
      options = {
        line-numbers = true;
        navigate = true;
      };
    };
  };
}
