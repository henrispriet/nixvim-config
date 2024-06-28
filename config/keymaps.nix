# General keymaps
# Plugins specific keymaps can be found where the plugin is declared
{...}: {
  keymaps = [
    # Disable search highlight
    {
      options.desc = "Disable search highlight";
      key = "?";
      action = "<cmd>noh<cr>";
    }

    # Shortcut to yank register
    {
      options.desc = "Shortcut to yank register";
      mode = ["n" "x"];
      key = "<leader>p";
      action = ''"0p'';
    }
    {
      options.desc = "Shortcut to yank register";
      mode = ["n" "x"];
      key = "<leader>P";
      action = ''"0P'';
    }

    # Move line up and down in NORMAL and VISUAL modes
    # Reference: https://vim.fandom.com/wiki/Moving_lines_up_or_down
    {
      options.desc = "Move line down";
      mode = "n";
      key = "<A-j>";
      action = "<CMD>move .+1<CR>";
    }
    {
      options.desc = "Move line up";
      mode = "n";
      key = "<A-k>";
      action = "<CMD>move .-2<CR>";
    }
    {
      options.desc = "Move line down";
      mode = "x";
      key = "<A-j>";
      action = ":move '>+1<CR>gv=gv";
    }
    {
      options.desc = "Move line up";
      mode = "x";
      key = "<A-k>";
      action = ":move '<-2<CR>gv=gv";
    }

    # Use operator pending mode to visually select the whole buffer
    # e.g. dA = delete buffer ALL, yA = copy whole buffer ALL
    {
      options.desc = "Whole buffer";
      mode = "o";
      key = "A";
      action = ":<C-U>normal! mzggVG<CR>`z";
    }
    {
      options.desc = "Whole buffer";
      mode = "x";
      key = "A";
      action = ":<C-U>normal! ggVG<CR>";
    }
  ];
}
