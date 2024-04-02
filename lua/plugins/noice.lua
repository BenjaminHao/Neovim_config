--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│ FILE: plugins/noice.lua                                                  │--
--│ DESC: Default UI replacement plugin                                      │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify"  -- nice looking notification plugin
  },
  --━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
  --                          ┃ Config Function ┃
  --                          ┗━━━━━━━━━━━━━━━━━┛
  config = function ()
    local noice = require("noice")
    local notify = require("notify")
    local map = require("core.utils").set_vim_keymap

    ----------------------------- Noice Setup ----------------------------------
    noice.setup({
      cmdline = {
        enabled = true, -- enables the Noice cmdline UI
        view = "cmdline_popup", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
        opts = {}, -- global options for the cmdline. See section on views
        format = {
          -- conceal: (default=true) This will hide the text in the cmdline that matches the pattern.
          -- view: (default is cmdline view)
          -- opts: any options passed to the view
          -- icon_hl_group: optional hl_group for the icon
          -- title: set to anything or empty string to hide
          cmdLine = { pattern = "^:", icon = "", lang = "vim" },
          search_down = { title = " Search Downwards ", kind = "search", pattern = "^/", icon = " ", lang = "regex" },
          search_up = { title = " Search Upwards ", kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
          lua = { title = " Lua ", pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = "lua" },
          help = { title = " Help ", pattern = "^:%s*he?l?p?%s+", icon = "" },
          filter = { title = " Shell ", pattern = "^:%s*!", icon = "", lang = "bash" },
          input = {}, -- Used by input()
          -- lua = false, -- to disable a format, set to `false`
        },
      },
      popupmenu = {
        enabled = true, -- enables the Noice popupmenu UI
        -- @type "nui"|"cmp"
        backend = "nui", -- backend to use to show regular cmdline completions
        -- @type NoicePopupmenuItemKind|false
        -- Icons for completion item kinds (see defaults at noice.config.icons.kinds)
        kind_icons = {}, -- set to `false` to disable icons
      },
      redirect = {
        view = "notify",
        filter = { event = "msg_show" },
      },
      lsp = {
          progress = {
            enabled = true,
            -- See config.format.builtin
            -- See the section on formatting for more details on how to customize.
            format = "lsp_progress",
            format_done = "lsp_progress_done",
            throttle = 1000 / 30,
            view = "mini"
          },
          override = {
            -- override the default lsp markdown formatter with Noice
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            -- override the lsp markdown formatter with Noice
            ["vim.lsp.util.stylize_markdown"] = true,
            -- override cmp documentation with Noice (needs the other options to work)
            ["cmp.entry.get_documentation"] = true,
          },
          hover = {
            enabled = true,
            silent = false, -- set to true to not show a message if hover is not available
            view = nil, -- when nil, use defaults from documentation
            opts = {}, -- merged with defaults from documentation
          },
          signature = {
            enabled = true,
            auto_open = {
              enabled = true,
              trigger = true, -- Automatically show signature help when typing a trigger character from the LSP
              luasnip = true, -- Will open signature help when jumping to Luasnip insert nodes
              throttle = 50, -- Debounce lsp signature help request by 50ms
            },
            view = nil, -- when nil, use defaults from documentation
            opts = {}, -- merged with defaults from documentation
          },
          message = {
            -- Messages shown by lsp servers
            enabled = true,
            view = "notify",
            opts = {},
          },
          -- defaults for hover and signature help
          documentation = {
            view = "hover",
            opts = {
              lang = "markdown",
              replace = true,
              render = "plain",
              format = { "{message}" },
              win_options = { concealcursor = "n", conceallevel = 3 },
            },
          },
      },
      routes = {
        -- { -- show @recording message
        --   filter = { event = "msg_showmode" },
        --   view = "notify",
        -- },
        {
          filter = {
            event = "msg_show",
            kind = "",
            any = {
              -- { find = "%d+L, %d+B" }, -- for written messages
              { find = "; after #%d+" }, -- for redo messages
              { find = "; before #%d+" }, -- for undo messages
              { find = "%d+ lines" }, -- for line move/indent messages
            },
          },
          opts = { skip = true }, -- hide messages
        },
      },
      presets = {
        -- you can enable a preset by setting it to true, or a table that will override the preset config
        -- you can also add custom presets that you can enable/disable with enabled=true
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = false, -- position the cmdline and popupmenu together | cmd middle/top
        long_message_to_split = true, -- long messages will be sent to a split
        -- TODO: check inc-rename.nvim
        inc_rename = true, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
      },
    })

    ---------------------------- nvim-notify Setup -----------------------------
    notify.setup({
      level = vim.log.levels.INFO,
      icons = {
        DEBUG = "󱕼 ",
        ERROR = "󰱮 ",
        INFO = "󰱱 ",
        TRACE = "󰱴 ",
        WARN = "󰱶 "
      },
      timeout = 3000, -- default 5000
    })

    -------------------------- Noice Key Binds ---------------------------------
    -- for Noice messages
    map("n", "<leader>fm", "<cmd>Telescope notify<cr>", { desc = "[m]essage" })
    map("n", "<leader>mn", "<cmd>Notifications<cr>", { desc = "[n]otifications" })
    map("n", "<leader>ml", function() noice.cmd("last") end, { desc = "[l]ast Message" })
    map("n", "<leader>me", function() noice.cmd("errors") end, { desc = "[e]rror Messages" })
    map("n", "<leader>mh", function() noice.cmd("history") end, { desc = "[h]istory Messages" })
    map("n", "<leader>md", function() noice.cmd("dismiss") end, { desc = "[d]ismiss Messages" })

    -- for Noice lsp docs
    map({ "i", "n", "s" }, "<c-f>", function()
      if not require("noice.lsp").scroll(4) then return "<c-f>" end
    end, { expr = true, desc = "Scroll forward" })
    map({ "i", "n", "s" }, "<c-b>", function()
      if not require("noice.lsp").scroll(-4) then return "<c-b>" end
    end, { expr = true, desc = "Scroll backward" })

    -- run command without closing cmdline, so you can change it later
    map("c", "<S-cr>", function() noice.redirect(vim.fn.getcmdline()) end, { desc = "Redirect Cmdline" })
  end
  --                            ┏━━━━━━━━━━━━━┓
  --                            ┃ Config Ends ┃
  --━━━━━━━━━━━━━━━━━━━━━━━━━━━━┻━━━━━━━━━━━━━┻━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
}
