local M = {}

M.kind_icons = {
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

M.mason = {
  pending = " ",
  installed = " ",
  uninstalled = " ",
}

-- ------------------------------------------------------------------------
-- | Diagnostics
-- ------------------------------------------------------------------------
M.diagnostics = {
  hint = " ",
  info = " ",
  warn = " ",
  error = " ",
}

-- ------------------------------------------------------------------------
-- | LSP
-- ------------------------------------------------------------------------
M.lsp = {
  kinds = {
    Array = " ",
    Boolean = " ",
    Class = " ",
    Color = " ",
    Constant = " ",
    Constructor = " ",
    Copilot = " ",
    Enum = " ",
    EnumMember = " ",
    Event = " ",
    Field = " ",
    File = " ",
    Folder = " ",
    Function = "󰊕 ",
    Interface = " ",
    Key = " ",
    Keyword = "󰌋 ",
    Method = " ",
    Module = " ",
    Namespace = " ",
    Null = " ",
    Number = " ",
    Object = " ",
    Operator = " ",
    Package = " ",
    Property = " ",
    Reference = " ",
    Snippet = " ",
    String = " ",
    Struct = " ",
    Text = " ",
    TypeParameter = " ",
    Unit = "塞",
    Value = " ",
    Variable = "󰫧 ",
  },
}

-- ------------------------------------------------------------------------
-- | Status Line Separators
-- ------------------------------------------------------------------------
M.separators = {
  top_slant = {
    fill = {
      left = "",
      right = "",
    },
    outline = {
      left = "",
      right = "",
    },
  },

  bottom_slant = {
    fill = {
      left = "",
      right = "",
    },
    outline = {
      left = "",
      right = "",
    },
  },

  round = {
    fill = {
      left = "",
      right = "",
    },
    outline = {
      left = "",
      right = "",
    },
  },

  half = {
    fill = {
      left = "▐",
      right = "▌",
    },
    outline = {
      left = "|",
      right = "|",
    },
  },

  block = {
    fill = {
      left = "█",
      right = "█",
    },
    outline = {
      left = "|",
      right = "|",
    },
  },

  arrow = {
    fill = {
      left = "",
      right = "",
    },
    outline = {
      left = "",
      right = "",
    },
  },
}

return M
