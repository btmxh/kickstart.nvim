-- Remap : as ;
-- This makes it easier to save (;w) a file
vim.keymap.set('n', ';', ':')
vim.keymap.set('n', ';;', ';')

-- Split keybinds
vim.keymap.set('n', '<leader>ph', '<cmd>split<CR>', { desc = 'Open horizontal split' })
vim.keymap.set('n', '<leader>pv', '<cmd>vsplit<CR>', { desc = 'Open vertical split' })
vim.keymap.set('n', '<leader>pH', '<cmd>split<CR><cmd>term<CR>', { desc = 'Open horizontal terminal split' })
vim.keymap.set('n', '<leader>pV', '<cmd>vsplit<CR><cmd>term<CR>', { desc = 'Open vertical terminal split' })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })
