--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│ File: plugins/nvim-treesitter.lua                                        │--
--│ Note: Syntax highlighting plugin (a C complier is required)              │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  -- event = "VeryLazy",
  -- TODO: bug fix? treessiter no loading after checkhealth. another event?
  event = { "BufReadPre", "BufNewFile" },  -- lazy-load on events
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects", -- syntax aware text-objects
    "nvim-treesitter/nvim-treesitter-context", -- shows the context
    "windwp/nvim-ts-autotag",
    "Wansmer/treesj", -- for splitting/joning blocks of code
  },
  --━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
  --                          ┃ Config Function ┃
  --                          ┗━━━━━━━━━━━━━━━━━┛
  -- TODO: Treesitter textobject key binds
  config = function()
    local treesitter = require("nvim-treesitter.configs")
    local treesj = require("treesj")
    local context = require("treesitter-context")

    --------------------------- Treesitter Setup -------------------------------
    treesitter.setup({
      highlight = {
        enable = true,            -- enable syntax highlighting
        disable = {},             -- list of language that will be disabled
      },
      indent = {
        enable = true,            -- enable indentation
      },
      autotag = {
        enable = true,            -- enable autotagging (w/ nvim-ts-autotag plugin)
      },
      autopairs = {
        enable = true,            -- enable autopairs
      },
      ensure_installed = {        -- ensure these language parsers are installed
        "bash",
        "c",
        "cpp",
        "css",
        "diff",
        "dockerfile",
        "git_config",
        "git_rebase",
        "gitcommit",
        "gitignore",
        "go",
        "gomod",
        "gosum",
        "gowork",
        "html",
        "http",
        "java",
        "javascript",
        "json",
        "lua",
        "markdown",
        "python",
        "rust",
        "sql",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
      },
      auto_install = true,
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-n>",
          node_incremental = "<C-n>",
          scope_incremental = false,
          node_decremental = "<C-p>",
        },
      },
    })

    ---------------------------- Treesj Config ---------------------------------
    treesj.setup = {
      use_default_keymaps = false
    }
    ------------------------ Treesitter Key Binds ---------------------------------
    -- context key binds
    vim.keymap.set("n", "[c", function() context.go_to_context(vim.v.count1) end,
      { desc = "Go back to context", noremap = true, silent = true })
    vim.keymap.set("n", "<leader>tc", "<cmd>TSContextToggle<cr>",
      { desc = "[c]ontext Preview", noremap = true, silent = true })

    -- Treesj key bind
    vim.keymap.set("n", "<C-Enter>", function() treesj.toggle() end,
      { desc = "Split/joining blocks of Code", noremap = true, silent = true })

  end
  --                            ┏━━━━━━━━━━━━━┓
  --                            ┃ Config Ends ┃
  --━━━━━━━━━━━━━━━━━━━━━━━━━━━━┻━━━━━━━━━━━━━┻━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
}
