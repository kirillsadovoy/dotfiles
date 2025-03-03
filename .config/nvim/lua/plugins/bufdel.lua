return {
  'ojroques/nvim-bufdel',
  config = function()
    vim.keymap.set('n', '<leader>x', ':BufDel<CR>', { noremap = true, silent = true })
    vim.keymap.set('n', '<leader>X', ':BufDelOthers<CR>', { noremap = true, silent = true })
  end,
}
