{
  pkgs,
  float-styling,
  ...
}: {
  plugins = {
    oil = {
      enable = true;

      settings = {
        constrain_cursor = "name";
        experimental_watch_for_changes = true;

        # why, oil.nvim, do you make me set all of these seperately?
        # (i mean i get it but cmon)
        # but mostly why is float different (and worse, i mean only ints for size?) ;-;
        float = with float-styling; {
          border = border.name;
          max_width = size.width;
          max_height = size.height;
        };
        preview = with float-styling; {
          # width = size.scalingFactor;
          # height = size.scalingFactor;
          border = border.name;
        };
        progress.border = float-styling.border.name;
        ssh.border = float-styling.border.name;
        keymaps_help.border = float-styling.border.name;

        keymaps = {
          "q" = {
            # has to be : instead of <cmd> otherwise oil doesn't do the right thing
            callback = ":wq<cr>";
            nowait = true;
          };
          "<esc>" = {
            # has to be : instead of <cmd> otherwise oil doesn't do the right thing
            callback = ":bd!<cr>";
            mode = "n";
          };
        };
      };
    };

    # for custom file picker
    telescope.enable = true;
  };

  keymaps = [
    {
      options.desc = "Open parent dir of buffer in Oil";
      key = "-";
      action = "<cmd>Oil --float<cr>";
    }
    {
      options.desc = "Open cwd Oil";
      key = "_";
      action = "<cmd>Oil --float .<cr>";
    }
    {
      options.desc = "Find Files";
      key = "<leader><space>";
      # TODO: inline?
      action.__raw = builtins.readFile ./telescope-pickers/find_files_and_dirs.lua;
    }
  ];

  # for custom file picker
  extraPackages = [pkgs.fd];
}
