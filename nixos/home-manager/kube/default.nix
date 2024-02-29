{ pkgs, ... }:
{
  home.packages = with pkgs; [
    google-cloud-sdk
    kubectl
    k9s
    k3d
    kustomize
  ];
}
