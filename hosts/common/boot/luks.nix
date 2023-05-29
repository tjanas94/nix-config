{
  boot.initrd.luks = {
    gpgSupport = true;
    reusePassphrases = true;

    devices."luks-root" = {
      device = "/dev/disk/by-partlabel/root";

      gpgCard = {
        encryptedPass = ../../../config/gnupg/cryptkey.gpg;
        publicKey = ../../../config/gnupg/public.asc;
      };
    };
  };
}
