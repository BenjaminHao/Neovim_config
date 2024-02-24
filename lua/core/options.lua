--=====================================================================
--
-- File: core/options.lua
-- Note: Vim default options tweaks
--
--=====================================================================
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
    number = true,                  -- Set numbered lines
    relativenumber = true,          -- Set relative numbered lines
    numberwidth = 2,                -- Set number column width to 2 (default 4)
    cursorline = true,              -- Highlight the current line
    cursorcolumn = false,           -- Highlight the current column (default false)
    colorcolumn = "120",            -- Set a column ruler
    wrap = false,                   -- no line wrap, display lines as one long line
    showbreak = " ",                -- Set indent of wrapped lines
    fileencoding = "utf-8",         -- The encoding written to a file
    guifont = "monospace:h17",      -- The font used in graphical neovim applications
    background = "dark",            -- Colorschemes that can be light or dark will be made dark
    termguicolors = true,           -- Set term gui colors (most terminals support this)
    conceallevel = 0,               -- So that `` is visible in markdown files
    signcolumn = "yes",             -- Always show the sign column, otherwise it would shift the text each time
    cmdheight = 1,                  -- Space in the neovim command line for displaying messages
    pumheight = 7,                  -- Pop up menu height
    showmode = false,               -- We don't need to see things like -- INSERT -- anymore
    splitbelow = true,              -- Force all horizontal splits to go below current window
    splitright = true,              -- Force all vertical splits to go to the right of current window
    scrolloff = 4,                  -- Minimal number of screen lines to keep above and below the cursor
    sidescrolloff = 4,              -- Minimal number of screen columns either side of cursor if wrap is `false`
    shortmess = "filnxtToOFc",      -- Which errors to suppress

    -- INDENT
    tabstop = 4,                    -- Insert 4 spaces for a tab
    shiftwidth = 4,                 -- The number of spaces inserted for each indentation
    softtabstop = 4,                -- Insert 4 spaces for a tab
    expandtab = true,               -- Convert tabs to spaces
    autoindent = true,              -- Auto indent
    smartindent = true,             -- Smart indent
    backspace = "indent,eol,start", -- Allow backspace on indent, end of line or insert mode start position

    -- EDIT
    spell = true,                   -- Turns on spellchecker
    spelllang = { 'en_us' },        -- Sets spelling dictionary
    clipboard = "unnamedplus",      -- Allows neovim to access the system clipboard
    ignorecase = true,              -- Ignore case in search patterns
    smartcase = true,               -- Smart case
    virtualedit = "block",          -- Vitualblock mode doesn't get stuck at the end of line
    inccommand = "split",           -- Shows all inline replacements in split

}

-- Turns on all values in options table above
for option, value in pairs(options) do
    vim.opt[option] = value
end
