--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│ FILE: core/options.lua                                                   │--
--│ DESC: basic options for Neovim                                           │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
--━━━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
--                            ┃ GENERAL OPTIONS ┃
--                            ┗━━━━━━━━━━━━━━━━━┛
local options = {

  -- GENERAL
  timeoutlen = 500,               -- Time to wait for a mapped sequence to complete (in milliseconds)
  ttimeoutlen = 0,                -- Time to wait for a key code to complete (in milliseconds)
  updatetime = 200,               -- Faster completion (4000ms default)
  swapfile = false,               -- Creates a swapfile
  undofile = true,                -- Enable persistent undo
  writebackup = false,            -- If a file is being edited by another program, it is not allowed to be edited
  mouse = "a",                    -- Allow the mouse to be used in neovim
  mousescroll = "ver:2,hor:4",    -- Change the speed of the scroll wheel
  jumpoptions = "stack",          -- Make Ctrl-o consistent

  -- APPEARANCE
  guifont =
    "JetBrainsMono Nerd Font:h16",-- Font for GUI NVIM (eg. Neovide)
  number = true,                  -- Set numbered lines
  relativenumber = true,          -- Set relative numbered lines
  numberwidth = 2,                -- Set number column width to 2 (default 4)
  cursorline = true,              -- Highlight the current line
  cursorcolumn = false,           -- Highlight the current column (default false)
  colorcolumn = "80",             -- Set a column ruler
  wrap = false,                   -- no line wrap, display lines as one long line
  showbreak = " ",                -- Set indent of wrapped lines
  fileencoding = "utf-8",         -- The encoding written to a file
  background = "dark",            -- Colorschemes that can be light or dark will be made dark
  termguicolors = true,           -- Set term gui colors (most terminals support this)
  conceallevel = 0,               -- So that `` is visible in markdown files
  signcolumn = "yes",             -- Always show the sign column, otherwise it would shift the text each time
  cmdheight = 1,                  -- Space in the neovim command line for displaying messages
  pumheight = 7,                  -- Pop up menu height
  showmode = false,               -- We don't need to see things like -- INSERT -- anymore
  splitbelow = true,              -- Force all horizontal splits to go below current window
  splitright = true,              -- Force all vertical splits to go to the right of current window
  scrolloff = 7,                  -- Minimal number of screen lines to keep above and below the cursor
  sidescrolloff = 7,              -- Minimal number of screen columns either side of cursor if wrap is `false`
  shortmess = "filnxtToOFc",      -- Which errors to suppress
  list = true,                    -- Display certain whitespace in the editor
  listchars =                     -- Symbols for whitespace
    { tab = "»·",                    -- The characters used to show a tab (need 2 characters)
      trail = "·",                   -- Character to show for trailing spaces
      nbsp = "␣" ,                   -- Character to show for non-breaking space
      extends = "→",                 -- Character to show there"s more text to the right (when no line wrap)
      precedes = "←"                 -- Character to show there"s more text to the left
    },

  -- INDENT
  tabstop = 2,                    -- Insert 2 spaces for a tab (for specific language setting, see autocmds.lua
  softtabstop = 2,                -- Insert 2 spaces for a tab
  shiftwidth = 2,                 -- The number of spaces inserted for each indentation
  expandtab = true,               -- Convert tabs to spaces
  autoindent = true,              -- Auto indent
  smartindent = true,             -- Smart indent
  backspace = "indent,eol,start", -- Allow backspace on indent, end of line or insert mode start position

  -- EDIT
  spell = false,                  -- Spellchecker
  spelllang = { "en_us" },        -- Sets spelling dictionary
  clipboard = "unnamedplus",      -- Allows neovim to access the system clipboard
  ignorecase = true,              -- Ignore case in search patterns
  smartcase = true,               -- Smart case
  virtualedit = "block",          -- Vitualblock mode doesn"t get stuck at the end of line
  inccommand = "split",           -- Shows all inline replacements in split
}
--━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━--
--              ┃ TURNS ON ALL VALUES IN OPTIONS TABLE ABOVE ┃
--              ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
for option, value in pairs(options) do
  vim.opt[option] = value
end
