--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│ FILE: core/init.lua                                                      │--
--│ DESC: Use Lazy.nvim as plugin manager                                    │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
--━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━--
--                          ┃ BOOTSTRAP LAZY.NVIM ┃
--                          ┗━━━━━━━━━━━━━━━━━━━━━┛
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
--━━━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
--                            ┃ LOAD CORE CONFIG ┃
--                            ┗━━━━━━━━━━━━━━━━━━┛
require("core.options")
require("core.keymaps")  -- <Leader> key must be set before setting up Lazy
require("core.autocmds")
-- require("core.utils")
--━━━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
--                            ┃ LAZY.NVIM CONFIG ┃
--                            ┗━━━━━━━━━━━━━━━━━━┛
local plugin_dir = "plugins"  -- for conciseness and readability
local options = {             -- for conciseness and readability
  defaults = {
    lazy = true,
  },
  install = {
    colorscheme = { "catppuccin" },
  },
  checker = {
    enabled = true,  -- automatically check for plugin updates
    notify = false,  -- get a notification when updates are found
  },
  change_detection = {
    notify = false,
  },
  ui = {
    border = "none",
    icons = {
      event = " ",
      ft = " ",
      lazy = "󰪓 ",
      loaded = "󰗡",
      not_loaded = "󰄰",
      plugin = "󱧕 ",
      source = "󰏗 ",
      task = " ",
    },
  },
  performance = {
    cache = {
      enabled = true,
    },
    reset_packpath = true,
    rtp = {
      reset = true,
      disabled_plugins = {
        "2html_plugin",
        "bugreport",
        "compiler",
        "ftplugin",
        "getscript",
        "getscriptPlugin",
        "gzip",
        "logipat",
        "matchit",
        "netrw",
        "netrwFileHandlers",
        "netrwPlugin",
        "netrwSettings",
        "optwin",
        "rplugin",
        "rrhelper",
        "spellfile_plugin",
        "synmenu",
        "syntax",
        "tar",
        "tarPlugin",
        "tohtml",
        "tutor",
        "vimball",
        "vimballPlugin",
        "zip",
        "zipPlugin",
      },
    },
  },
}
--━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
--                             ┃ SETUP LAZY.NVIM ┃
--                             ┗━━━━━━━━━━━━━━━━━┛
require("lazy").setup(plugin_dir, options)
-- key bind for Lazy
vim.keymap.set("n", "<leader>P", "<cmd>Lazy<cr>", { desc = "[P]lugin Manager" })
