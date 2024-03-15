--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│ File: plugins/nvim-tree.lua                                              │--
--│ Note: file explorer plugin                                               │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
return {
  "nvim-tree/nvim-tree.lua",
  cmd = { "NvimTreeToggle" },  -- lazy-load on command
  keys = {  -- lazy-load on key binds
    { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "[e]xplorer" }
  },
  dependencies = { "nvim-tree/nvim-web-devicons" },
  --━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
  --                          ┃ Nvim-Tree Config ┃
  --                          ┗━━━━━━━━━━━━━━━━━━┛
  config = function()
    local nvimtree = require("nvim-tree")

    local function on_attach(bufnr)
      local api = require "nvim-tree.api"
      local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end
      api.config.mappings.default_on_attach(bufnr)
      vim.keymap.set("n", "l", api.node.open.edit, opts "Open")
      vim.keymap.set("n", "u", api.tree.change_root_to_parent, opts "Up")
    end

    nvimtree.setup({
      on_attach = on_attach,
      disable_netrw = true,
      hijack_netrw = true,
      -- auto_close          = true,
      auto_reload_on_write = true,
      open_on_tab = false,
      hijack_cursor = true,
      respect_buf_cwd = true,
      actions = {
        use_system_clipboard = true,
        change_dir = {
          enable = true,
          global = false,
        },
        open_file = {
          quit_on_open = true,
          resize_window = true,
          window_picker = {
            enable = true,
            chars = "1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ",
            exclude = {
              filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame", "dbui", "dbout" },
              buftype = { "nofile", "terminal", "help" },
            },
          },
        },
      },
      update_focused_file = {
        enable = true,
        update_cwd = false,
        ignore_list = {},
      },
      system_open = {
        cmd = "",
        args = {},
      },
      filters = {
        dotfiles = false,
        custom = { "^.git$" },
      },
      git = {
        enable = true,
        ignore = true,
        timeout = 400,
      },
      view = {
        width = 30,
        side = "left",
        preserve_window_proportions = false,
        number = false,
        relativenumber = false,
        signcolumn = "yes",
      },
      renderer = {
        root_folder_label = false,
        indent_markers = {
          enable = true,
          icons = {
            corner = "┗",
            edge = "┃",
            item = "┣",
            bottom = "━",
            none = " ",
          },
        },
        icons = {
          glyphs = {
            folder = {
              arrow_closed = "",
              arrow_open = "",
              default = "",
              open = "",
              empty = "",
              empty_open = "",
              symlink = "",
              symlink_open = "",
            },
            git = {
              unstaged = "",
              staged = "",
              unmerged = "",
              renamed = "",
              untracked = "",
              deleted = "",
              ignored = "",
            },
          },
        },
      },
      trash = {
        cmd = "trash",
        require_confirm = true,
      },
    })
  end,
  --━━━━━━━━━━━━━━━━━━━━━━━━━━ Config Ends Here ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
}
