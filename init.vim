" -- vim-plug init --
call plug#begin('~/.vim/plugged')
  Plug 'morhetz/gruvbox'
  Plug 'jiangmiao/auto-pairs'
  Plug 'preservim/nerdcommenter'
  Plug 'norcalli/nvim-colorizer.lua'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'preservim/nerdtree'
  Plug 'ryanoasis/vim-devicons'
  Plug 'honza/vim-snippets'
  Plug 'SirVer/ultisnips'
  Plug 'airblade/vim-gitgutter'


  Plug 'vim-pandoc/vim-pandoc'
  Plug 'vim-pandoc/vim-pandoc-syntax'
  Plug 'junegunn/limelight.vim'
  Plug 'junegunn/goyo.vim'
  Plug 'godlygeek/tabular'
  Plug 'plasticboy/vim-markdown'
  Plug 'iamcco/markdown-preview.nvim', {'do': 'cd app & yarn install' }
call plug#end()


" -- Enable filetype plugins
filetype plugin indent on

" -- General Settings --
set encoding=UTF-8
set nu rnu
set spell spelllang=en_us
set laststatus=2 cmdheight=1
syntax enable
set scrolloff=5
set backspace=indent,eol,start
set noshowmode
set updatetime=100

"set clipboard+=unnamedplus

let g:UltiSnipsExpandTrigger="<tab>"
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/snippets']
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/plugged/vim-snippets/UltiSnips']



" -- Key Remapping --
let mapleader = ' '
map <C-s> :source ~/.config/nvim/init.vim<CR>
nnoremap <Up> :resize +2<CR>
nnoremap <Down> :resize -2<CR>
nnoremap <Left> :vertical resize +2<CR>
nnoremap <Right> :vertical resize -2<CR>

xnoremap K :move '<-2<CR>gv-gv
xnoremap J :move '>+1<CR>gv-gv

nmap <C-_> <Plug>NERDCommenterToggle
vmap <C-_> <Plug>NERDCommenterToggle<CR>gv

nmap <leader>1 :bp<CR>
nmap <leader>2 :bn<CR>
" NERDTree
let NERDTreeQuitOnOpen=1
nmap <leader>f :NERDTreeToggle<CR>

" -- Themeing -
colorscheme gruvbox
let g:airline_theme='gruvbox'
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#framemode=':t'
if (has("termguicolors"))
    set termguicolors
endif

lua require 'colorizer'.setup()



" -- Commands --
autocmd BufWritePost *note-*.md silent !~/.scripts/buildnote.sh %:p
