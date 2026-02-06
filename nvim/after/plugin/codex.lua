local codex = require('codex')

codex.setup({
  keymaps = {
    toggle = nil,
    quit = { '<C-q>', '<C-c>', 'ZZ' },
    term_normal = '<Esc>',
    history_list = '<leader>ch',
    last = '<leader>clh',
    panel_toggle = '<leader>clh',
  },
  border = 'rounded',
  width = 0.8,
  height = 0.8,
  panel = false,
  use_buffer = false,
  render_markdown = false, -- must be false for interactive terminal
  autoinstall = true,
  panel_width = 0.2,

  open_new_session_in_panel_on_enter = true, -- move to panel after first Enter

  history = {
    ui = 'telescope',
    open_last_on_toggle = true,
    open_session_in_panel = true,
  },
})


vim.keymap.set({ 'n', 't' }, '<leader>cc', function()
  codex.toggle()
end, { desc = 'Codex: Toggle' })
