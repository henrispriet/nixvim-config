{float-styling, ...}: {
  plugins.otter = {
    enable = true;
    settings.handle_leading_whitespace = true;
    settings.lsp.hover.border = with float-styling.border.chars; [topLeft horizontal topRight vertical bottomRight horizontal bottomLeft vertical];
    settings.lsp.buffers.set_filetype = true;
  };
  # necessary for some otter.nvim functionality
  plugins.treesitter.enable = true;
  plugins.treesitter.settings.highlight.enable = true;

  # auto otter.activate()
  autoGroups.auto_otter = {};
  autoCmd = [
    {
      desc = "auto activate otter.nvim";
      event = ["FileType"];
      # possible filetypes: https://github.com/neovim/neovim/blob/master/runtime/lua/vim/filetype.lua
      pattern = ["nix"];
      group = "auto_otter";
      callback.__raw = /* lua */ ''
	function()
	  require("otter").activate()
	end
      '';
    }
  ];
}
