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

-- Make current buffer executable
vim.keymap.set('n', '<leader>x', function()
  local name = vim.api.nvim_buf_get_name(0)
  local first_line = vim.api.nvim_buf_get_lines(0, 0, 1, false)[1]
  local function add_shebang_line(cmd)
    vim.api.nvim_buf_set_lines(0, 0, 0, false, { "#!" .. cmd })
  end
  if not first_line:find('^#!') then
    if name:find('.py$') then
      add_shebang_line("/bin/env python3")
    elseif name:find('.sh$') then
      add_shebang_line("/bin/sh")
    else
      vim.notify("Unrecognized script filetype, shebang line not added")
    end
  end
  vim.fn.system({ "chmod", "+x", name })
end, { desc = "Make current buffer executable", silent = true })
-- "<cmd>:!chmod u+x %<CR>", )
