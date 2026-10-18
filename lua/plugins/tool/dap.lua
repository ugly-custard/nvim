local full = require("config.profile").full

local function dap(fn)
  return function()
    require("dap")[fn]()
  end
end

-- js-debug-adapter has no mason-nvim-dap mapping, so its adapter and launch configs are set
-- here. A project's .vscode/launch.json is picked up by nvim-dap as well.
local function setup_js(d)
  d.adapters["pwa-node"] = {
    type = "server",
    host = "localhost",
    port = "${port}",
    executable = { command = "js-debug-adapter", args = { "${port}" } },
  }
  for _, ft in ipairs({ "javascript", "typescript", "javascriptreact", "typescriptreact" }) do
    d.configurations[ft] = {
      { type = "pwa-node", request = "launch", name = "Launch file", program = "${file}", cwd = "${workspaceFolder}" },
      {
        type = "pwa-node",
        request = "attach",
        name = "Attach to process",
        processId = require("dap.utils").pick_process,
        cwd = "${workspaceFolder}",
      },
    }
  end
end

return {
  "mfussenegger/nvim-dap",
  enabled = full,
  dependencies = {
    -- 1.x is the stable series its README pins.
    { "igorlfs/nvim-dap-view", version = "1.*" },
    "mason-org/mason.nvim",
    "jay-babu/mason-nvim-dap.nvim",
  },
  keys = {
    { "<F5>", dap("continue"), desc = "Debug: start/continue" },
    { "<F4>", dap("terminate"), desc = "Debug: stop" },
    { "<F1>", dap("step_into"), desc = "Debug: step into" },
    { "<F2>", dap("step_over"), desc = "Debug: step over" },
    { "<F3>", dap("step_out"), desc = "Debug: step out" },
    { "<F7>", "<cmd>DapViewToggle<CR>", desc = "Debug: toggle view" },
    { "<leader>b", dap("toggle_breakpoint"), desc = "Debug: toggle breakpoint" },
    {
      "<leader>B",
      function()
        require("dap").set_breakpoint(vim.fn.input("Condition: "))
      end,
      desc = "Debug: conditional breakpoint",
    },
  },
  config = function()
    local d = require("dap")

    -- Names are mason-nvim-dap sources: debugpy, delve, js-debug-adapter.
    require("mason-nvim-dap").setup({ ensure_installed = { "python", "delve", "js" }, handlers = {} })
    setup_js(d)

    require("dap-view").setup({
      auto_toggle = true,
      virtual_text = { enabled = true },
    })

    local signs = {
      DapBreakpoint = { "", "DiagnosticError" },
      DapBreakpointCondition = { "", "DiagnosticWarn" },
      DapLogPoint = { "", "DiagnosticInfo" },
      DapBreakpointRejected = { "", "DiagnosticError" },
      DapStopped = { "", "DiagnosticOk" },
    }
    for name, s in pairs(signs) do
      vim.fn.sign_define(
        name,
        { text = s[1], texthl = s[2], linehl = name == "DapStopped" and "Visual" or "", numhl = "" }
      )
    end
  end,
}
