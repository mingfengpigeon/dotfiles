filetype plugin on

set number
" set relativenumber
" set cursorline cursorcolumn
set nowrap
set autoindent expandtab tabstop=4 shiftwidth=4
set nobackup nowritebackup

call plug#begin()
Plug 'morhetz/gruvbox'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdtree'
Plug 'preservim/nerdcommenter'
Plug 'Yggdroot/indentLine'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-autoformat/vim-autoformat'
call plug#end()

let g:NERDSpaceDelims = 1
let g:NERDCustomDelimiters = {'python': {'left': '#'}}
let g:NERDCommentEmptyLines = 1
let g:NERDToggleCheckAllLines = 1

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = 'gruvbox'

autocmd vimenter * ++nested colorscheme gruvbox

