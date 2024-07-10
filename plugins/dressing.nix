{float-styling, ...}: {
  plugins.dressing = {
    enable = true;

    settings = {
      input = {
        mappings.i."<esc>" = "Close";
        border = float-styling.border.name;
      };

      select = {
        backend = ["builtin"];
        builtin.border = float-styling.border.name;
      };
    };
  };
}
