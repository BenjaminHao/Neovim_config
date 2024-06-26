--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│ FILE: plugins/which-key.lua                                              │--
--│ DESC: showing pending key binds                                          │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function ()
    vim.o.timeout = true
    vim.o.timeoutlen = 500
  end,
  --━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
  --                          ┃ Config Function ┃
  --                          ┗━━━━━━━━━━━━━━━━━┛
  config = function()
    local wk = require("which-key")
    wk.setup({
      plugins = {
        marks = true,           -- shows a list of your marks on ' and `
        registers = true,       -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        spelling = {
          enabled = true,       -- enabling this will show WhichKey when pressing z= to select spelling suggestions
          suggestions = 20,     -- how many suggestions should be shown in the list?
        },
        presets = {
          operators = false,    -- adds help for operators like d, y, ...
          motions = false,       -- adds help for motions
          text_objects = false,  -- help for text objects triggered after entering an operator
          windows = false,      -- default bindings on <c-w>
          nav = false,          -- misc bindings to work with windows
          z = false,            -- bindings for folds, spelling and others prefixed with z
          g = false,            -- bindings for prefixed with g
        },
      },
      motions = {
        count = true,
      },
      popup_mappings = {
        scroll_down = "<c-d>", -- binding to scroll down inside the popup
        scroll_up = "<c-u>", -- binding to scroll up inside the popup
      },
      icons = {
        breadcrumb = "", -- symbol used in the command line area that shows your active key combo
        separator = "", -- symbol used between a key and it's label
        group = "", -- symbol prepended to a group 
      },
      window = {
        border = "rounded", -- none, single, double, shadow
        position = "bottom", -- bottom, top
        margin = { 1, 2, 1, 2 }, -- extra window margin [top, right, bottom, left]
        padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
        winblend = 0, -- 0-100 transparency
        zindex = 1000, -- positive value to position WhichKey above other floating windows.
      },
      layout = {
        height = { min = 4, max = 25 }, -- min and max height of the columns
        width = { min = 20, max = 50 }, -- min and max width of the columns
        spacing = 3, -- spacing between columns
        align = "center",
      },
      ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
      hidden = { "<silent>", "<cmd>", "<CMD>", "<cr>", "<CR>", "^:", "^ ", "^call ", "^lua " }, -- hide mapping boilerplate
      show_help = true, -- show help message on the command line when the popup is visible
      show_keys = true, -- show the currently pressed key on the command line
      triggers = "auto", -- automatically setup triggers
    })
    -------------------------- Which-key Labels --------------------------------
    -- Document existing key chains
    wk.register({
      ["<leader>"] = {
        S = {
          "z=", "[S]pelling", noremap = false
        },
        b = {
          name = "[b]uffer", _ = "which_key_ignore"
        },
        d = {
          name = "[d]iagnostic", _ = "which_key_ignore"
        },
        f = {
          name = "[f]ind", _ = "which_key_ignore"
        },
        g = {
          name = "[g]it", _ = "which_key_ignore"
        },
        l = {
          name = "[l]SP", _ = "which_key_ignore"
        },
        m = {
          name = "[m]essage", _ = "which_key_ignore"
        },
        t = {
          name = "[t]oggle", _ = "which_key_ignore"
        },
      }
    })
  end,
  --                            ┏━━━━━━━━━━━━━┓
  --                            ┃ Config Ends ┃
  --━━━━━━━━━━━━━━━━━━━━━━━━━━━━┻━━━━━━━━━━━━━┻━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
}
