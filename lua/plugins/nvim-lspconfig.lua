--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│ FILE: plugins/nvim-lspconfig.lua                                         │--
--│ DESC: LSP config file (all in one)                                       │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
-- TODO: Restructuring LSP files, add neodev.nvim
return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    "williamboman/mason.nvim", -- package manager for LSP servers
    "williamboman/mason-lspconfig.nvim", -- bridges mason with nvim-lspconfig
    "hrsh7th/cmp-nvim-lsp", -- nvim-cmp source
    "folke/neodev.nvim" -- for nvim lua api
  },
  --━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
  --                          ┃ Config Function ┃
  --                          ┗━━━━━━━━━━━━━━━━━┛
  -- It's important that you set up the plugins in the following order:
  -- 1. mason.nvim
  -- 2. mason-lspconfig.nvim
  -- 3. Setup servers via lspconfig
  config = function()
    local lspconfig = require("lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    local map = require("core.utils").set_vim_keymap
    -- used to enable autocompletion (assign to every lsp server config)
    local default = cmp_nvim_lsp.default_capabilities()
    -- Change the Diagnostic symbols in the sign column (gutter)
    local signs = { Error = "", Warn = "", Hint = "󰠠", Info = "" }

    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    ---------------------------- Mason Config ----------------------------------
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

    ------------------------ Mason Lspconfig Config ----------------------------
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

    ------------------------ Nvim Lspconfig Config -----------------------------
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
    -- Mason
    map("n", "<leader>L", "<cmd>Mason<cr>", { desc = "[L]SP Manager" })

  end,
  --                            ┏━━━━━━━━━━━━━┓
  --                            ┃ Config Ends ┃
  --━━━━━━━━━━━━━━━━━━━━━━━━━━━━┻━━━━━━━━━━━━━┻━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
}
