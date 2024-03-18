--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│ File: plugins/zen-mode.lua                                               │--
--│ Note: Distracion-free environment                                        │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
return {
  "folke/zen-mode.nvim",
  cmd = "ZenMode",
  keys = {  -- lazy-load on key binds
    { "<leader>z", "<cmd>ZenMode<cr>", desc = "[z]en Mode" }
  },
  dependencies = {
    "folke/twilight.nvim",  -- dims inactive portions of the code
  },
  opts = {
    plugins = {
      twilight = { enabled = true },
      gitsigns = { enabled = true },
    },
  },
}
