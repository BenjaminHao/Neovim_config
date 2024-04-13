--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│ FILE: plugins/base46-nvconfig.lua                                        │--
--│ DESC: a adapter plugin to use base46 (theme plugin)                      │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
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
        hl_add = {
          BufferLineNumbers = { link = "BufferLineBufferVisible" },
          BufferLineNumbersVisible = { link = "BufferLineBufferVisible" },
          BufferLineNumbersSelected = { link = "BufferLineBufferSelected" },
          BufferLineDevIconLua = { link = "BufferLineBufferVisible" },
          BufferLineDevIconLuaInactive = { link = "BufferLineBufferVisible" },
        },
        hl_override = {
          Visual = { bg = "grey" },
          LspReferenceText = { link = "Underlined" },
          LspReferenceRead = { link = "Underlined" },
          LspReferenceWrite = { link = "Underlined" },
        },
        theme = "catppuccin",
        transparency = false,
        telescope = { style = "borderless" }, -- borderless / bordered
        cmp = {
          style = "atom_colored",
        },
        statusline = {
          theme = "minimal",
        },
      },
      base46 = {
        integrations = {
          "blankline",
          "bufferline",
          "cmp",
          "codeactionmenu",
          "defaults",
          "devicons",
          "git",
          "lsp",
          "mason",
          "notify",
          "nvimtree",
          "statusline",
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
