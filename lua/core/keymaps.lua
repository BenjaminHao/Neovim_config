--=====================================================================
--
-- File: core/keymaps.lua
--
--=====================================================================
-- For conciseness
function Map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
end

-----------------------------------------------------------------------
-- Leader Key
-- Note: Make sure to set before lazy so mappings are correct
-----------------------------------------------------------------------
vim.g.mapleader = " " -- Remap space as leader key
-- vim.g.maplocalleader = " " -- No use of this now

-----------------------------------------------------------------------
-- General Keymaps 
-----------------------------------------------------------------------
-- Unmappings
Map("n", "<C-z>", "<nop>")    -- Ctrl+z will suspend vim

-- Personal Keymaps
Map("x", "J", [[:m '>+1<CR><CR>gv=gv]], { desc = "Move line down" })
Map("x", "K", [[:m '<-2<CR><CR>gv=gv]], { desc = "Move line up" })

Map("n", "<S-CR>", "i<CR><ESC>")

Map("n", "<Esc>",":noh<CR>", { desc = "Clear search highlights" })

-- Better indenting
Map("v", "<", "<gv")
Map("v", ">", ">gv")

-- Buffers
Map("n", "<TAB>", ":bn<CR>")
Map("n", "<S-TAB>", ":bp<CR>")

-- LSP
Map("n", "<leader>gd", ":lua vim.lsp.buf.definition()<CR>")
Map("n", "<leader>gi", ":lua vim.lsp.buf.implementation()<CR>")
Map("n", "K", ":lua vim.lsp.buf.hover()<CR>")
Map("n", "<leader>rn", ":lua vim.lsp.buf.rename()<CR>")
Map("n", "<leader>gr", ":lua vim.lsp.buf.references()<CR>")

-- Keep window centered when going up/down
Map("n", "J", "mzJ`z")
Map("n", "<C-d>", "<C-d>zz")
Map("n", "<C-u>", "<C-u>zz")
Map("n", "n", "nzzzv")
Map("n", "N", "Nzzzv")

-- Temporary keymaps for plugins
Map("n", "<leader>e", "<cmd>NvimTreeToggle<cr>")
Map("n", "<leader>m", "<cmd>NvimTreeFocus<cr>")
Map("n", "<leader>ff", "<cmd> Telescope find_files <CR>")
Map("n", "<leader>fa", "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>")
Map("n", "<leader>fe", "<cmd> Telescope file_browser <CR>")
Map("n", "<leader>fw", "<cmd> Telescope live_grep <CR>")
Map("n", "<leader>fb", "<cmd> Telescope buffers <CR>")
Map("n", "<leader>fh", "<cmd> Telescope help_tags <CR>")
Map("n", "<leader>fo", "<cmd> Telescope oldfiles <CR>")
