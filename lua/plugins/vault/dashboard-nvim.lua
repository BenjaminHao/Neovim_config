--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│ FILE: plugins/dashboard-nvim.lua                                         │--
--│ DESC: Startup screen plugin                                              │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
return {
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  opts = function()
    local logo = [[
                                                                    
      ████ ██████           █████      ██                     
     ███████████             █████                             
     █████████ ███████████████████ ███   ███████████   
    █████████  ███    █████████████ █████ ██████████████   
   █████████ ██████████ █████████ █████ █████ ████ █████   
 ███████████ ███    ███ █████████ █████ █████ ████ █████  
██████  █████████████████████ ████ █████ █████ ████ ██████ 
      ]]

    logo = string.rep("\n", 6) .. logo .. "\n\n"

    local opts = {
      theme = "doom",
      hide = {
        -- this is taken care of by lualine
        -- enabling this messes up the actual laststatus setting after loading a file
        statusline = false,
      },
      config = {
        header = vim.split(logo, "\n"),
        center = {
          { action = "Telescope oldfiles", desc = " Recent Files", icon = "󰈙 ", key = "r" },
          { action = "ene | startinsert", desc = " New File", icon = "󰈔 ", key = "n" },
          { action = "Telescope find_files", desc = " Find File", icon = "󰈞 ", key = "f" },
          { action = "Telescope live_grep", desc = " Find Text", icon = "󰺮 ", key = "t" },
          { action = 'NvimTreeOpen', desc = " Explorer", icon = "󰙅 ", key = "e" },
          { action = "e $MYVIMRC|cd %:p:h|NvimTreeOpen", desc = " Config", icon = " ", key = "c" },
          { action = "Lazy", desc = " Plugins", icon = "󰦬 ", key = "p" },
          { action = "Lazy load all | checkhealth", desc = " Check Health", icon = "󰗶 ", key = "h" },
          { action = "qa", desc = " Quit", icon = " ", key = "q" },
        },
        footer = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          local version = " eovim -  " .. vim.version().major .. "." .. vim.version().minor .. "." .. vim.version().patch
          local plugins = "lazy-loaded " .. stats.count .. " plugins in " .. ms .. "ms"
          return { version .. "\t" .. plugins }
        end,
      },
    }

    for _, button in ipairs(opts.config.center) do
      button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
      button.key_format = "  %s"
    end

    -- close Lazy and re-open when the dashboard is ready
    if vim.o.filetype == "lazy" then
      vim.cmd.close()
      vim.api.nvim_create_autocmd("User", {
        desc = "Load dashboard after Lazy installing plugins",
        group = vim.api.nvim_create_augroup("dashboard", { clear = true }),
        pattern = "DashboardLoaded",
        callback = function()
          require("lazy").show()
        end,
      })
    end

    return opts
  end,
}
