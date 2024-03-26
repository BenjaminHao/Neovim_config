--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│ File: core/utils.lua                                                     │--
--│ Note: util functions                                                     │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
-- TODO: https://dev.to/voyeg3r/my-lazy-neovim-config-3h6o
local function toggle_set_color_column()
  if vim.o.colorcolumn == "" then
    vim.ui.input({ prompt = "Enter a column number: (default 80)"},
      function (input)
        if input == "" then
          vim.o.colorcolumn = "80"
        elseif tonumber(input) then
          vim.o.colorcolumn = input
        else
          vim.notify("Invalid Input, please input a number", vim.log.levels.ERROR)
        end
      end)
  else
    vim.o.colorcolumn = ""
  end
end
