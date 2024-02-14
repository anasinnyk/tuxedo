{ pkgs, ... }:
{
  home.packages = with pkgs; [
    github-copilot-cli
    github-cli
    lazygit
  ];
  programs.git = {
    enable = true;
    userName = "Andrii Nasinnyk";
    userEmail = "anasinnyk@pm.me";
    extraConfig = {
      init = { defaultBranch = "main"; };
      url = {
        "git@github.com:" = { insteadOf = "https://github.com/"; };
      };
    };
    aliases = {
      huyak = "git add . && git commit --amend --no-edit && git push -f";
    };
  };
}
