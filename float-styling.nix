{
  size = rec {
    scalingFactor = 0.75;
    width.__raw =
      /*
      lua
      */
      ''math.floor(vim.o.columns * ${builtins.toString scalingFactor})'';
    height.__raw =
      /*
      lua
      */
      ''math.floor(vim.o.lines * ${builtins.toString scalingFactor})'';
  };

  border = let
    # list of possible border styles
    single = {
      name = "single";
      chars = {
        topLeft = "┌";
        horizontal = "─";
        topRight = "┐";
        vertical = "│";
        bottomRight = "┘";
        bottomLeft = "└";
        verticalRight = "┤";
        verticalLeft = "├";
        horizontalBottom = "┴";
        horizontalTop = "┬";
        center = "┼";
      };
    };
  in
    # selected border style
    single;
}
