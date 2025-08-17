---
-- Config lsp
---
local lsp_zero = require("lsp-zero")

local lsp_attach = function(_, bufnr)
  local opts = { buffer = bufnr }

  vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
  vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
  vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
  vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
  vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
  vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
  vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
  vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
  vim.keymap.set({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
  vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
end

lsp_zero.extend_lspconfig({
  sign_text = true,
  lsp_attach = lsp_attach,
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
})

-- ---------------------
-- Install lsp servers
-- ---------------------
require("mason").setup({})
require("mason-lspconfig").setup({
  automatic_enable = {
    exclude = {
      "mdx_analyzer",
    },
  },
  ensure_installed = {
    "lua_ls",
    "intelephense",
    "docker_compose_language_service",
    "dockerls",
    "pyright",
    "vtsls",
    "mdx_analyzer",
    "emmet_language_server",
  },
})

-- -------------------
-- CONFIG LSP
-- -------------------

-- MDX
local npm = require("util.npm")
local mdx_plugin = "@mdx-js/typescript-plugin"
npm.ensure_npm_binary(mdx_plugin, {
  on_success = function()
    local mdx_lsp_path = npm.get_package_path() .. "/" .. mdx_plugin
    require("lspconfig").vtsls.setup({
      settings = {
        vtsls = {
          autoUseWorkspaceTsdk = true,
          tsserver = {
            globalPlugins = {
              {
                name = "@mdx-js/typescript-plugin",
                enableForWorkspaceTypeScriptVersions = true,
                location = mdx_lsp_path,
                languages = {
                  "mdx",
                },
              },
            },
          },
        },
      },
      filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
        "mdx",
      },
    })
  end,
})

-- EMMET
-- add md and mdx to filetypes
vim.lsp.config("emmet_language_server", {
  filetypes = {
    "astro",
    "css",
    "eruby",
    "html",
    "htmlangular",
    "htmldjango",
    "javascriptreact",
    "less",
    "pug",
    "sass",
    "scss",
    "svelte",
    "templ",
    "typescriptreact",
    "vue",
    "markdown",
    "mdx",
  },
})
