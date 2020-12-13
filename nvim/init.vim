" Plugins
call plug#begin('~/local/share/nvim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdcommenter'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'sheerun/vim-polyglot'
" themes
Plug 'lifepillar/vim-solarized8'
Plug 'bluz71/vim-nightfly-guicolors'
Plug 'sonph/onehalf', {'rtp': 'vim/'}
Plug 'arcticicestudio/nord-vim'
Plug 'morhetz/gruvbox'
Plug 'ayu-theme/ayu-vim'
Plug 'chriskempson/base16-vim'
Plug 'drewtempelmeyer/palenight.vim'
call plug#end()

" General Settings
set relativenumber number
set exrc
set secure
set cmdheight=1
set signcolumn=yes
set clipboard+=unnamedplus
set splitbelow
set splitright
set scrolloff=2
set switchbuf=usetab,newtab
au BufNewFile,BufRead * nested tab sball
:autocmd VimResized * wincmd =

" file specific formats
set smartindent
set expandtab
set shiftwidth=4
set softtabstop=4
set shiftwidth=4
set tabstop=4
set linebreak

au BufNewFile,BufRead *.h,*.c set
    \ filetype=c
    \ shiftwidth=2
    \ softtabstop=2

au BufNewFile,BufRead *.go,make set
    \ noexpandtab
	\ shiftwidth=2
	\ tabstop=2

" Keybindings
imap jk <Esc>
nnoremap <A-r> :tabo<CR>:tab ball<CR>
nnoremap <C-j> :tabp<CR>
nnoremap <C-k> :tabn<CR>
nnoremap <C-l> :+tabmove<CR>
nnoremap <C-h> :-tabmove<CR>
nnoremap <C-w> :bd<CR>
nnoremap <C-q> :q<CR>
nnoremap <C-p> :Files<CR>
nnoremap <C-f> :Rg<CR>
nnoremap <C-b> :Buffers<CR>
nnoremap <C-t> :te<CR>i
tmap jk <C-\><C-n>
nnoremap gd <Plug>(coc-definition)
nnoremap gy <Plug>(coc-type-definition)
nnoremap gi <Plug>(coc-implementation)
nnoremap gr <Plug>(coc-references)
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Themes
set background=dark
set termguicolors
let ayucolor="mirage"
" colorscheme ayu
" colorscheme base16-atlas
" colorscheme base16-tomorrow-night
" colorscheme base16-phd
colorscheme base16-irblack
" colorscheme nord
" colorscheme solarized8

" Status-line
function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction
set statusline= " Left side
set statusline+=%#PmenuSel#
set statusline+=%{StatuslineGit()}
set statusline+=%#LineNr#
set statusline+=\ %f
set statusline+=%= " Right side
set statusline+=%y
set statusline+=\ L:%l/%L
set statusline+=\ C:%c

" Comments
let g:NERDSpaceDelims = 1
nmap <C-_> <Plug>NERDCommenterToggle
imap <C-_> <esc><Plug>NERDCommenterToggle
vmap <C-_> <Plug>NERDCommenterToggle<CR>gv

" FZF
let g:fzf_preview_window = 'right:60%'

" Coc
let g:coc_global_extensions = [
  \ 'coc-git',
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-prettier',
  \ 'coc-json',
  \ 'coc-python',
  \ 'coc-clangd',
  \ 'coc-tsserver',
  \ 'coc-rls',
  \ 'coc-vimtex',
  \ 'coc-tabnine',
  \ 'coc-explorer',
  \ 'coc-go',
  \ ]

set updatetime=300
autocmd CursorHold * silent call CocActionAsync('highlight')

" Help with coc
set hidden
set nobackup
set nowritebackup
set shortmess+=c
