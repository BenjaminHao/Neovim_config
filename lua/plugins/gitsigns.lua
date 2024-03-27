--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│ FILE: plugins/gitsigns.lua                                               │--
--│ NOTE: git decorations                                                    │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  --━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
  --                          ┃ Config Function ┃
  --                          ┗━━━━━━━━━━━━━━━━━┛
  config = function ()
    require("gitsigns").setup({
      signs = {
        add = { text = "▍" },
        change = { text = "▍" },
        delete = { text = "◢" },
        topdelete = { text = "◥" },
        changedelete = { text = "▍" },
        untracked = { hl = "Title", text = "▍" },
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
        border = "rounded",
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

        local function map(mode, l, r, opts)
          local options = { noremap = true, silent = true }
          if opts then
            options = vim.tbl_extend("force", options, opts)
          end
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map("n", "]h", function()
          if vim.wo.diff then
            return "]h"
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return "<Ignore>"
        end, { expr = true, desc = "Next [h]unk" })

        map("n", "[h", function()
          if vim.wo.diff then
            return "[h"
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return "<Ignore>"
        end, { expr = true, desc = "Previous [h]unk" })

        -- Actions
        map({ "n", "v" }, "<leader>gs", "<cmd>Gitsigns stage_hunk<CR>", { desc = "[s]tage hunk" })
        map({ "n", "v" }, "<leader>gr", "<cmd>Gitsigns reset_hunk<CR>", { desc = "[r]eset hunk" })
        map("n", "<leader>gu", gs.undo_stage_hunk, { desc = "[u]ndo stage hunk" })
        map("n", "<leader>gp", gs.preview_hunk_inline, { desc = "[p]review hunk" })
        map("n", "<leader>gP", gs.preview_hunk, { desc = "[P]review hunk inline" })
        map("n", "<leader>gS", gs.stage_buffer, { desc = "[S]tage buffer" })
        map("n", "<leader>gR", gs.reset_buffer, { desc = "[R]eset buffer" })
        map("n", "<leader>gb", function()
          gs.blame_line({ full = true })
        end, { desc = "[b]lame line" })
        map("n", "<leader>gd", gs.diffthis, { desc = "[d]iff this" })
        map("n", "<leader>gD", function()
          gs.diffthis("~")
        end, { desc = "[D]iff this against parent" })

        map("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "[b]lame line" })
        map("n", "<leader>td", gs.toggle_deleted, { desc = "git [d]eleted" })

        -- Text object
        map({ "o", "x" }, "ih", "<cmd><C-U>Gitsigns select_hunk<CR>", { desc = "Select hunk" })
      end,
    })
  end
  --                            ┏━━━━━━━━━━━━━┓
  --                            ┃ Config Ends ┃
  --━━━━━━━━━━━━━━━━━━━━━━━━━━━━┻━━━━━━━━━━━━━┻━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
}
