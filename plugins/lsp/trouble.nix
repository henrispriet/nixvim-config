{...}: {
  plugins.trouble = {
    enable = true;

    settings = {
      auto_close = true;
      auto_preview = true;
      # warn_no_results = false;
      # open_no_results = true;
      focus = true;

      modes.cascade = {
        mode = "diagnostics"; # inherit from diagnostics mode
        # NOTE: why does this get formatted so strangely? ;-;
        filter.__raw = /* lua */ ''
          function(items)
            local severity = vim.diagnostic.severity.HINT
            for _, item in ipairs(items) do
              severity = math.min(severity, item.severity)
            end
            return vim.tbl_filter(
              function(item)
                return item.severity == severity
              end,
              items
            )
          end
        '';
      };

      # HACK: folke does not seem to like people disabling his keybinds i guess, jeez
      keys = let
        disable = {
          action.__raw = ''function() end'';
          desc = "-";
        };
      in {
        "?" = "help";
        "r" = "refresh";
        "q" = "close";
        "<esc>" = "cancel";
        "<cr>" = "jump";
        "j" = "next";
        "k" = "prev";
        "gg" = "first";
        "G" = "last";
        "<c-s>" = "jump_split";
        "<c-v>" = "jump_vsplit";
        "o" = disable;
        "<2-leftmouse>" = disable;
        "dd" = disable;
        "d" = disable;
        "i" = disable;
        "p" = disable;
        "P" = disable;
        "gb" = disable;
        "s" = disable;
      };
    };
  };

  # TODO: use keymapsOnEvent
  keymaps = [
    {
      options.desc = "Open Diagnostics (cascade)";
      key = "<leader>xx";
      action = "<cmd>Trouble cascade open<cr>";
    }
    {
      options.desc = "Close Diagnostics (cascade)";
      key = "<leader>xX";
      action = "<cmd>Trouble cascade close<cr>";
    }

    {
      options.desc = "Open Diagnostics (all)";
      key = "<leader>xa";
      action = "<cmd>Trouble diagnostics open<cr>";
    }
    {
      options.desc = "Close Diagnostics (all)";
      key = "<leader>xA";
      action = "<cmd>Trouble diagnostics close<cr>";
    }
  ];
}
