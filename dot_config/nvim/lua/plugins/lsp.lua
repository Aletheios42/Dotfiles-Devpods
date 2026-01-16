return {
  -- 1. Mason Core: Instala herramientas (Formatters, Debuggers)
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    opts = {
      -- Carga la lista de herramientas desde tu perfil generado por Chezmoi
      ensure_installed = require("config.profile_data").mason_tools,
    },
    config = function(_, opts)
      require("mason").setup(opts)

      -- Truco para auto-instalar herramientas que NO son LSP (como codelldb)
      local mr = require("mason-registry")
      for _, tool in ipairs(opts.ensure_installed) do
        local p = mr.get_package(tool)
        if not p:is_installed() then
          p:install()
        end
      end
    end,
  },

  -- 2. Mason LSP Config: Instala y configura servidores (LSP)
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
    config = function()
      local profile_data = require("config.profile_data")
      local lspconfig = require("lspconfig")
      -- Asegúrate de tener cmp-nvim-lsp instalado para esto
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      require("mason-lspconfig").setup({
        -- Carga la lista de LSPs desde tu perfil
        ensure_installed = profile_data.mason_lsp,
        automatic_installation = true,

        -- AQUÍ ESTÁ EL ARREGLO: handlers va dentro de setup()
        handlers = {
          -- 1. Configuración por defecto para cualquier servidor
          function(server_name)
            lspconfig[server_name].setup({
              capabilities = capabilities,
            })
          end,

          -- 2. Configuración específica para Rust
          ["rust_analyzer"] = function()
            lspconfig.rust_analyzer.setup({
              capabilities = capabilities,
              settings = {
                ["rust-analyzer"] = {
                  checkOnSave = { command = "clippy" },
                },
              },
            })
          end,
        },
      })
    end,
  },

  -- 3. Nvim LSP Config: El cliente LSP base de Neovim
  {
    "neovim/nvim-lspconfig",
    lazy = true,
  },
}
