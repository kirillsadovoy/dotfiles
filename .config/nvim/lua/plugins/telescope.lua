return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    'nvim-telescope/telescope-ui-select.nvim',
  },
  config = function()
    require('telescope').setup {
      defaults = require('telescope.themes').get_ivy {
        mappings = {
          i = {
            ['<C-y>'] = 'select_default',
          },
        },
      },
      extensions = {
        wrap_results = true,
        fzf = {},
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },
    }

    local builtin = require 'telescope.builtin'

    require('telescope').load_extension 'fzf'
    require('telescope').load_extension 'ui-select'

    vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
    vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
  end,
}
