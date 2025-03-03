-- Indenting
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- Show linenumbers and highlight current line
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true

-- Helps to avoid jumping when lsp errors appears/disappears
vim.opt.signcolumn = 'yes'

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Minimal number of screen lines to keep above/below and left/right to the cursor.
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 10

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Sets how neovim will display certain whitespace characters in the editor.
vim.opt.list = true
vim.opt.listchars = { tab = '» ', space = '·', trail = '·', nbsp = '␣' }

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 500

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Limit completion items
vim.opt.pumheight = 12

-- Allow to source local files eg per project configs
vim.opt.exrc = true

-- Open vertical splits to the right, and horizontal below current window
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Disable inline diagnostic messages in favor of autoshown float diagnostics (configured in lsp)
vim.diagnostic.config { virtual_text = false }
