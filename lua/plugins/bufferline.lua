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
        style_preset = bufferline.style_preset.no_italic,
        themable = true,
        color_icons = true,
        separator_style = "slant",
        -- indicator = { style = "underline" },
        --[[ numbers = function(opts)
          return string.format("%s", opts.raise(opts.ordinal))
        end, ]]
        close_command = function(n) bufremove.delete(n, false) end,
        diagnostics = false,           -- OR: | "nvim_lsp" 
        diagnostics_update_in_insert = false,
        always_show_bufferline = true,
        show_buffer_icons = true,
        show_buffer_close_icons = false,
        show_close_icon = false,
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
    map("n", "<leader>bk", "<cmd>BufferLineCloseOthers<cr>", { desc = "[k]ill other buffers" })
  end
  --                            ┏━━━━━━━━━━━━━┓
  --                            ┃ Config Ends ┃
  --━━━━━━━━━━━━━━━━━━━━━━━━━━━━┻━━━━━━━━━━━━━┻━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
}
