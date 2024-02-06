{ pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    wezterm
    starship
    nushell
    zsh
    tmux
    kitty
  ];

  home.sessionVariables = {
    SHELL = "${pkgs.zsh}/bin/zsh";
  };

  programs.zsh = {
    enable = true;
    "oh-my-zsh" = {
      enable = true;
      plugins = [
        "git"
        "1password"
        "tmux"
        "cabal"
        "copybuffer"
        "docker-compose"
        "docker"
        "dotenv"
        "encode64"
        "fluxcd"
        "fzf"
        "gcloud"
        "gh"
        "golang"
        "hasura"
        "helm"
        "httpie"
        "kubectl"
        "node"
        "npm"
        "pip"
        "python"
        "redis-cli"
        "qrcode"
        "rust"
        "starship"
        "sudo"
        "terraform"
        "yarn"
        "z"
      ];
    };
    sessionVariables = {
      ZSH_TMUX_AUTOSTART = true;
      ZSH_TMUX_AUTOCONNECT = false;
    };
  };

  programs.tmux = {
    enable = true;
    customPaneNavigationAndResize = true;
    shell = "${pkgs.zsh}/bin/zsh";
    extraConfig = (builtins.readFile ./tmux.conf);
    keyMode = "vi";
    mouse = true;
  };

  programs.wezterm = {
    enable = true;
    enableZshIntegration = true;
    extraConfig = builtins.readFile ./wezterm.lua;
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      format = lib.concatStrings [
        "$kubernetes"
        "$directory"
        "$git_branch"
        "$git_status"
        "$nodejs"
        "$rust"
        "$golang"
        "$haskell"
        "$line_break"
        "$character"
      ];

      add_newline = false;

      kubernetes = {
        disabled = false;
      	format = "[$context:$namespace](yellow bold) ";
      };

      directory = {
        truncate_to_repo = true;
        truncation_length = 1;
        format = "[$path]($style)[$lock_symbol]($lock_style) ";
      };

      golang = {
        symbol = " ";
      };

      line_break = {
        disabled = true;
      };
    };
  };
}
