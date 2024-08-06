
" Plugins
" -------------------------------------------

call plug#begin('~/.vim/plugged')

Plug 'junegunn/seoul256.vim'                            " color scheme
Plug 'sainnhe/everforest'                               " color scheme
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'                                 " fuzzy search
Plug 'tpope/vim-vinegar'                                " file browser
Plug 'tpope/vim-fugitive'                               " git integration
Plug 'vim-scripts/vim-auto-save'                        " auto save
Plug 'tpope/vim-commentary'                             " comment bindings
Plug 'tpope/vim-surround'                               " change brackets, parents, quotes, html tags
Plug 'tpope/vim-repeat'                                 " repeat plugin actions
Plug 'farmergreg/vim-lastplace'                         " return to last positon in file when opened
Plug 'valloric/MatchTagAlways'                          " highlight matching html tags
Plug 'neoclide/coc.nvim', {'branch': 'release'}         " lsp server
Plug 'SirVer/ultisnips'                                 " snippet manager
Plug 'maralla/validator.vim'                            " validate css and python

call plug#end()


" Appearance
" -------------------------------------------

" seoul256 light
"   Range:   252 (darkest) ~ 256 (lightest)
"   Default: 253
let g:seoul256_background = 254
colorscheme seoul256-light


" status line
hi StatusLine ctermbg=2 ctermfg=253
hi StatusLineNC ctermbg=2 ctermfg=253
set statusline=
set statusline+=\ %f
set statusline+=%=
set statusline+=%{fugitive#statusline()}
set statusline+=%=
set statusline+=\ %l:%c

" popup menu
hi Pmenu ctermbg=253 ctermfg=5
hi PmenuSel ctermbg=5 ctermfg=253


" Options
" -------------------------------------------

filetype plugin on

" paste into vim under tmux without a cascading
" series of indentations
if &term =~ "screen"
    let &t_BE = "\e[?2004h"
    let &t_BD = "\e[?2004l"
    exec "set t_PS=\e[200~"
    exec "set t_PE=\e[201~"
endif

" enable resizing splits in tmux
if has('mouse_sgr')
    set ttymouse=sgr
else
    set ttymouse=xterm2
end

" highlight current line in insert mode
augroup cursor
    autocmd InsertEnter * set cursorline!
    autocmd InsertLeave * set cursorline!
augroup end

let g:auto_save = 1                     " autosave
let g:auto_save_in_insert_mode = 0      " only autosave after leaving insert
set encoding=UTF-8                      " sets encoding
set laststatus=2                        " always show status line
set cursorline                          " always highlight cursor line
set ignorecase                          " ignore case
set smartcase                           " except when an upper case character is used
set incsearch                           " start searching as it is typed
set hlsearch                            " highlight search patterns
set mouse=a                             " enable mouse usage
set noswapfile                          " no swap files
set splitright                          " open splits on the right
set splitbelow                          " open splits on bottom
set foldmethod=indent                   " fold behavior
set foldlevel=99                        " folds closed by default
set expandtab                           " inserts spaces when tab key is pressed
set tabstop=4                           " sets for spaces for tabs
set softtabstop=4                       " number of spaces removed by backspace key
set shiftwidth=4                        " sets number of spaces to insert/remove using indentation commands
set autoindent                          " autoindent
set shiftround                          " use multiple of shiftwidth when indenting with '<' and '>'
set backspace=indent,eol,start          " backspace
set ttimeoutlen=50                      " elminiate delay in escaping out of fzf
set undofile                            " persistent undo history
set undodir=~/.vim/undodir              " undo history file location
set viminfofile=~/.vim/viminfo          " move viminfo to vim folder
set signcolumn=number                   " prevent signs from opening another gutter
set number                              " always show line numbers
set relativenumber                      " use relative line numbers
set nowrap                              " wrap lines
set linebreak                           " break at whitespace not words
set display=lastline                    " show partial lines at the bottom of the screen
set scrolloff=5                         " keep at least 5 lines visible above/below cursor

"some settings for coc.vim
set nobackup
set nowritebackup
set updatetime=300

" auto remove trailing whitespace
augroup whitespace
    autocmd BufWritePre * :%s/\s\+$//e
augroup end

" tabs for css and html
augroup css
    autocmd BufRead,BufNewFile *.html,*.css setlocal tabstop=2 shiftwidth=2 softtabstop=2
augroup end

" html mode
augroup html
    autocmd BufRead,BufNewFile *.html setlocal filetype=htmldjango foldmethod=indent
augroup end

" exclude various files from vimgrep scope
set wildignore+=tags,.git/**
set wildignore+=**/migrations/**
set wildignore+=**/__pycache__/**
set wildignore+=static/bootstrap-3.3.7/**,static/images/**
set wildignore+=static/admin/**


" Keymaps
" -------------------------------------------

" leader
let mapleader = ' '

" escaping
inoremap jj <esc>
inoremap jk <esc>

" exit vim
nnoremap <C-d> :q!<cr>
nnoremap QQ :q!<cr>

" close buffer
nnoremap <S-k> :bd<cr>

" window navigation
nnoremap <leader>v :vsp<cr>
nnoremap <tab> <C-w>w
nnoremap <S-tab> <C-w>W

" clear highlighted search text until next explicit search or n/N
" <silent> - so as to not print :noh on last line when invoked
" nnoremap <silent> <leader>h :noh<cr>
nnoremap <silent> <esc> :noh<cr>

" fzf searches
nnoremap <leader>f :Files<cr>
nnoremap <nowait><leader>b :Buffers<cr>
nnoremap <leader>r :Rg<cr>

" invoke fugitive
nnoremap <leader>g :G<cr>]]

" vimgrep I like better than FZF ripgrep
nnoremap <C-f> :vimgrep '' **/*<left><left><left><left><left><left>

" quickfix window
nnoremap <leader>c :copen 10<cr>
nnoremap [q :cprevious<cr>zz
nnoremap ]q :cnext<cr>zz

" code folding
nnoremap , za

" search for word under cursor, including first word
nnoremap * *N

" center search results as they come into focus
nnoremap n nzz
nnoremap N Nzz

" search for visually selected text
vnoremap * y/\V<C-R>=escape(@",'/\')<cr><cr>N

" shortcuts to edit configuation files
nnoremap <leader>ev :e $MYVIMRC<cr>
nnoremap <leader>so :so %<cr>
nnoremap <leader>ed :e ~/.dotfiles<cr>
nnoremap <leader>es :e ~/.vim/UltiSnips<cr>

" save as root
command W :execute ':silent w !sudo tee % > /dev/null' | :edit!

" auto close pairs when on separate lines
inoremap {<cr> {<cr>}<esc>O
inoremap [<cr> [<cr>]<esc>O
inoremap (<cr> (<cr>)<esc>O


" -------------------------------------------
" Fugitive
" -------------------------------------------

" nnoremap <space>g <Cmd>vertical Git \| vertical resize 80<CR>
augroup FugitiveToggle
  autocmd!
  autocmd Filetype fugitive nnoremap <buffer> <space>g <C-w>q
augroup END


" -------------------------------------------
" Coc
" -------------------------------------------

" Use tab for trigger completion with characters ahead and navigate
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)


" -------------------------------------------
" UltiSnips
" -------------------------------------------

" Trigger configuration. You need to change this to something other than <tab> if you use one of the following:
" - https://github.com/Valloric/YouCompleteMe
" - https://github.com/nvim-lua/completion-nvim
let g:UltiSnipsExpandTrigger="<c-b>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
