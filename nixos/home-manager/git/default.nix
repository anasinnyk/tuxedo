{ pkgs, ... }:
{
  home.packages = with pkgs; [
    github-copilot-cli
    github-cli
  ];
  programs.git = {
    enable = true;
    userName = "Andrii Nasinnyk";
    userEmail = "anasinnyk@pm.me";
    extraConfig = {
      init = { defaultBranch = "main"; };
    };
    aliases = {
      huyak = "git add . && git commit --amend --no-edit && git push -f";
    };
  };
}
