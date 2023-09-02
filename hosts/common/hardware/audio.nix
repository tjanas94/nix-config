{ pkgs, ... }: {
  sound.enable = true;

  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;
  };

  environment.persistence."/persist".directories = [ "/var/lib/alsa" ];
}
