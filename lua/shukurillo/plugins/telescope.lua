return {
    {
      'nvim-telescope/telescope.nvim',
      dependencies = { 'nvim-lua/plenary.nvim' },
      config = function()
        local telescope = require('telescope')
        local builtin = require('telescope.builtin')

        telescope.setup({
          defaults = {
        mappings = {
          n = {
            ['<C-k>'] = 'preview_scrolling_up',
            ['<C-j>'] = 'preview_scrolling_down',
            ['<C-h>'] = 'preview_scrolling_left',
            ['<C-l>'] = 'preview_scrolling_right',
          },
          i = {
            ['<C-k>'] = 'preview_scrolling_up',
            ['<C-j>'] = 'preview_scrolling_down',
            ['<C-h>'] = 'preview_scrolling_left',
            ['<C-l>'] = 'preview_scrolling_right',
          }
        }
          }
        })

        -- Keymaps
        vim.keymap.set('n', '<leader>ff', builtin.find_files)
        vim.keymap.set('n', '<leader>fg', builtin.git_files, {})
        vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
        vim.keymap.set('n', '<leader>fs', builtin.live_grep)
        --    vim.keymap.set('n', '<leader>fs', function()
        -- 	builtin.grep_string({ search = vim.fn.input("Grep > ") });
        -- end)
      end,
    },
    {
        'nvim-telescope/telescope-ui-select.nvim',
        config = function()
            -- This is your opts table
            require("telescope").setup {
              extensions = {
                ["ui-select"] = {
                  require("telescope.themes").get_dropdown {
                  }
                }
              }
            }
            -- To get ui-select loaded and working with telescope, you need to call
            -- load_extension, somewhere after setup function:
            require("telescope").load_extension("ui-select")
        end
    }
}
