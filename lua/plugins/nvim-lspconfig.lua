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

    ----------------------- LSP Autocmd & Key Binds ----------------------------
    -- LSP
    -- map("n", "M", vim.lsp.buf.hover, { desc = "[M]ore Info" })
    -- map("n", "<C-m>", vim.lsp.buf.signature_help, { desc = "Signature Help" })
    -- map("n", "gD", vim.lsp.buf.declaration, { desc = "[D]eclaration" })
    -- map("n", "gd", vim.lsp.buf.definition, { desc = "[d]efinition" })
    -- map("n", "gi", vim.lsp.buf.implementation, { desc = "[i]mplementation" })
    -- map("n", "gr", vim.lsp.buf.references, { desc = "[r]eferences" })
    -- map("n", "<leader>lr", vim.lsp.buf.rename, { desc = "[r]ename Keyword" })
    -- map("n", "<leader>lc", vim.lsp.buf.code_action, { desc = "[c]ode Action" })
    -- Diagnostics
    map("n", "]d", vim.diagnostic.goto_next, { desc = "Next [d]iagnostic message" })
    map("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous [d]iagnostic message" })
    map("n", "<leader>de", vim.diagnostic.open_float, { desc = "Show diagnostic [e]rror messages" })
    map("n", "<leader>dl", vim.diagnostic.setloclist, { desc = "Open diagnostic quickfix [l]ist" })

    -- kickstart.nvim, so good
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("LSP", { clear = true }),
      callback = function(event)
        local ok, ts_builtin = pcall(require, "telescope.builtin")
        if not ok then
          vim.notify_once("Cannot load Telescope, using Neovim builtin.", vim.log.levels.WARN)
        end

        local function opts(desc)
          return { desc = desc, buffer = event.buf }
        end

        --  To jump back, press <C-t>.
        map("n", "gd", function ()
          if ok then ts_builtin.lsp_definitions()
          else vim.lsp.buf.definition()
          end
        end, opts("Goto [d]efinition"))

        -- Find references for the word under your cursor.
        map("n", "gr", function ()
          if ok then ts_builtin.lsp_references()
          else vim.lsp.buf.references()
          end
        end, opts("Goto [r]eferences"))

        -- Jump to the implementation of the word under your cursor.
        --  Useful when your language has ways of declaring types without an actual implementation.
        map("n", "gI", function ()
          if ok then ts_builtin.lsp_implementations()
          else vim.lsp.buf.implementation()
          end
        end, opts("Goto [I]mplementation"))

        --  This is not Goto Definition, this is Goto Declaration.
        --  For example, in C this would take you to the header.
        map("n", "gD", vim.lsp.buf.declaration, opts("Goto [D]eclaration"))

        map("n", "<C-k>", vim.lsp.buf.signature_help, opts("Signature Help"))
        -- Jump to the type of the word under your cursor.
        --  Useful when you're not sure what type a variable is and you want to see
        --  the definition of its *type*, not where it was *defined*.
        map("n", "<leader>lt", ts_builtin.lsp_type_definitions, opts("[t]ype Definition"))

        -- Fuzzy find all the keywords in your current document.
        --  Keywords are things like variables, functions, types, etc.
        map("n", "<leader>lk", ts_builtin.lsp_document_symbols, opts("[k]eywords"))

        -- Fuzzy find all the keywords in your current workspace.
        --  Similar to document keywords, except searches over your entire project.
        map("n", "<leader>lK", ts_builtin.lsp_dynamic_workspace_symbols, opts("[K]eywords in project"))

        -- Rename the variable under your cursor.
        --  Most Language Servers support renaming across files, etc.
        map("n", "<leader>lr", vim.lsp.buf.rename, opts("[r]ename variable"))

        -- Execute a code action, usually your cursor needs to be on top of an error
        -- or a suggestion from your LSP for this to activate.
        map("n", "<leader>lc", vim.lsp.buf.code_action, opts("[c]ode Action"))

        -- Opens a popup that displays documentation about the word under your cursor
        --  See `:help K` for why this keymap.
        map("n", "K", vim.lsp.buf.hover, opts("Hover Documentation"))


        -- The following two autocommands are used to highlight references of the
        -- word under your cursor when your cursor rests there for a little while.
        --    See `:help CursorHold` for information about when this is executed
        --
        -- When you move your cursor, the highlights will be cleared (the second autocommand).
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.server_capabilities.documentHighlightProvider then
          vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            buffer = event.buf,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            buffer = event.buf,
            callback = vim.lsp.buf.clear_references,
          })

          -- TODO: add toggle function, change highlight color
        end
      end,
    })

  end,
  --                            ┏━━━━━━━━━━━━━┓
  --                            ┃ Config Ends ┃
  --━━━━━━━━━━━━━━━━━━━━━━━━━━━━┻━━━━━━━━━━━━━┻━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
}
