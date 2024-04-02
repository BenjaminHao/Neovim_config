--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│ FILE: plugins/nvim-lspconfig.lua                                         │--
--│ DESC: LSP config file (npm is required)                                  │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
-- TODO: Restructuring LSP files, add neodev.nvim
return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "williamboman/mason.nvim",
    "hrsh7th/cmp-nvim-lsp",
  },
  --━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
  --                          ┃ Config Function ┃
  --                          ┗━━━━━━━━━━━━━━━━━┛
  config = function()
    local lspconfig = require("lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local map = require("core.utils").set_vim_keymap
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

    ---------------------------- LSP Key Binds ---------------------------------
    -- LSP
    map("n", "M", vim.lsp.buf.hover, { desc = "[M]ore Info" })
    map("n", "<C-m>", vim.lsp.buf.signature_help, { desc = "Signature Help" })
    map("n", "gD", vim.lsp.buf.declaration, { desc = "[D]eclaration" })
    map("n", "gd", vim.lsp.buf.definition, { desc = "[d]efinition" })
    map("n", "gi", vim.lsp.buf.implementation, { desc = "[i]mplementation" })
    map("n", "gr", vim.lsp.buf.references, { desc = "[r]eferences" })
    map("n", "<leader>lr", vim.lsp.buf.rename, { desc = "[r]ename Keyword" })
    map("n", "<leader>lc", vim.lsp.buf.code_action, { desc = "[c]ode Action" })
    -- Diagnostics
    map("n", "]d", vim.diagnostic.goto_next, { desc = "Next [d]iagnostic message" })
    map("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous [d]iagnostic message" })
    map("n", "<leader>de", vim.diagnostic.open_float, { desc = "Show diagnostic [e]rror messages" })
    map("n", "<leader>dl", vim.diagnostic.setloclist, { desc = "Open diagnostic quickfix [l]ist" })
  end,
  --                            ┏━━━━━━━━━━━━━┓
  --                            ┃ Config Ends ┃
  --━━━━━━━━━━━━━━━━━━━━━━━━━━━━┻━━━━━━━━━━━━━┻━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
}
