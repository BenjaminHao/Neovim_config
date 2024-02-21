--=====================================================================
--
-- File: plugins/bufferline.lua
-- Note: UI plugin that shows opened buffers on top of the window
--
--=====================================================================
return {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    version = "*",
    config = function()
        local bufferline = require('bufferline')
        bufferline.setup({
            options = {
                mode = "buffers",
                separator_style = "slant",
                close_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
                diagnostics = false,           -- OR: | "nvim_lsp" 
                diagnostics_update_in_insert = false,
                show_tab_indicators = false,
                -- always_show_bufferline = false,
                show_buffer_close_icons = false,
                show_close_icon = false,
                sort_by = 'insert_at_end', -- OR: 'insert_after_current' | 'id' | 'extension' | 'relative_directory' | 'directory' | 'tabs' |
                -- function(buffer_a, buffer_b)
                --   -- add custom logic
                --   return buffer_a.modified > buffer_b.modified
                -- end
                offsets = {
                    {
                        filetype = "NvimTree",
                        -- text = "NvimTree Explorer",
                        text = function()
                            return vim.fn.getcwd()
                        end,
                        highlight = "Directory",
                        separator = "", -- use a "true" to enable the default, or set your own character
                        -- padding = 1
                    }
                },
            }
        })
    end,
}
