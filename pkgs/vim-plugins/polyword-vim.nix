{
  inputs,
  vimUtils,
}:
vimUtils.buildVimPluginFrom2Nix {
  pname = "filetype.nvim";
  version = "master";
  src = inputs.filetype-nvim;
}
