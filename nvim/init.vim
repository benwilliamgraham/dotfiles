" Plugins
call plug#begin('~/local/share/nvim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdcommenter'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'sheerun/vim-polyglot'
" themes
Plug 'lifepillar/vim-solarized8'
Plug 'bluz71/vim-nightfly-guicolors'
Plug 'sonph/onehalf', {'rtp': 'vim/'}
Plug 'arcticicestudio/nord-vim'
Plug 'morhetz/gruvbox'
call plug#end()

" General Settings
set relativenumber number
set exrc
set secure
set cmdheight=1
set signcolumn=yes

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
    \ shiftwidth=2

au BufNewFile,BufRead *.go set
    \ noexpandtab

" Keybindings
imap jk <Esc>
nmap <C-k> :bn<CR>
nmap <C-j> :bp<CR>
nmap <C-q> :bd<CR>
nmap <C-p> :FZF<CR>
nmap <C-e> :CocCommand explorer<CR>
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

" Launchers
nmap <M-t> :silent :! kitty --detach -d $(pwd) <CR>
nmap <M-e> :silent :! kitty --detach -d $(pwd) nvim <CR>

" Themes
set background=dark
set termguicolors
colorscheme solarized8

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
  \ ]

set updatetime=300
autocmd CursorHold * silent call CocActionAsync('highlight')

" Help with coc
set hidden
set nobackup
set nowritebackup
set shortmess+=c
