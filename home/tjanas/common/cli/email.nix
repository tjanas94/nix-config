{pkgs, ...}: {
  programs.mbsync.enable = true;
  programs.msmtp.enable = true;
  programs.notmuch.enable = true;

  accounts.email.accounts.outlook = {
    address = "tomek@janas.dev";
    flavor = "outlook.office365.com";
    mbsync = {
      enable = true;
      create = "maildir";
    };
    msmtp.enable = true;
    notmuch.enable = true;
    primary = true;
    realName = "Tomasz Janas";
    passwordCommand = "${pkgs.pass}/bin/pass web/live.com/tomek";
  };
}
