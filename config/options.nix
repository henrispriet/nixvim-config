{...}: {
  globals.mapleader = " ";

  opts = {
    # Line numbers
    number = true;
    relativenumber = true;

    # Tabs
    # FIXME: 8 spaces (4 "tabs") automatically converted to \t
    shiftwidth = 2;

    # Search
    ignorecase = true;
    smartcase = true;

    # Highlight the current line
    cursorline = true;

    # Better buffer splitting
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
