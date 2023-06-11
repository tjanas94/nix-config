{
  services.borgbackup.repos."usb-backup" = {
    path = "/mnt/backup";
    allowSubRepos = true;
    authorizedKeys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKxJN9PYgboFoOgogRiwxx66PrWpC9iTwpXdyRtuLQ7A"
    ];
  };
}
