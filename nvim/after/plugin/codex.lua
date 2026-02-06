local codex = require('codex')

codex.setup({
  keymaps = {
    toggle = nil,
    quit = { '<C-q>', '<C-c>', 'ZZ' },
    term_normal = '<Esc>',
    history_list = '<leader>ch',
    last = '<leader>clh', 
  },
  border = 'rounded',
  width = 0.8,
  height = 0.8,
  panel = false,
  use_buffer = false,
  autoinstall = true,
  panel_width = 0.2,
  render_markdown = true,
  history = {
    ui = 'telescope',
    open_last_on_toggle = true,
    open_session_in_panel = true,
  },
})

vim.keymap.set({ 'n', 't' }, '<leader>cc', function()
  codex.toggle()
end, { desc = 'Codex: Toggle' })
