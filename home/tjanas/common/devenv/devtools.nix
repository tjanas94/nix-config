{pkgs, ...}: {
  home.packages = with pkgs; [
    nodePackages.bash-language-server
    nodePackages.dockerfile-language-server-nodejs
    nodePackages.prettier
    nodePackages.typescript
    nodePackages.typescript-language-server
    nodePackages.vscode-langservers-extracted
    nodePackages.yaml-language-server
    alejandra
    dockfmt
    editorconfig-core-c
    go
    gotools
    gopls
    html-tidy
    jdk
    jdt-language-server
    maven
    nodejs
    poetry
    (python3.withPackages (ps: with ps; [black grip isort mypy pip python-lsp-server pyls-isort pylsp-mypy python-lsp-black] ++ black.optional-dependencies.d ++ python-lsp-server.optional-dependencies.all))
    rnix-lsp
    shellcheck
    shfmt
    yarn
  ];
}
