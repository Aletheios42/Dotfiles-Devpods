return {
  -- 1. El motor de Treesitter solo
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false, -- Forzamos a que este sea el primero siempre
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },
        auto_install = true,
        highlight = { enable = true },
      })
    end,
  },

  -- 2. Los textobjects por separado y con carga retardada
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    event = "VeryLazy", -- ESTO es vital: no se cargará hasta que Neovim esté listo
    config = function()
      require("nvim-treesitter.configs").setup({
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
            },
          },
        },
      })
    end,
  },
}
