-- https://github.com/azabiong/vim-highlighter?tab=readme-ov-file#configuration-examples
return {
  'azabiong/vim-highlighter',
  config = function()
    vim.cmd([[
  " default key mappings
  " let HiSet   = 'f<CR>'
  " let HiErase = 'f<BS>'
  " let HiClear = 'f<C-L>'
  " let HiFind  = 'f<Tab>'
  " let HiSetSL = 't<CR>'

  " jump key mappings
  nn <CR>     <Cmd>Hi><CR>
  nn g<CR>    <Cmd>Hi<<CR>
  nn [<CR>    <Cmd>Hi{<CR>
  nn ]<CR>    <Cmd>Hi}<CR>

  " find key mappings
  nn -        <Cmd>Hi/next<CR>
  nn _        <Cmd>Hi/previous<CR>
  nn f<Left>  <Cmd>Hi/older<CR>
  nn f<Right> <Cmd>Hi/newer<CR>

  " directory to store highlight files
  " let HiKeywords = '~/.vim/after/vim-highlighter'
]])
  end
}
