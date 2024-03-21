return {
  "akinsho/toggleterm.nvim",
  version = "*",
  cmd = "ToggleTerm",
  keys = {  -- lazy-load on key binds
    { "<leader>T", "<cmd>ToggleTerm direction=float<cr>", desc = "[T]erminal" },
    { "<c-`>", "<cmd>ToggleTerm<CR>", mode = "n", desc = "Toggle terminal" },
  },
  --━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
  --                          ┃ Config Function ┃
  --                          ┗━━━━━━━━━━━━━━━━━┛
  config = function()
    require("toggleterm").setup{
      shell = vim.o.shell,      -- Change the default shell. Can be a string or a function returning a string
      size = 10,
      direction = "horizontal", -- direction = 'vertical' | 'horizontal' | 'tab' | 'float',
      open_mapping = "<C-`>",
      terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
      insert_mappings = true,   -- whether or not the open mapping applies in insert mode
      start_in_insert = true,
      hide_numbers = true,      -- hide the number column in toggleterm buffers
      persist_size = true,
      persist_mode = false,     -- if set to true (default) the previous terminal mode will be remembered
      close_on_exit = true,
      auto_scroll = true,       -- automatically scroll to the bottom on terminal output
      shade_terminals = true,
      shading_factor = 2,
      highlights = {
        NormalFloat = {
          link = "Normal",
        },
        FloatBorder = {
          link = "FloatBorder",
        },
      },
      float_opts = {
        border = "rounded",      -- 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
        winblend = 0,
        --[[ height = math.ceil(vim.o.lines * 1.0 - 4),
        width = math.ceil(vim.o.columns * 1.0), ]]
      },
      -- on_create = fun(t: Terminal), -- function to run when the terminal is first created
      -- on_open = fun(t: Terminal), -- function to run when the terminal opens
      -- on_close = fun(t: Terminal), -- function to run when the terminal closes
      -- on_stdout = fun(t: Terminal, job: number, data: string[], name: string) -- callback for processing output on stdout
      -- on_stderr = fun(t: Terminal, job: number, data: string[], name: string) -- callback for processing output on stderr
      -- on_exit = fun(t: Terminal, job: number, exit_code: number, name: string) -- function to run when terminal process exits
      -- shade_filetypes = {},
      -- autochdir = false, -- when neovim changes it current directory the terminal will change it's own when next it's opened
      -- highlights = {
      --   -- highlights which map to a highlight group name and a table of it's values
      --   -- NOTE - this is only a subset of values, any group placed here will be set for the terminal window split
      --   Normal = {
      --     guibg = "<VALUE-HERE>",
      --   },
      --   NormalFloat = {
      --     link = 'Normal'
      --   },
      --   FloatBorder = {
      --     guifg = "<VALUE-HERE>",
      --     guibg = "<VALUE-HERE>",
      --   },
      -- },
      -- This field is only relevant if direction is set to 'float'
      -- winbar = {
      --   enabled = false,
      --   name_formatter = function(term) --  term: Terminal
      --     return term.name
      --   end
      -- },
    }
  end
  --                            ┏━━━━━━━━━━━━━┓
  --                            ┃ Config Ends ┃
  --━━━━━━━━━━━━━━━━━━━━━━━━━━━━┻━━━━━━━━━━━━━┻━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
}
