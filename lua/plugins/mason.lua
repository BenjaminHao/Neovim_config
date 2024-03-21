--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│ File: plugins/mason.lua                                                  │--
--│ Note: package manager for LSP servers                                    │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
return {
  "williamboman/mason.nvim",
  cmd = { "Mason", "MasonUpdate" },
  keys = {  -- lazy-load on keys
    { "<leader>L", "<cmd>Mason<cr>", desc = "[L]SP Manager (Mason)" }
  },
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
  },
  --━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
  --                          ┃ Config Function ┃
  --                          ┗━━━━━━━━━━━━━━━━━┛
  config = function()
    -- import mason
    local mason = require("mason")
    -- import mason-lspconfig
    local mason_lspconfig = require("mason-lspconfig")

    -- enable mason and configure icons
    mason.setup({
      ui = {
        border = "rounded",
        icons = {
          package_installed = "",
          package_pending = "",
          package_uninstalled = "",
        },
      },
    })

    mason_lspconfig.setup({
      -- list of servers for mason to install
      -- https://github.com/williamboman/mason-lspconfig.nvim?tab=readme-ov-file#available-lsp-servers
      ensure_installed = {
        "clangd",    -- c/c++
        "html",      -- HTML
        "jdtls",     -- java
        "jsonls",    -- json
        "lua_ls",    -- lua
        "pyright",   -- python
        "tsserver",  -- javascript
      },
      -- auto-install configured servers (with lspconfig)
      automatic_installation = true, -- not the same as ensure_installed
    })
  end,
  --                            ┏━━━━━━━━━━━━━┓
  --                            ┃ Config Ends ┃
  --━━━━━━━━━━━━━━━━━━━━━━━━━━━━┻━━━━━━━━━━━━━┻━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
}
