{
  config,
  inputs,
  ...
}: {
  imports = [inputs.sops-nix.nixosModules.sops];

  sops.age.sshKeyPaths = builtins.catAttrs "path" config.services.openssh.hostKeys;
}
