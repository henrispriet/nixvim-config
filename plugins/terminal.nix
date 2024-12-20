{
  pkgs,
  float-styling,
  ...
}: {
  plugins.toggleterm = {
    enable = true;

    settings = {
      direction = "float";
      # <C-/> is actually read as <C-_> by (some?) terminal emulators
      # because terminal emulators are weird
      open_mapping.__raw =
        /*
        lua
        */
        "{ [[<C-/>]], [[<C-_>]] }";

      float_opts = with float-styling; {
        border = border.name;
        width = size.width;
        height = size.height;
      };
    };
  };

  # TODO: custom commands for bg term: BgRun, BgView, BgKill (names subject to change)
  # https://github.com/akinsho/toggleterm.nvim/?tab=readme-ov-file#custom-terminals
  # + maybe a command to send lines to bg term (BgSendLine)? https://github.com/akinsho/toggleterm.nvim/?tab=readme-ov-file#sending-lines-to-the-terminal

  # run one shell command (in an interactive bash shell)
  # and show the ouput in a floating toggleterm window
  userCommands."Do" = {
    desc = "Run a shell command";
    nargs = "+";
    complete = "shellcmd";
    command.__raw = let
      # more colorful exit status message than the one provided by close_on_exit = false
      postCommand = pkgs.writeShellScript "check-return" ''
        EXIT=$?
        if [[ $EXIT == 0 ]]; then
          # green
          color="\e[32m"
        else
          # red
          color="\e[31m"
        fi
        echo -en "$color""exited with code $EXIT - press ENTER to continue\e[0m"
        read -rs
      '';
    in
      /*
      lua
      */
      ''
        -- https://github.com/akinsho/toggleterm.nvim/?tab=readme-ov-file#custom-terminals
        function(command)
          require('toggleterm.terminal').Terminal:new({
            cmd = "bash -ic '"..command.args.."; . ${postCommand}'",
            display_name = command.fargs[1],
            direction = "float",
            close_on_exit = true,
          }):toggle()
        end
      '';
  };
}
