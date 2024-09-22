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

  plugins.markview = {
    enable = true;

    settings = {
      mode = ["n" "i" "no" "c"];
      hybrid_modes = ["i"];
    };
  };

  keymaps = [
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
            filename = filename..".png"

            -- write link to file to buffer
            vim.cmd("r!echo \\!["..filename.."]")

            -- create blank file
            -- https://superuser.com/a/294948
            os.execute("${pkgs.imagemagick}/bin/magick -size 1000x600 xc:white "..filename)

            -- open drawing
            os.execute("${pkgs.drawing}/bin/drawing --new-tab "..filename.." &")
          end)
        end
      '';
    }
  ];
}
