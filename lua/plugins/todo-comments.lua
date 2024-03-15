--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│ File: plugins/todo-comments.lua                                          │--
--│ Note: Highlight and search for todo comments                             │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
return {
  "folke/todo-comments.nvim",
  event = { "BufReadPost", "BufNewFile" },
  cmd = { "TodoTrouble", "TodoTelescope" },
  keys = {  -- lazy-load on key binds
    { "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "[t]odo" }
  },
  --━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━--
  --                       ┃ Todo-comments Config ┃
  --                       ┗━━━━━━━━━━━━━━━━━━━━━━┛
  config = function()
    require("todo-comments").setup({
      signs = false, -- show icons in the signs column
      sign_priority = 8, -- sign priority
      keywords = {
        FIX = {
          icon = " ",
          color = "error",
          alt = { "Fix", "fix", "FIXME", "Fixme", "fixme", "BUG", "Bug", "bug" },
        },
        TODO = { icon = "󰝖 ", color = "info", alt = { "Todo", "todo" } },
        HACK = { icon = " ", color = "warning", alt = { "Hack", "hack" } },
        WARN = { icon = " ", color = "warning", alt = { "Warn", "warn", "Warning", "WARNING"} },
        PERF = { icon = "󰁫 ", alt = { "Perf", "perf" } },
        TEST = { icon = " ", color = "test", alt = { "Test", "test" } },
        FILE = { icon = " ", alt = { "File", "file" } },
        NOTE = { icon = " ", color = "hint", alt = { "Note", "note", "INFO", "Info", "info" } },
      },
      gui_style = {
        fg = "NONE", -- The gui style to use for the fg highlight group.
        bg = "BOLD", -- The gui style to use for the bg highlight group.
      },
      merge_keywords = true, -- when true, custom keywords will be merged with the defaults
      highlight = {
        multiline = false, -- enable multiline todo comments
        multiline_pattern = "^.", -- lua pattern to match the next multiline from the start of the matched keyword
        multiline_context = 10, -- extra lines that will be re-evaluated when changing a line
        before = "", -- "fg" or "bg" or empty
        keyword = "wide", -- "fg", "bg", "wide" or empty. (wide is the same as bg, but will also highlight surrounding characters)
        after = "fg", -- "fg" or "bg" or empty
        pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlightng (vim regex)
        -- pattern = [[.*<(\iKEYWORDS)\s*\(:\|-\)]], -- pattern or table of patterns, used for highlightng (vim regex)
        comments_only = true, -- uses treesitter to match keywords in comments only
        max_line_len = 400, -- ignore lines longer than this
        exclude = { "txt", "man", "markdown" }, -- list of file types to exclude highlighting
      },
      search = {
        command = "rg",
        args = {
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--ignore-case",
        },
        pattern = [[\b(KEYWORDS):]],
      },
    })
  end
  --━━━━━━━━━━━━━━━━━━━━━━━━━━ Config Ends Here ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
}
