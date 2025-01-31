vim.keymap.set('n', '<Space>', '<Nop>', { silent = true, remap = false })
vim.g.mapleader = ' '

vim.keymap.set('n', '<leader>so', ':so ~/.config/nvim/init.lua<CR>')

-- Move visully selected lines with autoindent
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- Move up and down with centering
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- Toggle hlsearch if it's on, otherwise just do "enter"
vim.keymap.set('n', '<CR>', function()
  if vim.v.hlsearch == 1 then
    vim.cmd.nohl()
    return ''
  else
    return vim.keycode '<CR>'
  end
end, { expr = true })
