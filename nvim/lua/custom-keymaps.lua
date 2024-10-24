local map = vim.keymap.set
local kmap = vim.api.nvim_set_keymap

local opts = { noremap = true }

map("n", ";", ":", opts)

-- Search and replace
kmap("v", "<C-r>", ":SearchReplaceSingleBufferVisualSelection<CR>", opts)
kmap("v", "<C-s>", ":SearchReplaceWithinVisualSelection<CR>", opts)
kmap("v", "<C-b>", ":SearchReplaceWithinVisualSelectionCWord<CR>", opts)

kmap("n", "<leader>rs", ":SearchReplaceSingleBufferSelections<CR>", opts)
kmap("n", "<leader>ro", ":SearchReplaceSingleBufferOpen<CR>", opts)
kmap("n", "<leader>rw", ":SearchReplaceSingleBufferCWord<CR>", opts)
kmap("n", "<leader>rW", ":SearchReplaceSingleBufferCWORD<CR>", opts)
kmap("n", "<leader>re", ":SearchReplaceSingleBufferCExpr<CR>", opts)
kmap("n", "<leader>rf", ":SearchReplaceSingleBufferCFile<CR>", opts)

kmap("n", "<leader>rbs", ":SearchReplaceMultiBufferSelections<CR>", opts)
kmap("n", "<leader>rbo", ":SearchReplaceMultiBufferOpen<CR>", opts)
kmap("n", "<leader>rbw", ":SearchReplaceMultiBufferCWord<CR>", opts)
kmap("n", "<leader>rbW", ":SearchReplaceMultiBufferCWORD<CR>", opts)
kmap("n", "<leader>rbe", ":SearchReplaceMultiBufferCExpr<CR>", opts)
kmap("n", "<leader>rbf", ":SearchReplaceMultiBufferCFile<CR>", opts)

-- Show the effects of a search / replace in a live preview window
vim.o.inccommand = "split"

-- Select and move
map("n", "<c-s-down>", ":m +1<CR>", opts)
map("n", "<c-s-up>", ":m -2<CR>", opts)
map("x", "<c-s-down>", ":m '>+1<CR>gv-gv", opts)
map("x", "<c-s-up>", ":m '<-2<CR>gv-gv", opts)
map("n", "<S-Down>", "vj", opts)
map("v", "<S-Down>", "j", opts)
map("n", "<S-Up>", "vk", opts)
map("v", "<S-Up>", "k", opts)
map("n", "<leader>dd", "yyp", opts)
map("n", "<leader>,", "za", opts)
map("n", "<leader>.", "zR", opts)

-- Debugging
map('n', '<F5>', function() require('dap').continue() end)
map('n', '<F10>', function() require('dap').step_over() end)
map('n', '<F11>', function() require('dap').step_into() end)
map('n', '<F12>', function() require('dap').step_out() end)
map('n', '<Leader>b', function() require('dap').toggle_breakpoint() end)
map('n', '<Leader>B', function() require('dap').set_breakpoint() end)
map('n', '<Leader>lp',
  function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
map('n', '<Leader>dr', function() require('dap').repl.open() end)
map('n', '<Leader>dl', function() require('dap').run_last() end)
map({ 'n', 'v' }, '<Leader>dh', function()
  require('dap.ui.widgets').hover()
end)
map({ 'n', 'v' }, '<Leader>dp', function()
  require('dap.ui.widgets').preview()
end)
map('n', '<Leader>df', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.frames)
end)
map('n', '<Leader>ds', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.scopes)
end)

kmap("n", "<leader>dt", ":DapUiToggle<CR>", opts)
kmap("n", "<leader>db", ":DapToggleBreakpoint<CR>", opts)
kmap("n", "<leader>dc", ":DapContinue<CR>", opts)
kmap("n", "<leader>dr", ":lua require('dapui').open({reset = true})<CR>", opts)
kmap("n", "<leader>ht", ":lua require('harpoon.ui').toggle_quick_menu()<CR>", opts)

-- Go
map("n", "<leader>rr", ":GoRename<CR>", opts)
map("n", "<leader><CR>t", ":GoFillStruct<CR>", opts)
map("n", "<leader><CR>s", ":GoFillSwitch<CR>", opts)
map("n", "<leader><CR>p", ":GoFillPlurals<CR>", opts)

-- LazyGit
map("n", "<leader>gg", ":LazyGit<CR>", opts)
