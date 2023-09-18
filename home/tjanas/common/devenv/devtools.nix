{ pkgs, ... }:
let
  jdtls = pkgs.writeShellScriptBin "jdtls" "exec -a $0 ${pkgs.jdt-language-server}/bin/jdt-language-server $@";
  haskellEnv = pkgs.haskellPackages.ghcWithHoogle (hs: with hs; [
    cabal-fmt.bin
    cabal-install
    fourmolu
    ghcid.bin
    haskell-language-server
    hlint
  ]);
  pythonEnv = pkgs.python3.withPackages (ps: with ps; [
    black
    grip
    isort
    mypy
    pip
    python-lsp-server
    pyls-isort
    pylsp-mypy
    python-lsp-black
  ] ++ black.optional-dependencies.d ++ python-lsp-server.optional-dependencies.all);
in
{
  home.packages = with pkgs; [
    editorconfig-core-c

    nodePackages.bash-language-server
    shellcheck
    shfmt

    dockfmt
    nodePackages.dockerfile-language-server-nodejs

    go
    gotools
    gopls

    haskellEnv

    jdk
    jdt-language-server
    jdtls
    maven

    html-tidy
    nodejs
    nodePackages."@tailwindcss/language-server"
    nodePackages.prettier
    nodePackages.typescript
    nodePackages.typescript-language-server
    nodePackages.vscode-langservers-extracted
    nodePackages.yaml-language-server
    yarn

    lua-language-server
    luajit
    luajitPackages.luacheck
    stylua

    nixpkgs-fmt
    rnix-lsp

    pythonEnv
  ];

  home.file.".ghci".source = ../../../../config/ghci;
}
