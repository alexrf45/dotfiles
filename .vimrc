call plug#begin()
Plug 'sainnhe/gruvbox-material'
Plug 'tpope/vim-sensible'
Plug 'preservim/nerdtree'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

call plug#end()

noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

let mapleader = " "

map <leader>r :call ToggleLineNumber()<CR>

nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <leader>e :NERDTree<CR>
nnoremap <leader>t :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
nnoremap <leader>f :History:<CR>
nnoremap <leader>s :w<cr>
nnoremap <leader>sq :wq!<cr>
nnoremap <leader>q :qa!<cr>

let NERDTreeShowHidden=1  "  Always show dot files
let NERDTreeQuitOnOpen=1

colorscheme gruvbox-material
map  <Leader>n  :NERDTreeFind<CR>
