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

	# "IDE functionality" (i.e. code navigation)
	# NOTE: modularity!!! -> avoid language specific stuff ig?
	# TODO: setup DAP (core + virtual text)
	# TODO: file search: proximity-sort + key to toggle between file and dir mode + key to toggle hidden
	# TODO: allow binding shell commands to keys somehow (using `Do` or Toggleterm sendkeys) + perhaps also keybindings for `ToggleTermSend...`
	# TODO: install python lsp
	# TODO: keybind for `Telescope tags`? + how to make tags for languages other than c
	# TODO: parse command output to allow jumping to error lines (https://www.youtube.com/watch?v=WFLvcMiG38w?t=665) or better trouble.nvim integration????
	# TODO: keybinds to move/manage windows (switch between vsplit, hsplit, float + adjust window size)
	# TODO: nvim-remote maybe

  vimAlias = true;
  viAlias = true;
}
