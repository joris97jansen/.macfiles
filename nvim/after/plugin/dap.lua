local dap = require('dap')
local dapui = require('dapui')

local js_based_laguages = {
    "typescript",
    "javascript",
}

require("dap-vscode-js").setup({
  -- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
  -- debugger_path = "(runtimedir)/site/pack/packer/opt/vscode-js-debug", -- Path to vscode-js-debug installation.
  -- debugger_cmd = { "js-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
  adapters = {
      'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost',
      node = "pwa-node",
  }, -- which adapters to register in nvim-dap
  -- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
  -- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
  -- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
})

dap.adapters.node = dap.adapters['pwa-node']

for _, language in ipairs(js_based_laguages) do
  require("dap").configurations[language] = {
    {
        type = "pwa-node",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        cwd = "${workspaceFolder}",
      },
      {
        type = "pwa-node",
        request = "attach",
        name = "Attach",
        processId = require'dap.utils'.pick_process,
        cwd = "${workspaceFolder}",
      },
  }
end

function ContinueDap()
    if vim.fn.filereadable(".vscode/launch.json") then
        local dap_vscode = require("dap.ext.vscode")
        dap_vscode.load_launchjs(nil, {
            ["pwa-node"] = js_based_laguages,
            ["node"] = js_based_laguages,
            ["chrome"] = js_based_laguages,
            ["pwa-chrome"] = js_based_laguages,
        })
    end
    require("dap").continue()
end

-- Setup nvim-dap-ui
dapui.setup()

-- Automatically open and close the UI when debugging starts/ends
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

require("nvim-dap-virtual-text").setup()

-- Optional: Keybindings for nvim-dap
vim.api.nvim_set_keymap('n', '<Leader>dc', ':lua ContinueDap()<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<Leader>c', ContinueDap, {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>dso', '<Cmd>lua require"dap".step_over()<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>dsi', '<Cmd>lua require"dap".step_into()<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>dsoo', '<Cmd>lua require"dap".step_out()<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>db', '<Cmd>lua require"dap".toggle_breakpoint()<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>dB', '<Cmd>lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>', {noremap = true})
-- TODO: Find solution for there two keymaps
vim.api.nvim_set_keymap('n', '<Leader>dz', ':lua require("dapui").close()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Leader>dd', ':lua require"dap".disconnect({ terminateDebuggee = true })<CR>', {noremap = true, silent = true})

