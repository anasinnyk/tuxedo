{ pkgs, lib, config, ... }:
{
  home.packages = with pkgs; [
    elinks
    chafa
    exiftool
    atool
    ctpv
    fontforge
    ffmpeg
    highlight
    mdcat
    delta
    lf
    mutt
    mutt-wizard
    ueberzugpp
    shared-mime-info
    msmtp
    lsix
    libnotify
    poppler_utils
    imagemagick
    ffmpegthumbnailer
    fontpreview
    notmuch
    abook
    urlscan
    wezterm
    starship
    nushell
    zsh
    tmux
    kitty
    fzf
    disfetch
    lolcat
    cowsay
    onefetch
    gnugrep
    gnused
    gnumake
    bottom
    fd
    bc
    jq
    yq-go
    ripgrep
    eza
    bat
    btop
    httpie
    whois
    unzip
    neofetch
  ];

  home.sessionVariables = {
    SHELL = "${pkgs.zsh}/bin/zsh";
  };

  programs.zsh = {
    enable = true;
    shellAliases = {
      "ls" = "eza --icons -l -T -L=1";
      "cat" = "bat";
      "top" = "btop";
      "grep" = "rg";
    };
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

  home.file.".config/tmux/plugins/tpm" = {
    source = pkgs.fetchFromGitHub {
      owner = "tmux-plugins";
      repo = "tpm";
      rev = "v3.1.0";
      sha256 = "sha256-CeI9Wq6tHqV68woE11lIY4cLoNY8XWyXyMHTDmFKJKI=";
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

  home.file.".config/mutt" = {
    source = ./mutt;
    recursive = true;
  };

  sops = {
    secrets = {
      "imap/password" = {
        sopsFile = ./mutt/proton.sops.yaml;
      };
      email = {
        sopsFile = ./mutt/proton.sops.yaml;
      };
    };
  };
  
  home.file.".config/mutt/protonmail" = {
    text = ''
      set imap_pass = "$(cat ${config.sops.secrets."imap/password".path})"
      set imap_user = "$(cat ${config.sops.secrets.email.path})"
      set from = "$(cat ${config.sops.secrets.email.path})"
      set smtp_url = "smtp://$(cat ${config.sops.secrets.email.path}):$(cat ${config.sops.secrets."imap/password".path})@localhost:1025"
    '';
  };

  programs.lf = {
    enable = true;
    settings = {
      sixel = true;
    };
    keybindings = {
      U = "!du -sh";
      gh = "cd ~";
      i = "$less $f";
    };

    previewer.source = pkgs.writeShellScript "pv.sh" ''
      #!/bin/sh

      case "$(${pkgs.file}/bin/file -Lb --mime-type -- "$1")" in
          image/*)
              ${pkgs.chafa}/bin/chafa -f sixel -s "$2x$3" --animate false "$1"
              exit 1
              ;;
      esac

      case "$1" in
          *.tar*) tar tf "$1";;
          *.zip) unzip -l "$1";;
          *.rar) unrar l "$1";;
          *.7z) 7z l "$1";;
          *.pdf) pdftotext "$1" -;;
          *) highlight -O ansi "$1" || cat "$1";;
      esac
    '';
  };
}
