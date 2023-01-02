local present, mason = pcall(require, "mason")
if not present then
  return
end
local status2, lspconfig = pcall(require, "mason-lspconfig")
if (not status2) then return end

vim.api.nvim_create_augroup("_mason", { clear = true })
vim.api.nvim_create_autocmd("Filetype", {
  pattern = "mason",
  callback = function()
  end,
  group = "_mason",
})

local options = {
  ensure_installed = { "lua-language-server", "typescript-language-server", "css-lsp", "emmet-lsp", "eslint-lsp",
    "eslint_d", "prettierd", "prettier", "json-lsp", "tailwindcss-language-server" }, -- not an option from mason.nvim

  -- PATH = 'C:/Users/final/AppData/Local/nvim-data/lsp_servers/tsserver',

  ui = {
    icons = {
      package_pending = " ",
      package_installed = " ",
      package_uninstalled = " ﮊ",
    },

    keymaps = {
      toggle_server_expand = "<CR>",
      install_server = "i",
      update_server = "u",
      check_server_version = "c",
      update_all_servers = "U",
      check_outdated_servers = "C",
      uninstall_server = "X",
      cancel_installation = "<C-c>",
    },
  },

  max_concurrent_installers = 10,
}

-- options = require("core.utils").load_override(options, "williamboman/mason.nvim")

vim.api.nvim_create_user_command("MasonInstallAll", function()
  vim.cmd("MasonInstall " .. table.concat(options.ensure_installed, " "))
end, {})

mason.setup(options)
lspconfig.setup {
  automatic_installation = true
}
