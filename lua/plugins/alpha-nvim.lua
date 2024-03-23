--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│ File: plugins/alpha-nvim.lua                                             │--
--│ Note: Startup screen plugin                                              │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  --━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
  --                          ┃ Config Function ┃
  --                          ┗━━━━━━━━━━━━━━━━━┛
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    ------------------------- Dashboard settings -------------------------------
    -- Set header
    dashboard.section.header.val = {
      "                                                                       ",
      "                                                                     ",
      "       ████ ██████           █████      ██                     ",
      "      ███████████             █████                             ",
      "      █████████ ███████████████████ ███   ███████████   ",
      "     █████████  ███    █████████████ █████ ██████████████   ",
      "    █████████ ██████████ █████████ █████ █████ ████ █████   ",
      "  ███████████ ███    ███ █████████ █████ █████ ████ █████  ",
      " ██████  █████████████████████ ████ █████ █████ ████ ██████ ",
      "                                                                       ",
    }

    -- -- Set header
    -- dashboard.section.header.val = {
    -- 
    -- ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
    -- ░    ░░░░░   ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
    -- ▒  ▒   ▒▒▒   ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒  ▒▒▒▒▒▒▒▒▒▒▒▒▒▒
    -- ▒   ▒   ▒▒   ▒▒▒▒   ▒▒▒▒▒▒▒▒   ▒▒▒▒▒   ▒▒▒▒▒   ▒▒▒▒▒    ▒   ▒   ▒
    -- ▓   ▓▓   ▓   ▓▓  ▓▓▓   ▓▓▓   ▓▓   ▓▓▓   ▓▓▓   ▓▓   ▓▓   ▓▓  ▓▓  ▓
    -- ▓   ▓▓▓  ▓   ▓         ▓▓   ▓▓▓▓   ▓▓▓   ▓   ▓▓▓   ▓▓   ▓▓  ▓▓  ▓
    -- ▓   ▓▓▓▓  ▓  ▓  ▓▓▓▓▓▓▓▓▓▓   ▓▓   ▓▓▓▓▓     ▓▓▓▓   ▓▓   ▓▓  ▓▓  ▓
    -- █   ██████   ███     ███████   █████████   █████   █    ██  ██  █
    -- █████████████████████████████████████████████████████████████████
    -- }

    -- Set menu
    -- FIX: resolve conflict with which-key
    dashboard.section.buttons.val = {
      dashboard.button("r", "󰈙 " .. " Recent file", "<cmd>Telescope oldfiles<cr>"),
      dashboard.button("n", "󰈔 " .. " New file", "<cmd>ene <bar> startinsert<cr>"),
      dashboard.button("f", "󰈞 " .. " Find file", "<cmd>Telescope find_files<cr>"),
      dashboard.button("t", "󰺮 " .. " Find text", "<cmd>Telescope live_grep<cr>"),
      dashboard.button("e", "󰙅 " .. " Explorer", "<cmd>NvimTreeOpen<cr>"),
      dashboard.button("c", " " .. " Config" , "<cmd>e $MYVIMRC|cd %:p:h|NvimTreeOpen<CR>"),
      dashboard.button("p", "󰦬 " .. " Plugins", "<cmd>Lazy<cr>"),
      dashboard.button("h", "󰗶 " .. " Checkhealth", "<cmd>checkhealth<cr>"),
      dashboard.button("q", " " .. " Quit", "<cmd>qa!<cr>"),
    }

    -- Set color
    dashboard.section.header.opts.hl = "Keyword"               -- header
    for _, button in ipairs(dashboard.section.buttons.val) do  -- buttons
      button.opts.hl = "AlphaButtons"
      button.opts.hl_shortcut = "AlphaShortcut"
    end
    dashboard.section.footer.opts.hl = "AlphaFooter"           -- footer
    dashboard.opts.layout[1].val = 6

    -- Send config to alpha
    alpha.setup(dashboard.opts)

    ------------------------------ Autocmds ------------------------------------
    local autocmd = vim.api.nvim_create_autocmd
    local alphaaugroup = vim.api.nvim_create_augroup("Alpha", { clear = true })

    autocmd("User", {
      desc = "Set footer with loading time",
      group = alphaaugroup,
      pattern = "LazyVimStarted",
      callback = function()
        local stats = require("lazy").stats()
        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)

        -- local now = os.date "%d-%m-%Y %H:%M:%S"
        local version = " eovim -  " .. vim.version().major .. "." .. vim.version().minor .. "." .. vim.version().patch
        -- local fortune = require "alpha.fortune"
        -- local quote = table.concat(fortune(), "\n")
        local plugins = "loaded " .. stats.count .. " plugins in " .. ms .. "ms"
        local footer = version .. "\t" .. plugins -- .. "\n" .. quote
        dashboard.section.footer.val = footer
        pcall(vim.cmd.AlphaRedraw)
      end,
    })

    if vim.o.filetype == "lazy" then
      vim.cmd.close()
      autocmd("User", {
        desc = "Load dashboard after Lazy installing plugins",
        group = alphaaugroup,
        pattern = "AlphaReady",
        callback = function()
          require("lazy").show()
        end,
      })
    end

    autocmd("User", {
      desc = "Disable folding on alpha buffer",
      group = alphaaugroup,
      pattern = "AlphaReady",
      callback = function ()
        vim.opt_local.foldenable = false
      end
    })
  end
  --                            ┏━━━━━━━━━━━━━┓
  --                            ┃ Config Ends ┃
  --━━━━━━━━━━━━━━━━━━━━━━━━━━━━┻━━━━━━━━━━━━━┻━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
}
