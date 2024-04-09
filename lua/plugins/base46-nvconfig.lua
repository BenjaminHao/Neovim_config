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
        telescope = { style = "borderless" }, -- borderless / bordered
        cmp = {
          style = "atom_colored",
        },
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
