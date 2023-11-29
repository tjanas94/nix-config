{ pkgs, ... }:
let
  jdtls = pkgs.writeShellScriptBin "jdtls" "exec -a $0 ${pkgs.jdt-language-server}/bin/jdt-language-server $@";
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

    babashka
    clojure
    clojure-lsp
    fennel
    joker
    leiningen

    nodePackages.bash-language-server
    shellcheck
    shfmt

    dockfmt
    nodePackages.dockerfile-language-server-nodejs

    go
    gotools
    gopls

    jdk
    jdt-language-server
    jdtls
    maven

    bun
    html-tidy
    nodejs
    nodePackages."@astrojs/language-server"
    nodePackages."@tailwindcss/language-server"
    nodePackages.prettier
    nodePackages.typescript
    nodePackages.typescript-language-server
    nodePackages.vscode-langservers-extracted
    nodePackages.yaml-language-server

    lua-language-server
    luajit
    luajitPackages.luacheck
    stylua

    nixd

    pythonEnv

    cargo
    cargo-cache
    cargo-watch
    clippy
    clang
    rust-analyzer
    rustc
    rustfmt
  ];
}
