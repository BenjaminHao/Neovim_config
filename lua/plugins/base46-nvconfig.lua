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
        hl_override = {
          -- visual = { bg = "grey" },
          -- FIX: link to hl
          BufferLineDevIconLuaInactive = { bg = "red", fg = "green"},
          BufferLineNumbersVisible = { link = "BufferLineBufferVisible" },
          BufferLineNumbers = { link = "BufferLineBufferVisible" },
        },
      },
      base46 = {
        integrations = {
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
