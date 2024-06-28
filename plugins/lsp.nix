{getColor, ...}: {
  diagnostics.virtual_text = false;
  highlightOverride = let
    underline = {
      underline = true;
    };
  in {
    DiagnosticWarn.fg = getColor "0A";
    DiagnosticUnderlineError = underline // {sp = getColor "08";};
    DiagnosticUnderlineWarn = underline // {sp = getColor "0A";};
    DiagnosticUnderlineWarning = underline // {sp = getColor "0A";};
    DiagnosticUnderlineHint = underline // {sp = getColor "0C";};
  };

  # set diagnostic signs
  # https://smarttech101.com/nvim-lsp-diagnostics-keybindings-signs-virtual-texts/#severity_signs_in_nvim_lsp_diagnostics
  # https://github.com/nvim-lualine/lualine.nvim/blob/master/lua/lualine/components/diagnostics/config.lua#L8-L12
  extraConfigLua =
    /*
    lua
    */
    ''
      local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = "󰋽 " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end
    '';

  plugins.lsp = {
    enable = true;

    inlayHints = false;

    servers.rust-analyzer = {
      enable = true;

      # let rustc and cargo versions be managed by the flake instead
      installRustc = false;
      installCargo = false;
    };

    servers = {
      lua-ls.enable = true;
      nil-ls.enable = true;
      # nixd.enable = true;
    };
  };

  plugins.treesitter.enable = true;
  plugins.trouble = {
    enable = true;

    settings = {
      auto_close = true;
      auto_preview = true;
      cycle_results = true;
      use_diagnostic_signs = true;
      # warn_no_results = false;
      # open_no_results = true;
      focus = true;

      modes.cascade = {
        mode = "diagnostics"; # inherit from diagnostics mode
        # NOTE: why does this get formatted so strangely? ;-;
        filter.__raw =
          /*
          lua
          */
          ''
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
          action.__raw =
            /*
            lua
            */
            ''function() end'';
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

  keymaps = [
    {
      options.desc = "Open Diagnostics (Trouble)";
      key = "<leader>xx";
      action = "<cmd>Trouble cascade open<cr>";
    }
    {
      options.desc = "Close Diagnostics (Trouble)";
      key = "<leader>xX";
      action = "<cmd>Trouble cascade close<cr>";
    }
  ];
}
