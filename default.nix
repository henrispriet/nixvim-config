{...}: {
  imports = [
    ./config
    ./plugins
    {
      _module.args = {
        float-styling = import ./float-styling.nix;
        getColor = b: {
          __raw =
            /*
            lua
            */
            ''require("base16-colorscheme").colors.base${b}'';
        };
      };
    }
  ];

  vimAlias = true;
  viAlias = true;
}
