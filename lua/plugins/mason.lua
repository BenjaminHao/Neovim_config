--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│ FILE: plugins/mason.lua                                                  │--
--│ DESC: package manager for LSP servers                                    │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
return {
  "williamboman/mason.nvim",
  cmd = { "Mason", "MasonUpdate", "MasonInstall", "MasonInstall" },
  keys = {
    { "<leader>L", "<cmd>Mason<cr>", desc = "[L]SP Manager" }
  },
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
  },
  --━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
  --                          ┃ Config Function ┃
  --                          ┗━━━━━━━━━━━━━━━━━┛
  -- It's important that you set up the plugins in the following order:
  -- 1. mason.nvim
  -- 2. mason-lspconfig.nvim
  -- 3. Setup servers via nvim-lspconfig
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")

    mason.setup({
      ui = {
        border = "none",
        icons = {
          package_installed = "󰗡",
          package_pending = "󰦕",
          package_uninstalled = "󰄰",
        },
        keymaps = {
          toggle_server_expand = "<CR>",
          install_server = "i",
          update_server = "u",
          check_server_version = "c",
          update_all_servers = "U",
          check_outdated_servers = "C",
          uninstall_server = "X",
          cancel_installation = "<C-c>",
        },
        max_concurrent_installers = 10,
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
