--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│ FILE: plugins/hartime.lua                                                │--
--│ NOTE: a plugin helping you establish good command workflow and habit     │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
return {
  "m4xshen/hardtime.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
  },
  --━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
  --                          ┃ Config Function ┃
  --                          ┗━━━━━━━━━━━━━━━━━┛
  config = function ()
    require("hardtime").setup()
    --------------------------- Hardtime Key Binds -----------------------------
    vim.keymap.set("n", "<leader>th", "<cmd>Hardtime toggle<cr>",
      { desc = "[h]ardtime", noremap = true, silent = true })
  end
  --                            ┏━━━━━━━━━━━━━┓
  --                            ┃ Config Ends ┃
  --━━━━━━━━━━━━━━━━━━━━━━━━━━━━┻━━━━━━━━━━━━━┻━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
}
