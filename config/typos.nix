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
    }
  ];

  userCommands = let
    inherit (lib) genAttrs toUpper toLower;

    # FIXME: command must start with uppercase
    alternateCase = cmd: lib.mapCartesianProduct
      ({ w ? "", q ? "", a ? "" }: w + q + a)
      (genAttrs
        (lib.stringToCharacters cmd)
        (c: [ (toLower c) (toUpper c) ])
      );

    mkLowerAlias = cmd: {
      command = toLower cmd;
      bang = true;
    };
  in
    genAttrs (lib.concatMap
        alternateCase
        [ "w" "q" "wq" "wa" "qa" "wqa" ]
      )
      mkLowerAlias;
}
