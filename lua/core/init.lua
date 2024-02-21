--=====================================================================
--
-- File: core/init.lua
-- Note: Use Lazy.nvim as package manager
--
--=====================================================================

-----------------------------------------------------------------------
-- Bootstrap lazy.nvim
-----------------------------------------------------------------------
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

-----------------------------------------------------------------------
-- Load core config
-----------------------------------------------------------------------
require("core.options")
require("core.keymaps")
-- require("") --TBA

-----------------------------------------------------------------------
-- Lazy.nvim config
-----------------------------------------------------------------------
local plugin_dir = "plugins"        -- for conciseness and readability
local options = {                   -- for conciseness and readability
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
        border = "rounded",
        icons = {
            source = "󰏗 ",
            ft = "",
            plugin = "󱧕 ",
            event = "󰯹 ",
            task = " ",
            loaded = "",
            not_loaded = "",
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
                "gzip",
                "matchit",
                "matchparen",
                "netrwPlugin",  -- default file explorer
                "rplugin",

                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
                "syntax",
                "vimball",
                "vimballPlugin",
            },
        },
    },
}
-- Setup Lazy.nvim
require("lazy").setup(plugin_dir, options)
