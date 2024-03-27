--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│ FILE: core/utils.lua                                                     │--
--│ NOTE: util functions                                                     │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
-- TODO: https://dev.to/voyeg3r/my-lazy-neovim-config-3h6o
local utils = {}

utils.set_vim_keymap = function(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

utils.toggle_vim_opt = function(opt, on, off, name)
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

utils.toggle_set_color_column = function()
  if vim.o.colorcolumn == "" then
    vim.ui.input({ prompt = "Enter a column number: (default 80)"},
      function (input)
        if input == "" then
          vim.o.colorcolumn = "80"
        elseif tonumber(input) then
          vim.o.colorcolumn = input
        else
          vim.notify("Invalid Input, please input a number", vim.log.levels.WARN)
        end
      end)
  else
    vim.o.colorcolumn = ""
  end
end

return utils
