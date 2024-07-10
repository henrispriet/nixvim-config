{
  getColor,
  lib,
  ...
}: {
  # https://www.reddit.com/r/neovim/comments/gofplz/comment/g5sgtjp/
  autoGroups.highlight_yanked = {};
  autoCmd = [
    {
      desc = "Highlight yanked region";
      event = ["TextYankPost"];
      group = "highlight_yanked";
      callback.__raw =
        /*
        lua
        */
        ''
          function()
            vim.highlight.on_yank({higroup="Visual", timeout=400})
          end
        '';
    }
  ];

  plugins = {
    flash = {
      enable = true;

      settings.modes.search.enabled = true;
    };

    indent-blankline.enable = true;

    # TODO: finetune pair rules
    # add `<>` and `||` with _correct_ rules (for use in Rust)
    nvim-autopairs.enable = true;

    mini = {
      enable = true;

      modules = {
        comment = {};

        surround = {
          respect_selection_type = true;
          search_method = "cover_or_next";
          silent = true;

          # swaps default behaviour of left bracket and right bracket for all bracket types
          # ok i admit, i had a little fun here...
          custom_surroundings = with lib;
            pipe ["()" "[]" "{}" "<>"]
            [
              (map stringToCharacters)
              (map (pair: {
                ${head pair} = pair;
                ${last pair} = pair;
              }))
              (foldl mergeAttrs {})
              (mapAttrs (
                name: pair: let
                  space = optionalString (name == (last pair)) " ";
                in {
                  output = {
                    left = (head pair) + space;
                    right = space + (last pair);
                  };
                }
              ))
            ];
        };
      };
    };
  };

  # nvim inverts the highlight bg and fg of the character under the cursor
  # so give Flash hightlights (`FlashMatch`) a "bright" fg
  highlightOverride = let
    fg = getColor "0F";
    yellow = getColor "0A";
    orange = getColor "09";
  in {
    FlashCurrent = {
      inherit fg;
      bg = orange;
    };
    FlashMatch = {
      inherit fg;
      bg = yellow;
    };
    FlashLabel = {
      inherit fg;
      bg = yellow;
    };
  };
}
