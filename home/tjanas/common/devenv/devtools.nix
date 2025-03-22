{ pkgs, ... }:
let
  pythonEnv = pkgs.python3.withPackages (ps: with ps; [
    black
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
    gnumake

    nodePackages.bash-language-server
    shellcheck
    shfmt

    babashka
    clojure
    clojure-lsp

    dockfmt
    nodePackages.dockerfile-language-server-nodejs

    go
    gofumpt
    gopls
    gotools
    go-tools

    google-java-format
    jdk
    jdt-language-server
    maven

    bun
    html-tidy
    nodejs
    nodePackages."@astrojs/language-server"
    nodePackages."@astrojs/ts-plugin"
    nodePackages."@tailwindcss/language-server"
    nodePackages.prettier
    nodePackages.typescript
    nodePackages.typescript-language-server
    nodePackages.vscode-langservers-extracted
    nodePackages.yaml-language-server
    prettierd

    guile
    roswell
    sbcl

    lua-language-server
    luajit
    luajitPackages.fennel
    luajitPackages.luacheck
    luajitPackages.luarocks
    stylua

    nixd
    nixpkgs-fmt

    pythonEnv

    cargo
    cargo-cache
    cargo-watch
    clippy
    clang
    clang-tools
    rust-analyzer
    rustc
    rustfmt

    terraform
    terraform-ls
    tflint

    zig
    zls
  ];
}
