return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
  },
  config = function()
    vim.keymap.set('n', '<leader>\\', ':Neotree toggle<CR>', { silent = true })

    require('neo-tree').setup {
      close_if_last_window = true,
      filesystem = {
        filtered_items = {
          visible = true,
        },
        follow_current_file = {
          enabled = true,
        },
        hijack_netrw_behavior = 'open_current',
        find_args = {
          fd = {
            '--exclude',
            '.git',
            '--exclude',
            'node_modules',
          },
        },
      },
    }
  end,
}
