{ pkgs, ... }:
{
  home.packages = with pkgs; [
    kubectl
    k9s
    k3d
  ];
}
