local codex = require('codex')

codex.setup({
  keymaps = {
    toggle = nil, -- disable internal default mapping to avoid conflicts
    quit = '<C-q>',
  },
  border = 'rounded',
  width = 0.8,
  height = 0.8,
  panel = false,
  use_buffer = false,
  autoinstall = true,
  history = {
    ui = 'telescope'
  }
})

vim.keymap.set({ 'n', 't' }, '<leader>cc', function()
  codex.toggle()
end, { desc = 'Codex: Toggle' })
