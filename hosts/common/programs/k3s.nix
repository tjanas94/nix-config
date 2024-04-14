{
  services.k3s.enable = true;

  environment.persistence."/persist".directories = [ "/var/lib/cni" "/var/lib/kubelet" "/var/lib/rancher" ];
}
