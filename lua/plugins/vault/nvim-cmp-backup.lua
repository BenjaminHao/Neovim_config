--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│ FILE: plugins/nvim-cmp.lua                                               │--
--│ DESC: Auto-completion plugin, engine for LSP, etc.                       │--
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
  },
  --━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
  --                          ┃ Config Function ┃
  --                          ┗━━━━━━━━━━━━━━━━━┛
  config = function()
    local kind_icons = {
      Class = "",
      Color = "",
      Constant = "󰏿",
      Constructor = "",
      Enum = "",
      EnumMember = "",
      Event = "",
      Field = "󰐣",
      File = "",
      Folder = "",
      Function = "󰊕",
      Interface = "",
      Keyword = "󰌋",
      Method = "󰆧",
      Module = "",
      Operator = "󰆕",
      Property = "󰜢",
      Reference = "",
      Snippet = "",
      Struct = "",
      Text = "󰦨",
      TypeParameter = "",
      Unit = "",
      Value = "󰎠",
      Variable = "󱃮",
    }

    local cmp = require("cmp")
    local luasnip = require("luasnip")

    require("luasnip/loaders/from_vscode").lazy_load()  -- load snippets collection from plugins

    ------------------------------ cmp setup -----------------------------------
    cmp.setup({
      completion = {
        completeopt = "menu,menuone,preview,noselect", -- see :h completeopt 
      },
      snippet = { -- configure how nvim-cmp interacts with snippet engine
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      sources = cmp.config.sources({  -- sources for autocompletion
        { name = "nvim_lsp" },  -- lsp
        { name = "luasnip" }, -- snippets
        { name = "buffer" }, -- text within current buffer
        { name = "path" }, -- file system paths
      }),
      formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
          vim_item.kind = string.format("%s", kind_icons[vim_item.kind]) -- Kind icons
          vim_item.menu = ({
            buffer = "[Buffer]",
            luasnip = "[Snippet]",
            nvim_lsp = "[LSP]",
            path = "[Path]",
            cmdline = "[CMD]"
          })[entry.source.name]
          return vim_item
        end,
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      --             performance = {
      --                 trigger_debounce_time = 500,
      --                 throttle = 550,
      --                 fetching_timeout = 80,
      --             },
      mapping = cmp.mapping.preset.insert({
        ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
        ["<C-h>"] = cmp.mapping.abort(), -- close completion window
        ["<C-l>"] = cmp.mapping.confirm({ select = true }),  -- confirm, no need to select first
        ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
        ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
        ["<C-d>"] = cmp.mapping.scroll_docs(4),  -- scroll down docs(check backwards)
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),  -- scroll up docs(check forwards)
        -- ["<C-f>"] = cmp.mapping.scroll_docs(8),  -- scroll down docs(check forwards)
        -- ["<C-b>"] = cmp.mapping.scroll_docs(-8),  -- scroll up docs(check backwards)
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
        ["<S-CR>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        }),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
          else
            fallback()
          end
          end, { "i", "s" }),
        ["<C-n>"] = cmp.mapping(function()  -- jump to the next part of snippets
          if luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          end
        end, { "i", "s" }),
        ["<C-p>"] = cmp.mapping(function()  -- jump to the previous part of snippets
          if luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          end
        end, { "i", "s" }),
      }),
    })
    --------------------------- Cmd-line Config --------------------------------
    -- TODO: cmdline mapping
    -- `/` cmdline setup.
    cmp.setup.cmdline("/", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        {name = "buffer"}
      }
    })
    -- `:` cmdline setup.
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        {name = "path"},
        {name = "cmdline"}
      }
    })
  end,
  --                            ┏━━━━━━━━━━━━━┓
  --                            ┃ Config Ends ┃
  --━━━━━━━━━━━━━━━━━━━━━━━━━━━━┻━━━━━━━━━━━━━┻━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
}
