--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│ File: plugins/telescope.lua                                              │--
--│ Note: Fuzzy finder plugin                                                │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  cmd = "Telescope",  -- lazy-load on command
  keys = {  -- lazy-load on key maps
    { '<leader>fb', "<cmd>Telescope buffers<cr>",  desc = '[b]uffers' },
    { '<leader>fd', "<cmd>Telescope diagnostics<cr>",  desc = '[d]iagnostics' },
    { '<leader>ff', "<cmd>Telescope find_files<cr>",  desc = '[f]iles' },
    { '<leader>fg', "<cmd>Telescope live_grep<cr>",  desc = '[g]rep' },
    { '<leader>fh', "<cmd>Telescope help_tags<cr>",  desc = '[h]elp' },
    { '<leader>fk', "<cmd>Telescope keymaps<cr>",  desc = '[k]eymaps' },
    { '<leader>fr', "<cmd>Telescope oldfiles<cr>",  desc = '[r]ecent files' },
    -- { '<leader>fr', "<cmd>Telescope resume<cr>",  desc = '[r]esume' },
    { '<leader>ft', "<cmd>Telescope builtin<cr>",  desc = '[t]elescope' },
    { '<leader>fu', "<cmd>Telescope undo<cr>",  desc = '[u]ndo' },
    { '<leader>fw', "<cmd>Telescope grep_string<cr>",  desc = '[w]ord' },
    -- Shortcut for searching your neovim configuration files
    { '<leader>fn', function()
      require("telescope.builtin").find_files {
        cwd = vim.fn.stdpath 'config',
        prompt_title = 'Find Neovim Config Files',
      } end,
      desc = '[n]eovim config'
    }
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "debugloop/telescope-undo.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      cond = function()  -- determine if this should be installed and loaded
        return vim.fn.executable 'make' == 1
      end,
    },
    "nvim-tree/nvim-web-devicons",
  },
  --━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
  --                          ┃ Telescope Config ┃
  --                          ┗━━━━━━━━━━━━━━━━━━┛
  -- TODO: Telescope Style
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local undo = require("telescope-undo.actions")
    telescope.setup({
      --━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
      --                     ┃ Telescope builtin ┃
      --                     ┗━━━━━━━━━━━━━━━━━━━┛
      defaults = {
        path_display = { "smart" },
        prompt_prefix = "󰭎 ",
        selection_caret = " ",
        entry_prefix = " ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "descending",
        scroll_strategy = "cycle",
        dynamic_preview_title = true,
        layout_strategy = "horizontal",
        layout_config = {
          prompt_position = "bottom",
          horizontal = { preview_width = 0.6, width = 0.95 },
          preview_cutoff = 120,
        },
        file_ignore_patterns = { "node_modules", "^.git/" },
        winblend = 0,
        color_devicons = true,
        mappings = {
          i = {
            ["<C-j>"] = actions.move_selection_next,     -- also: <C-n>
            ["<C-k>"] = actions.move_selection_previous, -- also: <C-p>
            ["<C-f>"] = actions.preview_scrolling_down,  -- also: <C-d>
            ["<C-b>"] = actions.preview_scrolling_up,    -- also: <C-u>
          },
          n = {
            ["q"] = actions.close,
            ["?"] = actions.which_key,
          },
        },
      },
      --━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━--
      --                    ┃ Telescope extensions ┃
      --                    ┗━━━━━━━━━━━━━━━━━━━━━━┛
      load_extension = {
        "fzf",
        "yank_history",
        "undo",
        "lazygit"
      },
      extensions = {
        undo = {
          mappings = {
            i = {
              ["<C-a>"] = undo.yank_additions,
              ["<C-d>"] = undo.yank_deletions,
              ["<C-u>"] = undo.restore,
            },
            n = {
              ["y"] = undo.yank_additions,
              ["Y"] = undo.yank_deletions,
              ["u"] = undo.restore,
            },
          },
        },
      },
    })
  end,
  --━━━━━━━━━━━━━━━━━━━━━━━━━━ Config Ends Here ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
}
