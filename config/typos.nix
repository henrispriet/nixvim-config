{ lib, ... }: {
  # Correct common typos

  keymaps = [
    {
      key = "q:";
      action = "<cmd>q<cr>";
      mode = ["n" "c"];
    }
    {
      key = "<f1>";
      action = "";
      mode = ["n" "i"];
    }
  ];

  userCommands = let
    inherit (lib) genAttrs toUpper toLower;

    alternateCase = cmd: lib.mapCartesianProduct
      ({ w ? "", q ? "", a ? "" }:
        # HACK: ensure that first letter is upper (stupid nvim requirement)
        if w != "" then
          (toUpper w) + q + a
        else
          toUpper q + a
      )
      (genAttrs
        (lib.stringToCharacters cmd)
        (c: [ (toLower c) (toUpper c) ])
      );

    mkLowerAlias = cmd: {
      command = toLower cmd;
      bang = true;
    };
  in
    genAttrs
      (lib.unique
        (lib.concatMap
          alternateCase
          [ "w" "q" "wq" "wa" "qa" "wqa" ]
        )
      )
      mkLowerAlias;
}
