--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│ FILE: plugins/dressing.lua                                               │--
--│ DESC: UI improvement plugin, better looking promt                        │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
return {
  "stevearc/dressing.nvim",
  event = "VeryLazy",
  --━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
  --                          ┃ Config Function ┃
  --                          ┗━━━━━━━━━━━━━━━━━┛
  config = function()
    require("dressing").setup({
      input = {
        default_prompt = "󰘎 Input",
        title_pos = "center",
        relative = "cursor",
        prefer_width = 30,
        width = nil,
        -- min_width and max_width can be a list of mixed types.
        -- min_width = {20, 0.2} means "the greater of 20 columns or 20% of total"
        max_width = { 140, 0.9 },
        min_width = { 20, 0.2 },
        win_options = {
          winhighlight = "NormalFloat:TelescopePromptNormal,FloatBorder:TelescopePromptBorder,FloatTitle:TelescopePromptTitle",
        }
      },
      select = {
        backend = { "telescope", "nui", "builtin" },
      },
    })
  end
  --                            ┏━━━━━━━━━━━━━┓
  --                            ┃ Config Ends ┃
  --━━━━━━━━━━━━━━━━━━━━━━━━━━━━┻━━━━━━━━━━━━━┻━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
}
