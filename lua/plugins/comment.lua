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
    local comment = require("Comment")
    local ts_context_commentstring = require("ts_context_commentstring.integrations.comment_nvim")
    local map = require("core.utils").set_vim_keymap

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
    map("n", "<C-/>", "<Plug>(comment_toggle_linewise_current)",
      { desc = "Comment current line" })
    map("n", "<C-?>", "<Plug>(comment_toggle_blockwise_current)",
      { desc = "Comment current line (multi-line style)" })
    map("x", "<C-/>", "<Plug>(comment_toggle_linewise_visual)",
      { desc = "Comment selected lines" })
    map("x", "<C-?>", "<Plug>(comment_toggle_blockwise_visual)",
      { desc = "Comment selected lines (multi-line style)" })
  end,
  --                            ┏━━━━━━━━━━━━━┓
  --                            ┃ Config Ends ┃
  --━━━━━━━━━━━━━━━━━━━━━━━━━━━━┻━━━━━━━━━━━━━┻━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
}
