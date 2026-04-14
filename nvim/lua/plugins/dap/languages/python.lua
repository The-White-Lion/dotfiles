return {
  mason = "python",
  adapter = {
    type = "executable",
    command = "python3",
    args = { "-m", "debugpy.adapter" },
  },
  filetypes = { "python" },
  configurations = {
    {
      name = "Launch current file",
      request = "launch",
      program = "${file}",
      cwd = "${workspaceFolder}",
      pythonPath = function()
        local cwd = vim.fn.getcwd()

        if vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
          return cwd .. "/.venv/bin/python"
        end
        if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
          return cwd .. "/venv/bin/python"
        end

        return "python3"
      end,
    },
    {
      name = "Attach :5678",
      request = "attach",
      connect = {
        host = "127.0.0.1",
        port = 5678,
      },
    },
  },
}
