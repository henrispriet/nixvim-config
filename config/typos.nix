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

  userCommands = with lib; let
    slideSplit = str: genList
      (i: {
        left = (substring 0 (i + 1) str);
        right = (substring (i + 1) (stringLength str) str);
      })
      (stringLength str);

    # generate all combinations that begin with upper case letters
    # e.g. "wq" -> [ "Wq" "WQ" ]
    beginUpperCombinations = word: map
      ({ left, right }: (toUpper left) + (toLower right))
      (slideSplit word);

    mkLowerAlias = cmd: {
      command = toLower cmd;
      bang = true;
    };
  in
    genAttrs
      (concatMap
        beginUpperCombinations
        [ "w" "q" "wq" "wa" "qa" "wqa" "bd" "bn" "bp" ]
      )
      mkLowerAlias;
}
