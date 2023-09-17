{ pkgs, ... }:
let
  jdtls = pkgs.writeShellScriptBin "jdtls" "exec -a $0 ${pkgs.jdt-language-server}/bin/jdt-language-server $@";
in
{
  home.packages = with pkgs; [
    haskellPackages.cabal-fmt
    haskellPackages.fourmolu
    nodePackages."@tailwindcss/language-server"
    nodePackages.bash-language-server
    nodePackages.dockerfile-language-server-nodejs
    nodePackages.prettier
    nodePackages.typescript
    nodePackages.typescript-language-server
    nodePackages.vscode-langservers-extracted
    nodePackages.yaml-language-server
    cabal-install
    cmake
    dockfmt
    editorconfig-core-c
    gcc
    ghc
    ghcid
    gnumake
    go
    gotools
    gopls
    haskell-language-server
    hlint
    html-tidy
    jdk
    jdt-language-server
    jdtls
    lazydocker
    lazygit
    lua-language-server
    maven
    nixpkgs-fmt
    nodejs
    (python3.withPackages (ps: with ps; [ black grip isort mypy pip python-lsp-server pyls-isort pylsp-mypy python-lsp-black ] ++ black.optional-dependencies.d ++ python-lsp-server.optional-dependencies.all))
    rnix-lsp
    shellcheck
    shfmt
    yarn
  ];
}
