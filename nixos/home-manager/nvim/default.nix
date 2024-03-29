{ pkgs, ... }:
{
  home.packages = with pkgs; [
    go
    gcc
    zig
    nodejs_21
    python312
    haskell.compiler.ghc94
    cabal-install
    terraform
    terraform-ls
    nil
    rustup
    (callPackage ./ghcup {})
    yaml-language-server
    haskellPackages.lsp
    haskellPackages.haskell-debug-adapter
    haskellPackages.haskell-language-server
  ];

  home.file.".config/nvim" = {
    source = pkgs.fetchFromGitHub {
      owner = "AstroNvim";
      repo = "AstroNvim";
      rev = "v3.43.1";
      sha256 = "sha256-/Qp/+38hgrTb24vGKgWEBbGgfRRgbxJ+jnKeE2d/MOE=";
    };
    recursive = true;
  };

  home.file.".config/nvim/lua/user/init.lua".source = ./init.lua;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };
}
