local opts = { noremap = true, silent = true }

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.g.mapleader = ' '

vim.keymap.set('n', '<leader>so', ':so ~/.config/nvim/init.lua<CR>')

-- Keep last yanked when pasting
vim.keymap.set('v', 'p', '"_dP', opts)

-- Delete single char without copying
vim.keymap.set('n', 'x', '"_x', opts)

-- Move visully selected lines with autoindent
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", opts)
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", opts)

-- Move up and down with centering
vim.keymap.set('n', '<C-d>', '<C-d>zz', opts)
vim.keymap.set('n', '<C-u>', '<C-u>zz', opts)

-- Toggle hlsearch if it's on, otherwise just do "enter"
vim.keymap.set('n', '<CR>', function()
  if vim.v.hlsearch == 1 then
    vim.cmd.nohl()
    return ''
  else
    return vim.keycode '<CR>'
  end
end, { expr = true })

-- Toggle quickfix list
vim.keymap.set('n', '<leader>q', function()
  local qf_winid = vim.fn.getqflist({ winid = 0 }).winid
  local action = qf_winid > 0 and 'cclose' or 'copen'
  vim.cmd('botright ' .. action)
end, opts)

-- Cycle through quickfix list
vim.keymap.set('n', ']q', '<cmd>try | cnext | catch | cfirst | catch | endtry<CR>', opts)
vim.keymap.set('n', '[q', '<cmd>try | cprevious | catch | clast | catch | endtry<CR>', opts)

-- Cycle through buffers
vim.keymap.set('n', ']b', '<cmd>try | bnext | catch | bfirst | catch | endtry<CR>', opts)
vim.keymap.set('n', '[b', '<cmd>try | bprevious | catch | blast | catch | endtry<CR>', opts)

-- Create/delete buffer
vim.keymap.set('n', '<leader>x', '<cmd>enew | bd #<CR>', opts)
vim.keymap.set('n', '<leader>nb', '<cmd>enew<CR>', opts)

-- Close current split
vim.keymap.set('n', '<C-w>x', '<cmd>close<CR>', opts)
