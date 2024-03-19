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
      local map = vim.keymap.set
      local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end
      map("n", "?", api.tree.toggle_help, opts "Help")
      map("n", "l", api.node.open.edit, opts "Open")
      map("n", "s", api.node.open.horizontal, opts("Open With Horizontal Split"))
      map("n", "v", api.node.open.vertical, opts("Open With Vertical Split"))
      map("n", "o", api.node.run.system, opts("System Open"))
      map("n", "i", api.node.show_info_popup, opts("Info"))
      map("n", "a", api.fs.create, opts("Create"))
      map("n", "r", api.fs.rename, opts("Rename"))
      map("n", "c", api.fs.copy.node, opts("Copy"))
      map("n", "x", api.fs.cut, opts("Cut"))
      map("n", "p", api.fs.paste, opts("Paste"))
      map("n", "d", api.fs.remove, opts("Delete"))
      map("n", "D", api.fs.trash, opts("Trash"))
      map("n", "y", api.fs.copy.filename, opts("Yank Filename"))  -- or basename
      map("n", "Y", api.fs.copy.absolute_path, opts("Yank Absolute Path"))
      map("n", "t", api.tree.toggle_custom_filter, opts("Toggle Dotfiles Files"))
      map("n", "T", api.tree.toggle_custom_filter, opts("Toggle Hidden Files"))
      map("n", "J", api.node.navigate.sibling.last, opts("To Last Sibling"))
      map("n", "K", api.node.navigate.sibling.first, opts("To First Sibling"))
      map("n", "h", api.node.navigate.parent, opts("To Parent Directory"))
      map("n", "H", api.tree.change_root_to_node, opts("Set Root Directory"))
      map("n", "u", api.tree.change_root_to_parent, opts "Show parent root")
      map("n", "q", api.tree.close, opts("Close"))
      map("n", "R", api.tree.reload, opts("Refresh"))
      map("n", "S", api.tree.search_node, opts("Search"))
    end

    nvimtree.setup({
      on_attach = on_attach,
      disable_netrw = true,
      hijack_netrw = true,
      auto_reload_on_write = true,
      open_on_tab = false,
      hijack_cursor = true,
      actions = {
        use_system_clipboard = true,
        open_file = {
          quit_on_open = true,
          eject = true,
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
        change_dir = {
          enable = true,
          global = true,  -- also change other plugins cwd (eg. Telescope)
          restrict_above_cwd = false,
        },
        remove_file = {
          close_window = true,
        }
      },
      update_focused_file = {
        enable = true,
        update_root = true,
        ignore_list = { "help" },
      },
      system_open = {
        cmd = "",
        args = {},
      },
      filters = {
        git_ignored = false,
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
        root_folder_label = ":t",
        add_trailing = false,
        group_empty = true,
        full_name = true,
        highlight_git = "none",
        highlight_diagnostics = "none",
        highlight_opened_files = "none",
        highlight_bookmarks = "none",
        highlight_clipboard = "name",
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
          webdev_colors = true,
          git_placement = "before",
          modified_placement = "after",
          diagnostics_placement = "signcolumn",
          bookmarks_placement = "signcolumn",
          padding = " ",
          symlink_arrow = " ➛ ",
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
            modified = true,
            diagnostics = true,
            bookmarks = false,
          },
          glyphs = {
            symlink = "",
            bookmark = "󰆤",
            modified = "●",
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
              unmerged = "󰽜",
              renamed = "",
              untracked = "",
              deleted = "",
              ignored = "",
            },
          },
        },
      },
      diagnostics = {
        enable = true,
        show_on_dirs = true,
        show_on_open_dirs = false,
        debounce_delay = 50,
        severity = {
          min = vim.diagnostic.severity.HINT,
          max = vim.diagnostic.severity.ERROR,
        },
        icons = {
          hint = "",
          info = "",
          warning = "",
          error = "",
        },
      },
      trash = {
        cmd = "trash",
        require_confirm = true,
      },
      notify = {
        threshold = vim.log.levels.ERROR,
        absolute_path = true,
      },
      help = {
        sort_by = "desc",
      },
      ui = {
        confirm = {
          remove = true,
          trash = true,
          default_yes = true,
        },
      },
    })
  end,
  --━━━━━━━━━━━━━━━━━━━━━━━━━━ Config Ends Here ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
}
