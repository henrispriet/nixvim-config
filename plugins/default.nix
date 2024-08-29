{...}: {
  imports = [
    ./file-system.nix
    ./git.nix
    ./buffer.nix
    ./editing.nix
    ./terminal.nix
    ./telescope.nix
    ./lsp
    ./dressing.nix
  ];

  # TODO: switch from base16 gruvbox to nixvim gruvbox
  colorschemes.base16 = {
    enable = true;
    colorscheme = "gruvbox-dark-medium";
  };

  plugins = {
    # TODO: add prefix names (e.g. <leader>g => "+git")
    which-key.enable = true;
  };
}
