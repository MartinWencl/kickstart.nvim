-- https://github.com/mrcjkb/haskell-tools.nvim
return {
  'mrcjkb/haskell-tools.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  version = '^2', -- Recommended
  ft = { 'haskell', 'lhaskell', 'cabal', 'cabalproject' },
}
