return {
  -- add gruvbox
  { "ellisonleao/gruvbox.nvim" },
  -- Configura cómo activar el tema sin LazyVim
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme gruvbox]])
    end,
  },
}
