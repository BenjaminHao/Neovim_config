--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│ FILE: core/utils.lua                                                     │--
--│ DESC: util functions                                                     │--
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

utils.del_vim_keymap = function(mode, key)
  vim.keymap.set(mode, key, "<nop>")
end

utils.toggle_vim_opt = function(opt, on, off, name)
  local message = name
  if vim.opt[opt]:get() == off then
    vim.opt[opt] = on
    message = message .. " Enabled"
  else
    vim.opt[opt] = off
    message = message .. " Disabled"
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

utils.invert_term = function()
  local terms = vim.tbl_add_reverse_lookup({
    ["0"] = "1",
    ["true"] = "false",
    ["yes"] = "no",
    ["on"] = "off",
    ["left"] = "right",
    ["up"] = "down",
    ["before"] = "after",
    ["first"] = "last",
    ["enable"] = "disable",
    ["enabled"] = "disabled",
    ["+"] = "-",
    ["=="] = "!=",
    [">"] = "<",
    [">="] = "<=",
  })

  local commands = {
    ["n"] = "norm! ciw",
    ["v"] = "norm! c",
  }

  local inverted = vim.tbl_get(terms, vim.fn.expand("<cword>"))
  xpcall(function()
    vim.cmd(vim.tbl_get(commands, vim.api.nvim_get_mode().mode) .. inverted)
  end, function()
      -- vim.notify("This term cannot be inverted.", vim.log.levels.WARN)
      vim.cmd("norm! ~") -- toggle case as fallback
    end)
end

return utils
