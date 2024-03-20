--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│ File: plugins/nvim-treesitter.lua                                        │--
--│ Note: Syntax highlighting plugin (a C complier is required)              │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPre", "BufNewFile" },  -- lazy-load on events
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    "windwp/nvim-ts-autotag",
  },
  --━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
  --                       ┃ Treesitter config ┃
  --                       ┗━━━━━━━━━━━━━━━━━━━┛
  -- TODO: Treesitter textobject key binds
  config = function()
    require("nvim-treesitter.configs").setup({
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
  end,
  --━━━━━━━━━━━━━━━━━━━━━━━━━━ Config Ends Here ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
}
