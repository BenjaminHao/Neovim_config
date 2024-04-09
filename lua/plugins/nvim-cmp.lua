--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│ FILE: plugins/nvim-cmp.lua                                               │--
--│ DESC: Auto-completion plugin, engine for LSP.                            │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
return {
  "hrsh7th/nvim-cmp",
  event = { "InsertEnter", "CmdlineEnter" },
  dependencies = {
    "hrsh7th/cmp-buffer", -- source for text in buffer
    "hrsh7th/cmp-path", -- source for file system paths
    "hrsh7th/cmp-cmdline",  -- source for command line
    "saadparwaiz1/cmp_luasnip", -- for autocompletion
    "L3MON4D3/LuaSnip", -- snippet engine
    "rafamadriz/friendly-snippets",  -- some snippets collection
    "onsails/lspkind.nvim", -- vs-code like pictograms
  },
  --━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
  --                          ┃ Config Function ┃
  --                          ┗━━━━━━━━━━━━━━━━━┛
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local lspkind = require("lspkind")
    local util = require("core.utils")

    ------------------------------ cmp setup -----------------------------------
    cmp.setup({
      completion = {
        completeopt = "menu,menuone", -- see :h completeopt 
      },
      sources = cmp.config.sources({  -- sources for autocompletion
        { name = "nvim_lsp" },  -- lsp
        { name = "luasnip" }, -- snippets
        { name = "buffer" }, -- text within current buffer
        { name = "path" }, -- file system paths
      }),
      snippet = { -- configure how nvim-cmp interacts with snippet engine
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
          local kind = lspkind.cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
          local strings = vim.split(kind.kind, "%s", { trimempty = true })
          vim_item.kind = " " .. (strings[1] or "") .. " "
          vim_item.menu = " " .. (strings[2] or "")
          return vim_item
        end,
      },
      window = {
        completion = {
          -- border = util.set_colorborder("CmpBorder"),
          side_padding = 0,
          col_offset = -3,
          scrollbar = true,
          winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:None",
        },
        documentation = {
          border = util.set_colorborder("CmpDocBorder"),
          winhighlight = "Normal:CmpDoc",
        },
      },
      experimental = { -- enable ghost text when using cmp
        ghost_text = {
          hl_group = "Comment",
        },
      },
      mapping = {
        ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
        ["<C-q>"] = cmp.mapping.abort(), -- quit completion window
        ["<C-y>"] = cmp.mapping.confirm({ select = true }),
        ["<C-n>"] = cmp.mapping.select_next_item(), -- next suggestion
        ["<C-p>"] = cmp.mapping.select_prev_item(), -- previous suggestion
        ["<C-d>"] = cmp.mapping.scroll_docs(4),  -- scroll down docs(check backwards)
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),  -- scroll up docs(check forwards)
        ["<C-f>"] = cmp.mapping(function()  -- jump forward inside snippets
          if luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          end
        end, { "i", "s" }),
        ["<C-b>"] = cmp.mapping(function()  -- jump backward inside snippets
          if luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          end
        end, { "i", "s" }),
        -- regular tab completion
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<CR>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        }),
      }
    })
    ---------------------------- luasnip setup ---------------------------------
    require("luasnip/loaders/from_vscode").lazy_load()  -- load snippets collection from plugins

    -------------------------- cmp-cmdline setup -------------------------------
    -- "/", "?" cmdline setup.
    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" }
      }
    })

    -- ":" cmdline setup.
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "path" },
        { name = "cmdline" }
      }
    })
  end,
  --                            ┏━━━━━━━━━━━━━┓
  --                            ┃ Config Ends ┃
  --━━━━━━━━━━━━━━━━━━━━━━━━━━━━┻━━━━━━━━━━━━━┻━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
}
