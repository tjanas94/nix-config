_: {
  home = {
    shellAliases = {
      cat = "bat -p";
      df = "df -h";
      free = "free -h";
      rm = "rm -I";
      sc = "sudo systemctl";
      scu = "systemctl --user";
    };

    sessionVariables.LIBVIRT_DEFAULT_URI = "qemu:///system";
  };
}
