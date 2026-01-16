return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
      -- IMPORTANTE: Cargamos los datos generados por Chezmoi
      local profile_data = require("config.profile_data")

      require("nvim-treesitter.configs").setup({
        -- Usamos la lista dinámica
        ensure_installed = profile_data.treesitter,
        
        auto_install = true,
        highlight = { enable = true },
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
