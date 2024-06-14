local diagnostics = require('toggle_lsp_diagnostics')

diagnostics.init{ underline = true }

vim.keymap.set('n', '<C-d>', diagnostics.toggle_virtual_text)
