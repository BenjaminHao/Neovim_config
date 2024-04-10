--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│ FILE: plugins/toggleterm.lua                                             │--
--│ DESC: Terminal plugin inside Neovim                                      │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
return {
  "akinsho/toggleterm.nvim",
  version = "*",
  cmd = "ToggleTerm",
  keys = {  -- lazy-load on key binds
    { "<leader>T", "<cmd>ToggleTerm direction=float<cr>", desc = "[T]erminal" },
    { "<C-`>", "<cmd>ToggleTerm<CR>", mode = "n", desc = "Toggle terminal" },
  },
  --━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
  --                          ┃ Config Function ┃
  --                          ┗━━━━━━━━━━━━━━━━━┛
  config = function()
    require("toggleterm").setup{
      shell = vim.o.shell,      -- Change the default shell. Can be a string or a function returning a string
      size = 15,
      direction = "horizontal", -- direction = "vertical" | "horizontal" | "tab" | "float",
      open_mapping = "<C-`>",
      terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
      insert_mappings = true,   -- whether or not the open mapping applies in insert mode
      start_in_insert = true,
      hide_numbers = true,      -- hide the number column in toggleterm buffers
      persist_size = true,
      persist_mode = false,     -- if set to true (default) the previous terminal mode will be remembered
      close_on_exit = true,
      auto_scroll = true,       -- automatically scroll to the bottom on terminal output
      shade_terminals = true,
      shading_factor = 2,
      float_opts = {
        border = "none",      -- "single" | "double" | "shadow" | "curved" | ... other options supported by win open
        winblend = 0,
        -- height = math.ceil(vim.o.lines * 1.0 - 4),
        -- width = math.ceil(vim.o.columns * 1.0),
      },
    }
  end
  --                            ┏━━━━━━━━━━━━━┓
  --                            ┃ Config Ends ┃
  --━━━━━━━━━━━━━━━━━━━━━━━━━━━━┻━━━━━━━━━━━━━┻━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
}
