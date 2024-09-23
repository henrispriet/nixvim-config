{pkgs, ...}: {
  plugins.mkdnflow = {
    enable = true;

    # fix conflicting keymap '-' with oil.nvim
    mappings.MkdnDecreaseHeading = {
      key = "=";
      modes = "n";
    };

    perspective = {
      priority = "root";
      rootTell = "index.md";
    };

    modules = {
      lists = false;
      folds = false;
      tables = false;
      bib = false;
    };
  };

  # TODO: find better way to preview markdown
  plugins.markdown-preview.enable = true;

  keymaps = [
    {
      options.desc = "Toggle Markdown Preview";
      key = "<leader>mp";
      action = "<cmd>MarkdownPreviewToggle<cr>";
    }
    {
      options.desc = "Quick insert image";
      key = "<leader>md";
      action.__raw = /* lua */ ''
        function()
          vim.ui.input("filename", function(filename)
            if filename == nil then
              -- return if input is canceled
              return
            elseif filename == "" then
              -- generater random name if none is given
              local fp = io.popen("base32 /dev/urandom | head -c 15")
              filename = fp:read("*all")
              fp:close()
            end

            -- echo -n because date appends a newline >:(
            local fp = io.popen("echo -n $(date '+%Y-%m-%d')")
            date = fp:read("*all")
            fp:close()

            filename = (date.."_"..filename..".png")

            -- write link to file to buffer
            local command = "r!echo \\!["..filename.."]"
            vim.cmd(command)

            local filename_escaped = filename:gsub("'", "\\'")

            -- create blank file
            -- https://superuser.com/a/294948
            os.execute("${pkgs.imagemagick}/bin/magick -size 1000x600 xc:white '"..filename_escaped.."'")

            -- open drawing
            os.execute("${pkgs.drawing}/bin/drawing --new-tab '"..filename_escaped.."' &")
          end)
        end
      '';
    }
  ];
}
