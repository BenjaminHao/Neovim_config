--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│ FILE: plugins/lualine.lua                                                │--
--│ NOTE: Status line plugin                                                 │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  --━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
  --                          ┃ Config Function ┃
  --                          ┗━━━━━━━━━━━━━━━━━┛
  config = function()
    local lualine = require("lualine")
    local mode_icon = {
      ["NORMAL"] = " ",
      ["INSERT"] = "󰘎 ",
      ["VISUAL"] = " ",
      ["V-LINE"] = " ",
      ["V-BLOCK"] = " ",
      ["O-PENDING"] = "󰝁 ",
      ["COMMAND"] = " ",
      ["REPLACE"] = "󰑇 ",
      ["SELECT"] = " ",
      ["CONFIRM"] = "󰄴 ",
      ["SHELL"] = "",
      ["V-REPLACE"] = "󰰪 ",
      ["TERMINAL"] = "󰰤 ",
      ["MORE"] = "󰰏 ",
      ["EX"] = "󰯷 ",
    }

    lualine.setup {
      options = {
        theme = "auto",
        component_separators = "󰇙",
        section_separators = { left = "", right = "" },
        globalstatus = true,
      },
      sections = {
        lualine_a = {
          { "mode",
            fmt = function(str)
              return mode_icon[str] .. str:sub(2)
            end,
            separator = { left = "", right = ""},
          },
        },
        lualine_b = {
          {
            "filename",
            symbols = {
              modified = "󰏫",  -- Text to show when the file is modified.
              readonly = "",  -- Text to show when the file is non-modifiable or readonly.
              unnamed = "",    -- Text to show for unnamed buffers.
              newfile = "",   -- Text to show for newly created file before first write
            },
          },
          { "branch" }
        },
        lualine_c = {},
        lualine_x = {
          { -- show @recording message
            require("noice").api.statusline.mode.get,
            cond = require("noice").api.statusline.mode.has,
          }
        },
        lualine_y = { "location", "progress" },
        lualine_z = {
          {
            "filetype",
            -- icon_only = true,
            padding = { left = 1, right = 0 }
          },
          { "fileformat",
            symbols = {
              unix = "@  UNIX",
              dos = "@  WIN",
              mac = "@  OSX",
            },
            separator = { left = "", right = ""},
          },
        },
      },
      inactive_sections = {
        lualine_a = { "filename" },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      extensions = { "nvim-tree", "lazy", "mason" },
    }
  end,
  --                            ┏━━━━━━━━━━━━━┓
  --                            ┃ Config Ends ┃
  --━━━━━━━━━━━━━━━━━━━━━━━━━━━━┻━━━━━━━━━━━━━┻━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
}
