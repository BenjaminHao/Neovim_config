--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│ FILE: plugins/indent-blankline.nvim                                      │--
--│ DESC: Indentation guides for Neovim                                      │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
return {
  "lukas-reineke/indent-blankline.nvim",
  version = "*",
  event = { "BufReadPre", "BufNewFile" },
  --━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
  --                          ┃ Config Function ┃
  --                          ┗━━━━━━━━━━━━━━━━━┛
  config = function()
    require("ibl").setup({
      indent = {
        char = "┃",
        tab_char = "┃",
        smart_indent_cap = true,
        priority = 1,
        repeat_linebreak = true,
      },
      scope = {
        enabled = true,
        char = nil,
        show_start = false,
        show_end = false,
        show_exact_scope = false,
        injected_languages = true,
        priority = 1024,
        include = {
          node_type = { ["*"] = { "*" } }, -- makes lines show on all blocks
        },
      },
      exclude = {
        filetypes = {
          "",
          "alpha",
          "checkhealth",
          "dashboard",
          "gitcommit",
          "help",
          "lazy",
          "lspinfo",
          "man",
          "mason",
          "notify",
          "NvimTree",
          "spectre_panel",
          "TelescopePrompt",
          "TelescopeResults",
          "toggleterm",
          "Trouble",
          "trouble",
        },
        buftypes = {
          "nofile",
          "prompt",
          "quickfix",
          "terminal",
        },
      },
    })
  end
  --                            ┏━━━━━━━━━━━━━┓
  --                            ┃ Config Ends ┃
  --━━━━━━━━━━━━━━━━━━━━━━━━━━━━┻━━━━━━━━━━━━━┻━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
}
