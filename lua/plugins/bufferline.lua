--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│ File: plugins/bufferline.lua                                             │--
--│ Note: UI Plugin for buffers                                              │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  version = "*",
  --━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
  --                          ┃ Config Function ┃
  --                          ┗━━━━━━━━━━━━━━━━━┛
  config = function()
    local bufferline = require("bufferline")

    bufferline.setup({
      options = {
        mode = "buffers",
        -- separator_style = "slant",
        style_preset = bufferline.style_preset.no_italic,
        --[[ numbers = function(opts)
          return string.format('%s', opts.raise(opts.ordinal))
        end, ]]
        diagnostics = false,           -- OR: | "nvim_lsp" 
        diagnostics_update_in_insert = false,
        show_buffer_close_icons = false,
        always_show_bufferline = false,
        show_close_icon = true,
        sort_by = "insert_at_end",
        offsets = {
          {
            filetype = "NvimTree",
            text = "NvimTree",
            --[[ text = function()
              return vim.fn.fnamemodify('.', ':p:h:t')
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
    vim.keymap.set("n", "<leader>bD", "<cmd>BufferLineCloseOthers<cr>",
      { desc = "[D]elete other buffers", noremap = true, silent = true })
  end
  --                            ┏━━━━━━━━━━━━━┓
  --                            ┃ Config Ends ┃
  --━━━━━━━━━━━━━━━━━━━━━━━━━━━━┻━━━━━━━━━━━━━┻━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
}
