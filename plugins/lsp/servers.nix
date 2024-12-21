{...}: {
  plugins.lsp = {
    enable = true;

    inlayHints = false;

    servers.rust_analyzer = {
      enable = true;

      # let rustc and cargo versions be managed by the project
      installRustc = false;
      installCargo = false;
    };

    servers = {
			# lua
      lua_ls.enable = true;
			# nix (broken)
      nixd.enable = true;

			# html
      html.enable = true;
			# javascript/typescript
      ts_ls.enable = true;
			# SQL
      # needs configing with db connection
      # sqls.enable = true;

			# bash
      bashls.enable = true;
			# markdown
      marksman.enable = true;

			# C/C++
			ccls.enable = true;
    };
  };
}
