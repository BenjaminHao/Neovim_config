return {
  {
    "aikow/base.nvim",
    lazy = false,
    opts = function ()
      require("base").setup({
        integrations = {
          "builtin.defaults",
          "builtin.git",
          "builtin.lsp",
          "builtin.semantic",
          "builtin.syntax",
          "builtin.terminal",
          "builtin.treesitter",
          "plugin.cmp",
          "plugin.devicons",
          "plugin.indent-blankline",
          "plugin.lualine",
          "plugin.luasnip",
          "plugin.mason",
          "plugin.mini",
          "plugin.nvimtree",
          "plugin.telescope",
          "plugin.treesitter",
        },
      })
      vim.cmd.colorscheme({ "base-everforest" })
    end
  },
}
