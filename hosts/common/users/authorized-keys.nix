{
  authorizedKeys.keys = [
    (builtins.readFile ../../../config/ssh/id_ed25519_1.pub)
    (builtins.readFile ../../../config/ssh/id_ed25519_2.pub)
    (builtins.readFile ../../../config/ssh/id_rsa_3.pub)
    (builtins.readFile ../../../config/ssh/id_ed25519_4.pub)
    (builtins.readFile ../../../config/ssh/id_ed25519_5.pub)
  ];
}
