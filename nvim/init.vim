" Plugins
let g:polyglot_disabled = ['ftdetect', 'c', 'c++', 'python' ]
let g:lsp_cxx_hl_use_text_props = 1
let g:python_highlight_all = 1
let g:doom_one_terminal_colors = 1
call plug#begin('~/local/share/nvim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdcommenter'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'sheerun/vim-polyglot'
Plug 'jnurmine/Zenburn'
" highlighting
Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'vim-python/python-syntax'
" themes
Plug 'lifepillar/vim-solarized8'
Plug 'bluz71/vim-nightfly-guicolors'
Plug 'sonph/onehalf', {'rtp': 'vim/'}
Plug 'arcticicestudio/nord-vim'
Plug 'morhetz/gruvbox'
Plug 'ayu-theme/ayu-vim'
Plug 'chriskempson/base16-vim'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'dracula/vim', {'as':'dracula'}
Plug 'romgrk/doom-one.vim'
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
set scrolloff=1
set mouse=a
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

au BufNewFile,BufRead *.vert,*.frag set
    \ filetype=glsl

au BufNewFile,BufRead .clang-* set
    \ filetype=yaml

" Keybindings
imap jk <Esc>
tmap jk <C-\><C-n>
nmap <C-p> :Files<CR>
nmap <C-b> :Buffers<CR>
nmap gd <Plug>(coc-definition)
nmap gy <Plug>(coc-type-definition)
nmap gi <Plug>(coc-implementation)
nmap gr <Plug>(coc-references)
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
" colorscheme base16-dracula
" colorscheme base16-tomorrow-night
" colorscheme base16-phd
" colorscheme base16-irblack
" colorscheme nord
" colorscheme solarized8
colorscheme doom-one
" colorscheme gruvbox

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
