{pkgs, ...}: {
  lspsAndRuntimeDeps = {
    # Always present
    general = with pkgs; [
      ripgrep
      fd
      commitlint-rs
      nixd
      alejandra
      lua-language-server
      stylua
      markdownlint-cli
    ];

    rust = with pkgs; [
      clippy
      rust-analyzer
      cargo
    ];

    zig = with pkgs; [
      zls_0_15
    ];
  };

  startupPlugins = {
    general = with pkgs.vimPlugins; [
      lze
      lzextras
      plenary-nvim
      nvim-web-devicons
      rose-pine
      vim-moonfly-colors
    ];
  };

  optionalPlugins = {
    general = {
      # Essential plugins and dependencies
      core = with pkgs.vimPlugins; [
        nvim-lspconfig
        nvim-treesitter.withAllGrammars
        indent-blankline-nvim-lua
        trouble-nvim
      ];

      # Plugins for handling code style
      style = with pkgs.vimPlugins; [
        conform-nvim
        nvim-lint
      ];

      # Extra utility plugins
      extra = with pkgs.vimPlugins; [
        telescope-nvim
        neo-tree-nvim
        lualine-nvim
        lualine-lsp-progress
        presence-nvim
      ];
    };
    cmp = with pkgs.vimPlugins; [
      luasnip
      blink-cmp
      cmp-cmdline
      blink-compat
    ];
  };
}
