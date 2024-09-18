{...}: {
  plugins.coq-nvim.enable = true;
  plugins.coq-nvim.installArtifacts = true;

  # might turn this off
  plugins.coq-nvim.settings.completion.always = true;
  plugins.coq-nvim.settings.auto_start = "shut-up";
}
