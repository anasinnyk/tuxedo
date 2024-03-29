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
    userEmail = "23741265+anasinnyk@users.noreply.github.com";
    extraConfig = {
      user = {
        signingkey = "A0B5BF87A3701CC5";
      };
      init = { defaultBranch = "main"; };
      url = {
        "git@github.com:" = { insteadOf = "https://github.com/"; };
      };
      commit = {
        gpgSign = true;
      };
    };
    aliases = {
      huyak = "git add . && git commit --amend --no-edit && git push -f";
    };
  };
}
