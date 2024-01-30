-- https://github.com/lukas-reineke/lsp-format.nvim
-- TODO: REWRITE
return {
  -- LSP Format
  'lukas-reineke/lsp-format.nvim',
  config = function()
    -- Prettier setup
    -- https://prettier.io/docs/en/
    -- TODO: Look for a general purpouse formatter to replace Prettier
    local prettier = {
      formatCommand = [[prettier --stdin-filepath ${INPUT} ${--tab-width:tab_width}]],
      formatStdin = true,
    }

    -- CSharpier setup
    -- https://csharpier.com/docs/About
    -- TODO: Change later for a local install instead of global
    local csharpier = {
      formatCommand = [[dotnet-csharpier . ]],
      formatStdin = false,
    }

    -- Fourmolu setup
    -- https://github.com/fourmolu/fourmolu
    -- this is the defaulth cabal install path
    local fourmolu = {
      formatCommand = [[/home/martinw/.cabal/bin/fourmolu -i . ]],
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
          csharp = { csharpier },
          haskell = { fourmolu },
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
