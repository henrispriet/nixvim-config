{...}: {
  plugins = {
    bufferline.enable = true;
    lualine = {
      enable = true;

      settings.options.globalstatus = true;
    };

    # for delete buffer picker
    telescope.enable = true;
  };

  keymaps = [
    {
      options.desc = "Next buffer";
      key = "]b";
      action = "<cmd>bn<cr>";
    }
    {
      options.desc = "Previous buffer";
      key = "[b";
      action = "<cmd>bp<cr>";
    }
    {
      options.desc = "Pick buffer";
      key = "gb";
      action = "<cmd>BufferLinePick<cr>";
    }
    {
      options.desc = "Delete buffers";
      key = "<leader>d";
      # TODO: inline?
      # TODO: replace with dressing.nvim?
      action.__raw = builtins.readFile ./telescope-pickers/delete_buffers.lua;
    }
  ];
}
