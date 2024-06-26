--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│ FILE: core/keymaps.lua                                                   │--
--│ DESC: Custom key binds                                                   │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--

local util = require("core.utils")
local map = require("core.utils").set_vim_keymap
local unmap = require("core.utils").del_vim_keymap
local toggle = require("core.utils").toggle_vim_opt
--━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━--
--        ┃                        LEADER KEY                         ┃
--        ┃ PS: Make sure to set before lazy so key binds are correct ┃
--        ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
vim.g.mapleader = " "
vim.g.maplocalleader = " "  -- No use of this now
--━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
--                               ┃ Unmappings ┃
--                               ┗━━━━━━━━━━━━┛
unmap("n", "<C-z>") -- <Ctrl-z>: suspend Neovim, "fg" in cmd to get back
unmap("n", "Q") -- What is this anyway
unmap("n", "<C-o>") -- use which-key ' key to jump
unmap("n", "<C-i>") -- <Ctrl-i> = <tab>, key bind conflict
unmap("i", "<C-h>") -- <Ctrl-h> = <delete>, key bind conflict
unmap("i", "<C-j>") -- <Ctrl-j> = <enter>, key bind conflict
--━━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
--                           ┃ GENERAL KEY BINDS ┃
--                           ┗━━━━━━━━━━━━━━━━━━━┛
-- Map ctrl-c to esc
map("i", "<C-c>", "<esc>")
-- Move to beginning/end of the line
map({ "n", "x", "o" }, "H", "^") -- 0: beginning of line, ^: first non-blank character
map({ "n", "x", "o" }, "L", "g_") -- $: end of line, g_: last non-blank character
-- Move the line up or down in Visual mode
map("x", "J", [[:m '>+1<cr><cr>gv=gv]], { desc = "Move line down" })
map("x", "K", [[:m '<-2<cr><cr>gv=gv]], { desc = "Move line up" })
-- Emacs like key binds in insert mode for better typing experience
map("i", "<C-a>", "<home>")
map("i", "<C-e>", "<end>")
map("i", "<C-f>", "<right>")
map("i", "<C-b>", "<left>")
-- Super colon/semicolon
map("i", "<C-,>", "<end>,")
map("i", "<C-;>", "<end>;")
-- input in next line
map("i", "<C-cr>", "<end><cr>")
-- Super tilde
map({ "n", "x" }, "~", function() util.invert_term() end)
-- Clear search highlights
map("n", "<esc>","<cmd>noh<cr><esc>")
-- Better indenting
map("x", "<", "<gv")
map("x", ">", ">gv")
-- Smart indenting when insert in an empty line
map("n", "i", function() return util.is_empty_line() and "S" or "i" end, { expr = true })
-- Do not copy empty line when dd
map("n", "dd", function() return util.is_empty_line() and '"_dd' or "dd" end, { expr = true })
-- Do not copy on x. In Visual mode, d for cut, x for delete
map({ "n", "x" }, "x", '"_x')
-- Visual overwrite paste
map("x", "p", '"_dP')
-- Keep window centered when going up/down
map("n", "J", "mzJ`z")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "<C-f>", "<C-f>zz")
map("n", "<C-b>", "<C-b>zz")
map("n", "N", "Nzzzv")
map("n", "n", "nzzzv")
-- Shortcut for quit and write
map("n", "<leader>Q", "<cmd>qa!<cr>", { desc = "[Q]uit"})
map("n", "<leader>w", "<cmd>w!<cr>", { desc = "[w]rite File"})
map("n", "<leader>W", "<cmd>wa!<cr>", { desc = "[W]rite All"})
--━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
--                                ┃ BUFFERS ┃
--                                ┗━━━━━━━━━┛
-- For other buffer key binds, see plugins/bufferline.lua
-- TODO: Try alt key for buffers and windows
map("n", "<leader>bn",  "<cmd>bn<CR>", { desc = "[n]ext Buffer"})
map("n", "<leader>bp", "<cmd>bp<CR>", { desc = "[p]revious Buffer"})
--━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
--                                ┃ WINDOWS ┃
--                                ┗━━━━━━━━━┛
map("n", "<C-h>", "<C-w>h", { desc = "Move focus to the left window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move focus to the right window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move focus to the lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move focus to the upper window" })
map("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
map("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
map("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the bottom" })
map("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the top" })
-- Resize windows with Ctrl+Arrow keys (disable Mission control in MacOS first)
map("n", "<C-up>", ":resize +2<CR>")
map("n", "<C-down>", ":resize -2<CR>")
map("n", "<C-right>", ":vertical resize +2<CR>")
map("n", "<C-left>", ":vertical resize -2<CR>")
--━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
--                              ┃ DIAGNOSTICS ┃
--                              ┗━━━━━━━━━━━━━┛
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next [d]iagnostic message" })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous [d]iagnostic message" })
map("n", "<leader>de", vim.diagnostic.open_float, { desc = "Show diagnostic [e]rror messages" })
map("n", "<leader>dl", vim.diagnostic.setloclist, { desc = "Open diagnostic quickfix [l]ist" })
--━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
--                                ┃ TOGGLES ┃
--                                ┗━━━━━━━━━┛
map("n", "<leader>tl", function() toggle("relativenumber", true, false, "Relative Line Number") end, { desc = "[l]ine Relative Number"})
map("n", "<leader>tL", function() toggle("number", true, false, "Line Number") end, { desc = "[L]ine Number"})
map("n", "<leader>tr", function() util.toggle_set_color_column() end, { desc = "[r]uler Column" })
map("n", "<leader>ts", function() toggle("spell", true, false, "Spell Check") end, { desc = "[s]pell Check"})
--━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
--                                ┃ PLUGINS ┃
--                                ┗━━━━━━━━━┛
--┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓--
--┃ No longer here. Plugin mappings are within plugin settings locally, such ┃--
--┃ that they appear and disappear whether the plugin is installed or not    ┃--
--┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛--
