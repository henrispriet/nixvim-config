{
  float-styling,
  getColor,
  ...
}: {
  imports = [
    ./servers.nix
    ./trouble.nix
    ./otter.nix
  ];

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
  extraConfigLua = let
    border = float-styling.border.name;
  in
    /*
    lua
    */
    ''
      -- set lsp signs
      local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = "󰋽 " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end

      -- add borders to lsp
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
        vim.lsp.handlers.hover, {
          border = "${border}"
        }
      )

      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
        vim.lsp.handlers.signature_help, {
          border = "${border}"
        }
      )

      vim.diagnostic.config{
        float={border="${border}"}
      }
    '';

  plugins.fidget.enable = true;
  plugins.treesitter.enable = true;

  keymaps = [
    {
      options.desc = "Go to definition";
      key = "<leader>cd";
      action = "<cmd>Telescope lsp_definitions<cr>";
    }
    {
      options.desc = "Go to type definition";
      key = "<leader>ct";
      action = "<cmd>Telescope lsp_type_definitions<cr>";
    }
    {
      options.desc = "Lsp References";
      key = "<leader>cf";
      action = "<cmd>Telescope lsp_references<cr>";
    }
    {
      options.desc = "Lsp rename";
      key = "<leader>cr";
      action.__raw = "vim.lsp.buf.rename";
    }
    {
      options.desc = "Lsp Code Actions";
      key = "<leader>ca";
      action.__raw = "vim.lsp.buf.code_action";
    }
    {
      options.desc = "Format File";
      key = "<C-s>";
      action.__raw = "vim.lsp.buf.format";
    }
    {
      options.desc = "Line Diagnostic";
      key = "<leader>xl";
      action.__raw = "vim.diagnostic.open_float";
    }
  ];
}
