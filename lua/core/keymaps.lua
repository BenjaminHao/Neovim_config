--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│ File: core/keymaps.lua                                                   │--
--│ Note: Custom key binds                                                   │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
--━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━--
--        ┃                        LEADER KEY                         ┃
--        ┃ PS: Make sure to set before lazy so key binds are correct ┃
--        ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
vim.g.mapleader = " "
vim.g.maplocalleader = " "  -- No use of this now
--━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━--
--                     ┃ MAP FUNCTION (for conciseness) ┃
--                     ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
local function Map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end
--━━━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
--                            ┃ TOGGLE FUNCTION ┃
--                            ┗━━━━━━━━━━━━━━━━━┛
local function Toggle(opt, on, off, name)
  local message = name
  if vim.opt[opt]:get() == off then
    vim.opt[opt] = on
    message = message .. ' Enabled'
  else
    vim.opt[opt] = off
    message = message .. ' Disabled'
  end
  vim.notify(message)
end
--━━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
--                           ┃ GENERAL KEY BINDS ┃
--                           ┗━━━━━━━━━━━━━━━━━━━┛
-- Unmapping
Map("n", "<C-z>", "<nop>")  -- <Ctrl-z>: suspend Neovim, "fg" in cmd to get back
Map("i", "<C-h>", "<nop>")  -- <Ctrl-h> = <delete>, conflict with cmp key bind
Map("i", "<C-j>", "<nop>")  -- <Ctrl-j> = <enter>, conflict with cmp key bind
-- Shortcut for <ESC>
Map("i", "jk", "<ESC>")
-- Move to beginning/end of the line
Map({ "n", "v", "x" }, "gl", "$", { desc = "End of line" })
Map({ "n", "v", "x" }, "gh", "^", { desc = "Beginning of line" })
-- Move the line up or down in Visual mode
Map("x", "<S-j>", [[:m '>+1<CR><CR>gv=gv]], { desc = "Move line down" })
Map("x", "<S-k>", [[:m '<-2<CR><CR>gv=gv]], { desc = "Move line up" })
-- Move text to next line
Map("n", "<S-k>", "i<CR><ESC>")
--━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
--                             ┃ QOL KEY BINDS ┃
--                             ┗━━━━━━━━━━━━━━━┛
-- Clear search highlights
Map("n", "<ESC>","<ESC><cmd>noh<CR>", { desc = "Clear search highlights" })
-- Better indenting
Map("v", "<", "<gv")
Map("v", ">", ">gv")
-- Visual overwrite paste
Map({ "v", "x" }, "p", '"_dP')
-- Do not copy on x
Map({ "v", "x" }, "x", '"_x')
-- Keep window centered when going up/down
Map("n", "J", "mzJ`z")
Map("n", "<C-d>", "<C-d>zz")
Map("n", "<C-u>", "<C-u>zz")
Map("n", "<C-f>", "<C-f>zz")
Map("n", "<C-b>", "<C-b>zz")
Map("n", "N", "Nzzzv")
Map("n", "n", "nzzzv")
-- Add undo breakpoints
Map("i", ",", ",<c-g>u")
Map("i", ".", ".<c-g>u")
Map("i", ";", ";<c-g>u")
-- TODO: <~> key able to toggle true/false, 1/0, +/-. Maybe need to create utils.lua
--━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
--                                ┃ BUFFERS ┃
--                                ┗━━━━━━━━━┛
-- For other buffer key binds, see plugins/bufferline.lua
Map("n", "<leader>bn",  "<cmd>bn<CR>", { desc = "[n]ext buffer"})
Map("n", "<leader>bp", "<cmd>bp<CR>", { desc = "[p]revious buffer"})
Map("n", "<leader>bd", "<cmd>bd<CR>", { desc = "[d]elete current buffer"})
--━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
--                                ┃ WINDOWS ┃
--                                ┗━━━━━━━━━┛
Map("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
Map("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
Map("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
Map("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
--━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
--                                  ┃ LSP ┃
--                                  ┗━━━━━┛
Map("n", "<leader>ld", "<cmd>lua vim.lsp.buf.definition()<CR>", { desc = "[d]efinition"})
Map("n", "<leader>li", "<cmd>lua vim.lsp.buf.implementation()<CR>", { desc = "[i]mplementation"})
Map("n", "<leader>lI", "<cmd>lua vim.lsp.buf.hover()<CR>", {desc = "[I]nformation"})
Map("n", "<leader>lr", "<cmd>lua vim.lsp.buf.references()<CR>", { desc = "[r]eferences"})
Map("n", "<leader>lR", "<cmd>lua vim.lsp.buf.rename()<CR>", { desc = "[R]ename"})
--━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
--                              ┃ DIAGNOSTICS ┃
--                              ┗━━━━━━━━━━━━━┛
Map("n", "]d", vim.diagnostic.goto_next, { desc = "Next [d]iagnostic message" })
Map("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous [d]iagnostic message" })
Map("n", "<leader>de", vim.diagnostic.open_float, { desc = "Show diagnostic [e]rror messages" })
Map("n", "<leader>dl", vim.diagnostic.setloclist, { desc = "Open diagnostic quickfix [l]ist" })
--━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
--                                ┃ TOGGLES ┃
--                                ┗━━━━━━━━━┛
-- TODO: toggle function
Map("n", "<leader>ts", function() Toggle("spell", true, false, "Spell check") end, { desc = "[s]pell Check"})
Map("n", "<leader>tn", function() Toggle("relativenumber", true, false, "Relative number") end, { desc = "Relative [n]umber"})
Map("n", "<leader>tN", function() Toggle("number", true, false, "Line number") end, { desc = "Line [N]umber"})
Map("n", "<leader>tC", ":lua require('core.utils').toggle_set_color_column()<cr>", { desc = "Color [C]olumn" })
--━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
--                                ┃ PLUGINS ┃
--                                ┗━━━━━━━━━┛
--┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓--
--┃ No longer here. Plugin mappings are within plugin settings locally, such ┃--
--┃ that they appear and disappear whether the plugin is installed or not    ┃--
--┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛--
