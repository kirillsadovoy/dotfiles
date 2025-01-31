return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('lualine').setup {
      options = {
        component_separators = '',
        section_separators = { left = '', right = '' },
        disabled_filetypes = { 'neo-tree' },
        symbols = { error = 'E|', warn = 'W|', info = 'I|', hint = 'H|' },
      },
    }
  end,
}
