--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│ FILE: plugins/gitsigns.lua                                               │--
--│ DESC: git decorations                                                    │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPost", "BufNewFile" },
  --━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
  --                          ┃ Config Function ┃
  --                          ┗━━━━━━━━━━━━━━━━━┛
  config = function ()
    require("gitsigns").setup({
      signs = {
        add = { text = "┃", hl = "DiffAdded" },
        change = { text = "┃", hl = "DiffModified" },
        delete = { text = "┃", hl = "DiffDelete" },
        topdelete = { text = "╏", hl = "DiffDelete" },
        changedelete = { text = "╏", hl = "DiffModified" },
        untracked = { text = "┃", hl = "DiffAdd" },
      },
      signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
      numhl = false,     -- Toggle with `:Gitsigns toggle_numhl`
      linehl = false,    -- Toggle with `:Gitsigns toggle_linehl`
      word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
      watch_gitdir = {
        interval = 1000,
        follow_files = true,
      },
      auto_attach = true,
      attach_to_untracked = true,
      current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- "eol" | "overlay" | "right_align"
        delay = 1000,
        ignore_whitespace = false,
        virt_text_priority = 100,
      },
      current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
      current_line_blame_formatter_opts = {
        relative_time = false,
      },
      sign_priority = 6,
      update_debounce = 200,
      status_formatter = nil, -- Use default
      max_file_length = 40000,
      preview_config = {
        -- Options passed to nvim_open_win
        border = "none",
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
      },
      yadm = {
        enable = false,
      },
      -------------------------- Gitsigns Key binds ----------------------------
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local map = require("core.utils").set_vim_keymap
        local function opts(desc)
          local options = { desc = desc, buffer = bufnr }
          return options
        end

        -- Navigation
        map("n", "]h", function()
          if vim.wo.diff then return "]h" end
          vim.schedule(function() gs.next_hunk() end)
          return "<Ignore>"
        end, { desc = "Next [h]unk", buffer = bufnr, expr = true })

        map("n", "[h", function()
          if vim.wo.diff then return "[h" end
          vim.schedule(function() gs.prev_hunk() end)
          return "<Ignore>"
        end, { desc = "Previous [h]unk", buffer = bufnr, expr = true })

        -- Actions
        map({ "n", "v" }, "<leader>gs", "<cmd>Gitsigns stage_hunk<CR>", opts("[s]tage hunk"))
        map({ "n", "v" }, "<leader>gr", "<cmd>Gitsigns reset_hunk<CR>", opts("[r]eset hunk"))
        map("n", "<leader>gu", gs.undo_stage_hunk, opts("[u]ndo stage hunk"))
        map("n", "<leader>gp", gs.preview_hunk_inline, opts("[p]review hunk"))
        map("n", "<leader>gP", gs.preview_hunk, opts("[P]review hunk inline"))
        map("n", "<leader>gS", gs.stage_buffer, opts("[S]tage buffer"))
        map("n", "<leader>gR", gs.reset_buffer, opts("[R]eset buffer"))
        map("n", "<leader>gb", function() gs.blame_line({ full = true }) end, opts("[b]lame line"))
        map("n", "<leader>gd", gs.diffthis, opts("[d]iff this"))
        map("n", "<leader>gD", function() gs.diffthis("~") end, opts("[D]iff this against parent"))

        map("n", "<leader>tb", gs.toggle_current_line_blame, opts("[b]lame line"))
        map("n", "<leader>td", gs.toggle_deleted, opts("git [d]eleted"))
      end,
    })
  end
  --                            ┏━━━━━━━━━━━━━┓
  --                            ┃ Config Ends ┃
  --━━━━━━━━━━━━━━━━━━━━━━━━━━━━┻━━━━━━━━━━━━━┻━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
}
