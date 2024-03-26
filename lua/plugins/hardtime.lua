--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│ File: plugins/hartime.lua                                                │--
--│ Note: a plugin helping you establish good command workflow and habit     │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
return {
	"m4xshen/hardtime.nvim",
  event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"MunifTanjim/nui.nvim",
		"nvim-lua/plenary.nvim",
	},
	opts = {},

  --━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
  --                          ┃ Config Function ┃
  --                          ┗━━━━━━━━━━━━━━━━━┛
  config = function ()
    require("hardtime").setup({
      disabled_filetypes = {
        "qf",
        "netrw",
        "help",
        "checkhealth",
        "alpha",
        "NvimTree",
        "lazy",
        "mason",
        "spectre_panel",
        "noice"
      },
    })

    --------------------------- Hardtime Key Binds -----------------------------
    vim.keymap.set("n", "<leader>th", "<cmd>Hardtime toggle<cr>",
      { desc = "[h]ardtime", noremap = true, silent = true })
  end
  --                            ┏━━━━━━━━━━━━━┓
  --                            ┃ Config Ends ┃
  --━━━━━━━━━━━━━━━━━━━━━━━━━━━━┻━━━━━━━━━━━━━┻━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
}
