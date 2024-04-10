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
        theme = "onedark",
        transparency = false,
        telescope = { style = "borderless" }, -- borderless / bordered
        cmp = {
          style = "atom_colored",
        },
        hl_override = {
          visual = { bg = "grey" },
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
          "notify",
          "nvimtree",
          "syntax",
          "tbline",
          "telescope",
          "todo",
          "treesitter",
          "whichkey",
        }
      }
    })
  end,
}
