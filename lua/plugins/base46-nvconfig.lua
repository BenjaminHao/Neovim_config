return {
  "BenjaminHao/base46-nvconfig",
  lazy = false,
  dependencies = {
    { "NvChad/base46", branch = "v2.5" },
    "nvim-lua/plenary.nvim",
  },
  config = function()
    require("nvconfig.config").setup({
      -- configs from nvchad/nvconfig
      -- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua
      ui = {
        theme = "catppuccin",
        transparency = false,
        cmp = {
          icons = true,
          lspkind_text = true,
          style = "atom_colored", -- default/flat_light/flat_dark/atom/atom_colored
        },
        telescope = { style = "borderless" }, -- borderless / bordered
      },
      base46 = {
        integrations = {
          "alpha",
          "blankline",
          "bufferline",
          "cmp",
          "defaults",
          "devicons",
          "git",
          "lsp",
          "mason",
          "nvimtree",
          "statusline",
          "syntax",
          "telescope",
          "todo",
          "treesitter",
          "whichkey",
        }
      }
    })
  end,
}
