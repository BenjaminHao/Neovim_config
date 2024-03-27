--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│ FILE: plugins/comment.lua                                                │--
--│ NOTE: plugin for commenting                                              │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
return {
  "numToStr/Comment.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  --━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
  --                          ┃ Config Function ┃
  --                          ┗━━━━━━━━━━━━━━━━━┛
  config = function()
    -- import comment plugin safely
    local comment = require("Comment")
    local ts_context_commentstring = require("ts_context_commentstring.integrations.comment_nvim")

    -- enable comment
    comment.setup({
      -- Add a space b/w comment and the line
      padding = true,
      -- Whether the cursor should stay at its position
      sticky = true,
      -- Lines to be ignored while (un)comment
      ignore = nil,
      -- Function to call before (un)comment
      pre_hook = ts_context_commentstring.create_pre_hook(), -- for commenting tsx and jsx files
      mappings = {
        -- Default mappings DISABLED, see keymaps.lua for keybindings
        -- Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
        basic = false,
        -- Extra mapping; `gco`, `gcO`, `gcA`
        extra = false,
      },
    })

    -------------------------- Comment Key Binds -------------------------------
    vim.keymap.set("n", "<C-Bslash>", "<Plug>(comment_toggle_linewise_current)",
      { desc = "Comment current line", noremap = true, silent = true })
    vim.keymap.set("x", "<C-Bslash>", "<Plug>(comment_toggle_blockwise_visual)",
      { desc = "Comment selected lines", noremap = true, silent = true })
  end,
  --                            ┏━━━━━━━━━━━━━┓
  --                            ┃ Config Ends ┃
  --━━━━━━━━━━━━━━━━━━━━━━━━━━━━┻━━━━━━━━━━━━━┻━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
}
