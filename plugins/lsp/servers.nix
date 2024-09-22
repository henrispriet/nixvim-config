{...}: {
  plugins.lsp = {
    enable = true;

    inlayHints = false;

    servers.rust-analyzer = {
      enable = true;

      # let rustc and cargo versions be managed by the project
      installRustc = false;
      installCargo = false;
    };

    servers = {
      lua-ls.enable = true;
      nixd.enable = true;

      html.enable = true;
      ts-ls.enable = true;
      # needs configing with db connection
      # sqls.enable = true;

      bashls.enable = true;
      marksman.enable = true;
    };
  };
}
