--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│ FILE: core/keymaps.lua                                                   │--
--│ NOTE: Custom key binds                                                   │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--

local util = require("core.utils")
local map = require("core.utils").set_vim_keymap
local toggle = require("core.utils").toggle_vim_opt
--━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━--
--        ┃                        LEADER KEY                         ┃
--        ┃ PS: Make sure to set before lazy so key binds are correct ┃
--        ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
vim.g.mapleader = " "
vim.g.maplocalleader = " "  -- No use of this now
--━━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
--                           ┃ GENERAL KEY BINDS ┃
--                           ┗━━━━━━━━━━━━━━━━━━━┛
-- Unmapping
map("n", "<C-z>", "<nop>")  -- <Ctrl-z>: suspend Neovim, "fg" in cmd to get back
map("i", "<C-h>", "<nop>")  -- <Ctrl-h> = <delete>, annoying with cmp key bind
map("i", "<C-j>", "<nop>")  -- <Ctrl-j> = <enter>, annoying with cmp key bind
-- Map ctrl-c to esc
map("i", "<C-c>", "<esc>")
-- Move to beginning/end of the line
map({ "n", "x", "o" }, "H", "^") -- 0: beginning of line, ^: first non-blank character
map({ "n", "x", "o" }, "L", "g_") -- $: end of line, g_: last non-blank character
-- Move the line up or down in Visual mode
map("x", "J", [[:m '>+1<cr><cr>gv=gv]], { desc = "Move line down" })
map("x", "K", [[:m '<-2<cr><cr>gv=gv]], { desc = "Move line up" })
-- Move text to next line, corresponding key bind for <J>
map("n", "K", "i<cr><esc>")
-- Insert lines above/below without leaving normal mode
map("n", "<cr>", "o<esc>k")
map("n", "<S-cr>", "O<esc>j")
-- Emacs like key binds in insert mode for better typing experience
map("i", "<C-a>", "<home>")
map("i", "<C-e>", "<end>")
map("i", "<C-f>", "<right>")
map("i", "<C-b>", "<left>")
-- super semicolon
map("i", "<C-;>", "<end>;")
--━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
--                             ┃ QOL KEY BINDS ┃
--                             ┗━━━━━━━━━━━━━━━┛
-- Clear search highlights
map("n", "<esc>","<esc><cmd>noh<cr>", { desc = "Clear search highlights" })
-- Better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")
-- Visual overwrite paste
map("v", "p", '"_dP')
-- Do not copy on x
map({ "n", "v" }, "x", '"_x')
-- Keep window centered when going up/down
map("n", "J", "mzJ`z")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "<C-f>", "<C-f>zz")
map("n", "<C-b>", "<C-b>zz")
map("n", "N", "Nzzzv")
map("n", "n", "nzzzv")
-- TODO: <~> key able to toggle true/false, 1/0, +/-. Maybe need to create .lua
--━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
--                                ┃ BUFFERS ┃
--                                ┗━━━━━━━━━┛
-- For other buffer key binds, see plugins/bufferline.lua
map("n", "<C-n>",  "<cmd>bn<CR>", { desc = "Next Buffer"})
map("n", "<C-p>", "<cmd>bp<CR>", { desc = "Previous Buffer"})
--━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
--                                ┃ WINDOWS ┃
--                                ┗━━━━━━━━━┛
map("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
map("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
map("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
map("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
-- Resize windows with Ctrl+Arrow keys, disable Mission control in MacOS
map("n", "<C-up>", ":resize +2<CR>")
map("n", "<C-down>", ":resize -2<CR>")
map("n", "<C-right>", ":vertical resize +2<CR>")
map("n", "<C-left>", ":vertical resize -2<CR>")
--━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
--                                  ┃ LSP ┃
--                                  ┗━━━━━┛
-- TODO:Move to lsp-config
map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { desc = "[D]eclaration"})
map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { desc = "[d]efinition"})
map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", { desc = "[i]mplementation"})
map("n", "M", "<cmd>lua vim.lsp.buf.hover()<CR>", {desc = "[M]ore Info"})
map("n", "<C-m>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", {desc = "Signature Help"})
map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", { desc = "[r]eferences"})
map("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", { desc = "[r]ename"})
--━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
--                              ┃ DIAGNOSTICS ┃
--                              ┗━━━━━━━━━━━━━┛
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next [d]iagnostic message" })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous [d]iagnostic message" })
map("n", "<leader>de", vim.diagnostic.open_float, { desc = "Show diagnostic [e]rror messages" })
map("n", "<leader>dl", vim.diagnostic.setloclist, { desc = "Open diagnostic quickfix [l]ist" })
--━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
--                                ┃ TOGGLES ┃
--                                ┗━━━━━━━━━┛
-- TODO: toggle function
map("n", "<leader>ts", function() toggle("spell", true, false, "Spell check") end, { desc = "[s]pell Check"})
map("n", "<leader>tn", function() toggle("relativenumber", true, false, "Relative number") end, { desc = "Relative [n]umber"})
map("n", "<leader>tN", function() toggle("number", true, false, "Line number") end, { desc = "Line [N]umber"})
map("n", "<leader>tC", function() util.toggle_set_color_column() end, { desc = "Color [C]olumn" })
--━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
--                                ┃ PLUGINS ┃
--                                ┗━━━━━━━━━┛
--┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓--
--┃ No longer here. Plugin mappings are within plugin settings locally, such ┃--
--┃ that they appear and disappear whether the plugin is installed or not    ┃--
--┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛--
