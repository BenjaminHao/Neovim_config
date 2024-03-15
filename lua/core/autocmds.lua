--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│ File: core/autocmds.lua                                                  │--
--│ Note: Some better settings                                               │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
local autocmd = vim.api.nvim_create_autocmd
local general = vim.api.nvim_create_augroup("General Settings", { clear = true })

autocmd("FileType", {
  desc = "Set shiftwidth to 4 in specific filetypes",
  group = general,
  pattern = { "c", "cpp", "py", "java", "cs" },
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.expandtab = true
  end,
})

autocmd("BufEnter", {
  desc = "Disable New Line Comment",
  group = general,
  callback = function()
    vim.opt.formatoptions:remove { "c", "r", "o" }
  end,
})

autocmd("VimEnter", {
  desc = "Open Nvim-Tree when it's a Directory",
  group = general,
  callback = function(data)
    -- buffer is a directory
    local directory = vim.fn.isdirectory(data.file) == 1
    -- change to the directory
    if directory then
      vim.cmd.cd(data.file)
      require("nvim-tree.api").tree.open()
      -- vim.cmd "Telescope find_files"
    end
  end,
})

autocmd("FileType", {
  desc = "Close help buffer with <q>",
  group = general,
  pattern = { "lspinfo", "man", "help", "qf", "vim" },
  callback = function()
    local opts = { buffer = true, silent = true}
    vim.keymap.set("n", "q", function()
      vim.cmd.close()
    end, opts)
  end,
})

autocmd("BufReadPost", {
  desc = "Go to last loc when opening a buffer",
  group = general,
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

autocmd("TextYankPost", {
  desc = "Highlight on yank",
  group = general,
  callback = function()
    vim.highlight.on_yank({ higrou = "Visual", timeout = 200 })
  end,
})
