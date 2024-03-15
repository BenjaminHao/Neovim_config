--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│ File: plugins/nvim-lspconfig.lua                                         │--
--│ Note: LSP config file                                                    │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "williamboman/mason.nvim",
    "hrsh7th/cmp-nvim-lsp",
  },
  --━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
  --                         ┃ LSP-Config Config ┃
  --                         ┗━━━━━━━━━━━━━━━━━━━┛
  config = function()
    -- import lspconfig plugin
    local lspconfig = require("lspconfig")
    -- import cmp-nvim-lsp plugin
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    -- used to enable autocompletion (assign to every lsp server config)
    local default = cmp_nvim_lsp.default_capabilities()
    -- Change the Diagnostic symbols in the sign column (gutter)
    local signs = { Error = "", Warn = "", Hint = "󰠠", Info = "" }

    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    -- configure lua server (with special settings)
    lspconfig["lua_ls"].setup({
      capabilities = default,
      settings = {  -- custom settings for lua
        Lua = {
          diagnostics = {
            globals = { "vim" },  -- make the language server recognize "vim" global
          },
          workspace = {
            -- make language server aware of runtime files
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.stdpath("config") .. "/lua"] = true,
            },
          },
        },
      },
    })

    -- configure C/C++ server
    lspconfig["clangd"].setup({
      capabilities = default,
    })

    -- configure Java language server
    lspconfig["jdtls"].setup({
      capabilities = default,
    })

  end,
  --━━━━━━━━━━━━━━━━━━━━━━━━━━ Config Ends Here ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
}
