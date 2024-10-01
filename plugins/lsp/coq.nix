{...}: {
  plugins.coq-nvim = {
    enable = true;
    installArtifacts = true;

    settings.auto_start = "shut-up";
    # might turn this off
    settings.completion.always = true;
  };
}
