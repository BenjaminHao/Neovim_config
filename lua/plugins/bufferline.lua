--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│ FILE: plugins/bufferline.lua                                             │--
--│ DESC: UI Plugin for buffers                                              │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
		"echasnovski/mini.bufremove",
  },
  version = "*",
  --━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
  --                          ┃ Config Function ┃
  --                          ┗━━━━━━━━━━━━━━━━━┛
  config = function()
    local bufferline = require("bufferline")
    local bufremove = require("mini.bufremove")
    local map = require("core.utils").set_vim_keymap

    bufferline.setup({
      options = {
        mode = "buffers",
        themable = true,
        show_buffer_icons = true,
        show_buffer_close_icons = false,
        show_close_icon = false,
        -- always_show_bufferline = true,
        -- separator_style = "slant",
        numbers = function(opts)
          return string.format("%s", opts.raise(opts.ordinal))
        end,
        close_command = function(n) bufremove.delete(n, false) end,
        diagnostics = false,           -- OR: | "nvim_lsp" 
        diagnostics_update_in_insert = false,
        sort_by = "insert_at_end",
        offsets = {
          {
            filetype = "NvimTree",
            text = "NvimTree",
            --[[ text = function()
              return vim.fn.fnamemodify(".", ":p:h:t")
              -- return vim.fn.getcwd()
            end, ]]
            highlight = "Directory",
            -- separator = "", -- use a "true" to enable the default, or set your own character
            -- padding = 1
          }
        },
      }
    })
    ------------------------ bufferline key binds ------------------------------
    map("n", "<leader>bd", function() bufremove.delete(0, false) end , { desc = "[d]elete Current Buffer" })
    map("n", "<leader>bD", function() bufremove.delete(0, true) end, { desc = "[D]elete Buffer (Force)" })
    map("n", "<leader>bk", "<cmd>BufferLinePickClose<cr>", { desc = "[k]ill Picked Buffer" })
    map("n", "<leader>bK", "<cmd>BufferLineCloseOthers<cr>", { desc = "[K]ill Other Buffers" })
    map("n", "<leader>bs", "<cmd>BufferLineSortByDirectory<cr>", { desc = "[s]ort Buffers" })
    map("n", "g1", "<cmd>BufferLineGoToBuffer 1<cr>", { desc = "Goto buffer 1-9" })
    map("n", "g2", "<cmd>BufferLineGoToBuffer 2<cr>", { desc = "which_key_ignore" })
    map("n", "g3", "<cmd>BufferLineGoToBuffer 3<cr>", { desc = "which_key_ignore" })
    map("n", "g4", "<cmd>BufferLineGoToBuffer 4<cr>", { desc = "which_key_ignore" })
    map("n", "g5", "<cmd>BufferLineGoToBuffer 5<cr>", { desc = "which_key_ignore" })
    map("n", "g6", "<cmd>BufferLineGoToBuffer 6<cr>", { desc = "which_key_ignore" })
    map("n", "g7", "<cmd>BufferLineGoToBuffer 7<cr>", { desc = "which_key_ignore" })
    map("n", "g8", "<cmd>BufferLineGoToBuffer 8<cr>", { desc = "which_key_ignore" })
    map("n", "g9", "<cmd>BufferLineGoToBuffer 9<cr>", { desc = "which_key_ignore" })
  end
  --                            ┏━━━━━━━━━━━━━┓
  --                            ┃ Config Ends ┃
  --━━━━━━━━━━━━━━━━━━━━━━━━━━━━┻━━━━━━━━━━━━━┻━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
}
