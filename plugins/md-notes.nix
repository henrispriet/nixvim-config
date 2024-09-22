{pkgs, ...}: {
  plugins.mkdnflow = {
    enable = true;

    perspective = {
      priority = "root";
      rootTell = "index.md";
    };
  };

  plugins.markview = {
    enable = true;

    settings = {
      mode = ["n" "i" "no" "c"];
      hybrid_modes = ["i"];
    };
  };

  # TODO: keymap to
  # - vim.input to choose filename
  # - create file (how to create empty image???)
  # - open file in pkgs.drawing
  # - if file was saved to, then insert markdown link to file, else do nothing
  keymaps = [
  ];
}
