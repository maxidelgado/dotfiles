return {
    'Exafunction/codeium.vim',
    event = "InsertEnter",
    config = function()
      local map = vim.api.nvim_set_keymap
      map('i', '<C-e>', function() return vim.fn['codeium#Accept']() end, { expr = true, silent = true })

      map('i', '<c-n>', function() return vim.fn['codeium#CycleCompletions'](1) end,
        { expr = true, silent = true })
      map('i', '<c-p>', function() return vim.fn['codeium#CycleCompletions'](-1) end,
        { expr = true, silent = true })
      map('i', '<c-x>', function() return vim.fn['codeium#Clear']() end, { expr = true, silent = true })
    end
  }
