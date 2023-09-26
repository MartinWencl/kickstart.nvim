return {
  'lukas-reineke/lsp-format.nvim',
  config = function()
    -- Prettier setup
    -- https://prettier.io/docs/en/
    local prettier = {
      formatCommand = [[prettier --stdin-filepath ${INPUT} ${--tab-width:tab_width}]],
      formatStdin = true,
    }

    -- CSharpier setup
    -- https://csharpier.com/docs/About
    local csharpier = {
      formatCommand = [[dotnet-csharpier . ]],
      formatStdin = false,
    }

    require("lsp-format").setup({
      typescript = {
        tab_width = function()
          return vim.opt.shiftwidth:get()
        end,
      },
      yaml = { tab_width = 2 },
    })

    require("lspconfig").efm.setup({
      on_attach = require("lsp-format").on_attach,
      init_options = { documentFormatting = true },
      settings = {
        languages = {
          typescript = { prettier },
          yaml = { prettier },
          csharp = { csharpier }
        },
      },
    })

    local on_attach = function(client, bufnr)
      require("lsp-format").on_attach(client, bufnr)
      -- ... custom code ...
    end
    require("lspconfig").gopls.setup { on_attach = on_attach }
  end,
}
