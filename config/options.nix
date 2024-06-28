{...}: {
  globals.mapleader = " ";

  opts = {
    # Show line numbers
    number = true;
    # Show relative line numbers
    relativenumber = true;
    # Tab width should be 2
    shiftwidth = 2;

    # Search
    ignorecase = true;
    smartcase = true;

    # Highlight the current line
    cursorline = true;

    # better buffer splitting
    splitright = true;
    splitbelow = true;

    # Undo and backup options
    backup = false;
    writebackup = false;
    undofile = true;
    swapfile = true;
  };

  # System clipboard support
  clipboard = {
    register = "unnamedplus";
    providers.wl-copy.enable = true;
  };
}
