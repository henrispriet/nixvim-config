{...}: {
  plugins.coq-nvim.enable = true;
  plugins.coq-nvim.installArtifacts = true;

  # might turn this off
  plugins.coq-nvim.settings.completion.always = true;

  # auto COQnow
  autoGroups.auto_coq = {};
  autoCmd = [
    {
      desc = "auto activate coq.nvim";
      event = ["BufAdd"];
      # possible filetypes: https://github.com/neovim/neovim/blob/master/runtime/lua/vim/filetype.lua
      pattern = ["*"];
      group = "auto_coq";
      command = "COQnow";
    }
  ];
}
