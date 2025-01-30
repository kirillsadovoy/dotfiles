return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  },
  config = function()
    require('telescope').setup {
      extensions = {
        wrap_results = true,
        fzf = {},
      },
      pickers = {
        find_files = {
          theme = 'ivy',
        },
      },
    }

    local builtin = require 'telescope.builtin'

    require('telescope').load_extension 'fzf'

    vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
  end,
}
