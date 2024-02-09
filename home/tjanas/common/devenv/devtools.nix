{ pkgs, ... }:
let
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
    gofumpt
    gopls
    gotools
    go-tools

    jdk
    jdt-language-server
    maven

    bun
    html-tidy
    nodejs
    nodePackages."@astrojs/language-server"
    nodePackages."@tailwindcss/language-server"
    nodePackages.graphql-language-service-cli
    nodePackages.prettier
    nodePackages.typescript
    nodePackages.typescript-language-server
    nodePackages.vscode-langservers-extracted
    nodePackages.yaml-language-server
    prettierd

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
    clang-tools
    rust-analyzer
    rustc
    rustfmt

    zig
    zls
  ];
}
