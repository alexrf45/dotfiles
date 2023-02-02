set number                 " Sets line numbers
set autoindent             " Sets auto indentation
set tabstop=2              " Sets tabstop
set shiftwidth=2           " For proper indentation
set smarttab               " Affects how tab key presses are interpreted
set softtabstop=2          " Control how many columns Vim uses when you hit tab key
set mouse=a                " This lets you use your mouse
set wrap                   " Sets up line wrapping
set nobackup
set nowritebackup
set updatetime=300
set signcolumn=yes

call plug#begin()

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'itchyny/lightline.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.x' }
Plug 'preservim/nerdtree' |
           \ Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'jiangmiao/auto-pairs'
Plug 'EtiamNullam/deferred-clipboard.nvim'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }

call plug#end()

colorscheme tokyonight-night

let g:lightline = {'colorscheme': 'tokyonight'}

inoremap <silent><expr> <Tab>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh(

inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif





nnoremap <C-q> :q<CR>

nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>


