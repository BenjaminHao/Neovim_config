--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│ FILE: plugins/nvim-surround.lua                                          │--
--│ DESC: surround selections                                                │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
return {
  "kylechui/nvim-surround",
  event = { "BufReadPost", "BufNewFile" },
  version = "*", -- Use for stability; omit to use `main` branch for the latest features
  --━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
  --                          ┃ Config Function ┃
  --                          ┗━━━━━━━━━━━━━━━━━┛
  -- NOTE: maybe need to change key binds later
  config = function()
    require("nvim-surround").setup({
      keymaps = {
        insert = false,
        insert_line = false,
        normal = "s",
        normal_cur = "ss",
        normal_line = "S",
        normal_cur_line = "SS",
        visual = "s",
        visual_line = "S",
        delete = "ds",
        change = "cs",
        change_line = "cS"
      },
    })
  end
  --                            ┏━━━━━━━━━━━━━┓
  --                            ┃ Config Ends ┃
  --━━━━━━━━━━━━━━━━━━━━━━━━━━━━┻━━━━━━━━━━━━━┻━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
}
