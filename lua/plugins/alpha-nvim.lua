--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│ File: plugins/alpha-nvim.lua                                             │--
--│ Note: Startup screen plugin, works perfectly with lazy load plugins      │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

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

    -- Set color
    dashboard.section.header.opts.hl = "Title" -- lookup other hl groups with :highlight

    -- Set menu
    -- TODO: conflict with which-key
    dashboard.section.buttons.val = {
      dashboard.button("n", " " .. " New file", "<cmd>ene <BAR> startinsert<CR>"),
      dashboard.button("r", "󰈚 " .. " Recent file", "<cmd>Telescope oldfiles<cr>"),
      dashboard.button("f", " " .. " Find file", "<cmd>Telescope find_files<cr>"),
      dashboard.button("t", " " .. " Find text", "<cmd>Telescope live_grep<cr>"),
      dashboard.button("e", "󰱼 " .. " Explorer", "<cmd>NvimTreeToggle<cr>"),
      dashboard.button("c", " " .. " Config", "<cmd>e $MYVIMRC<cr>"),
      dashboard.button("p", " " .. " Plugins", "<cmd>Lazy<cr>"),
      dashboard.button("h", " " .. " Checkhealth", "<cmd>checkhealth<cr>"),
      dashboard.button("q", " " .. " Quit", "<cmd>qa!<cr>"),
    }

    -- Send config to alpha
    alpha.setup(dashboard.opts)

    -- Set footer
    -- dashboard.section.footer.val = fortune
    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyVimStarted",
      callback = function()
        local stats = require("lazy").stats()
        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)

        -- local now = os.date "%d-%m-%Y %H:%M:%S"
        local version = "   v" .. vim.version().major .. "." .. vim.version().minor .. "." .. vim.version().patch
        -- local fortune = require "alpha.fortune"
        -- local quote = table.concat(fortune(), "\n")
        local plugins = "⚡Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
        local footer = version .. "\t" .. plugins -- .. "\n" .. quote
        dashboard.section.footer.val = footer
        pcall(vim.cmd.AlphaRedraw)
      end,
    })

    -- Disable folding on alpha buffer
    vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
  end,
}
