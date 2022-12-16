{
  inputs,
  vimUtils,
}:
vimUtils.buildVimPluginFrom2Nix {
  pname = "polyword.vim";
  version = "master";
  src = inputs.polyword-vim;
}
