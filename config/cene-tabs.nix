{...}: {
  # for CenEka projects:
  # https://stackoverflow.com/a/2054782
  autoGroups.cene_tab = {};
  autoCmd = [
    {
      desc = "make tabs actual \t's with width 4";
      event = ["FileType"];
      # possible filetypes: https://github.com/neovim/neovim/blob/master/runtime/lua/vim/filetype.lua
      pattern = ["javascript" "html" "sql"];
      group = "cene_tab";
      callback.__raw =
        /*
        lua
        */
        ''
          function(_args)
            print("tabby")
            local o = vim.opt_local
            o.tabstop = 4
            o.shiftwidth = 4
            o.expandtab = false
          end
        '';
    }
  ];
}
