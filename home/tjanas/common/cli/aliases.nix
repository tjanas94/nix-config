{ ... }: {
  home = {
    shellAliases = {
      cat = "bat";
      df = "df -h";
      free = "free -h";
      rm = "rm -I";
      sc = "sudo systemctl";
      scu = "systemctl --user";
    };

    sessionVariables.LIBVIRT_DEFAULT_URI = "qemu:///system";
  };
}
