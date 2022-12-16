{
  inputs,
  tmuxPlugins,
}:
tmuxPlugins.mkTmuxPlugin {
  pluginName = "gruvbox-truecolor";
  rtpFilePath = "colorscheme-tpm.tmux";
  version = "master";
  src = inputs.tmux-gruvbox-truecolor;
}
