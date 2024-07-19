
" use '*' to search to desired section
" Options
" Keymaps
" Insertions

call plug#begin('~/.vim/plugged')

Plug 'junegunn/seoul256.vim'                    " color schemes
Plug 'sainnhe/everforest'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'                         " fuzzy search
Plug 'tpope/vim-vinegar'                        " file broser
Plug 'tpope/vim-fugitive'                       " git integration
Plug 'vim-scripts/vim-auto-save'                "  auto save
Plug 'tpope/vim-commentary'                     " comment bindings
Plug 'tpope/vim-surround'                       " change brackets, parents, quotes, html tags
Plug 'tpope/vim-repeat'                         " repeat plugin actions
Plug 'tpope/vim-abolish'                        " covert camel case to snake case etc.
Plug 'ludovicchabant/vim-gutentags'             " auto update tags file
Plug 'maralla/completor.vim'                    " better autocomplete, always on
Plug 'maralla/validator.vim'                    " code validation
Plug 'farmergreg/vim-lastplace'                 " return to last positon in file when opened
Plug 'valloric/MatchTagAlways'                  " highlight matching html tags
Plug 'AndrewRadev/splitjoin.vim'                " split single linees into multiple
Plug 'SirVer/ultisnips'                         " snippets
Plug 'kalekundert/vim-coiled-snake'             " python folding

call plug#end()


" Appearance
" -------------------------------------------

" seoul256 light
"   Range:   252 (darkest) ~ 256 (lightest)
"   Default: 253
let g:seoul256_background = 254
colorscheme seoul256-light

" everforest
" let &t_8f = '\<Esc>[38;2;%lu;%lu;%lum'
" let &t_8b = '\<Esc>[48;2;%lu;%lu;%lum'
" set termguicolors
" let g:everforest_background = 'medium'
" set background=dark
" colorscheme everforest

" status line
hi StatusLine ctermbg=2 ctermfg=253
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

" highlight current line in insert mode
augroup cursor
    autocmd InsertEnter * set cursorline!
    autocmd InsertLeave * set cursorline!
augroup end

" UltiSnips
let g:UltiSnipsExpandTrigger='<c-y>'
let g:UltiSnipsJumpForwardTrigger='<c-y>'
let g:UltiSnipsJumpBackwardTrigger='<c-z>'

" Completor
augroup markdown
    autocmd Filetype markdown let g:completor_auto_trigger = 0
augroup end
let g:completor_python_binary = '/usr/bin/python3'
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<cr>"

" Validator
let g:validator_python_checkers = ['flake8']
let g:validator_css_checkers = ['csslint']
let g:validator_json_checkers = ['jsonlint']
let g:validator_javascript_checkers = ['eslint']
let g:validator_vim_checkers = ['vint']

let g:auto_save = 1                     " autosave
let g:auto_save_in_insert_mode = 0      " only autosave after leaving insert
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

" enable resizing splits in tmux
if has('mouse_sgr')
    set ttymouse=sgr
else
    set ttymouse=xterm2
end

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
" nnoremap <C-d> :q!<cr>
" nnoremap <leader><space> :q!<cr>

" close buffer
nnoremap <S-k> :bd<cr>

" window navigation
nnoremap <leader>v :vsp<cr>
nnoremap <tab> <C-w>w
nnoremap <S-tab> <C-w>W

" clear highlighted search text until next explicit search or n/N
" <silent> - so as to not print :noh on last line when invoked
nnoremap <silent> <leader>h :noh<cr>

" fzf searches
nnoremap <leader>f :Files<cr>
nnoremap <nowait><leader>b :Buffers<cr>
nnoremap <leader>r :Rg<cr>
nnoremap <leader>t :Tags<cr>

" vimgrep I like better than FZF ripgrep
nnoremap <C-f> :vimgrep '' **/*<left><left><left><left><left><left>

" quickfix window
nnoremap <leader>c :copen 10<cr>
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

" shortcut to view log files
nnoremap <leader>l :e /var/log/gunicorn<cr>

" save as root
command W :execute ':silent w !sudo tee % > /dev/null' | :edit!

" auto close pairs when on separate lines
inoremap {<cr> {<cr>}<esc>O
inoremap [<cr> [<cr>]<esc>O
inoremap (<cr> (<cr>)<esc>O

" insert a breakpoint
nnoremap <leader>p oimport pudb; pu.db<esc>

" insert text
func Eatchar(pat)
    let c = nr2char(getchar(0))
    return (c =~ a:pat) ? '' : c
endfunc

" print
iab pr print()<left><c-r>=Eatchar('\s')<cr>

" pprint
iab ppr from pprint import pprint<cr>pprint()<left><c-r>=Eatchar('\s')<cr>

" dump django objects to browser
" iab dd import config.helpers as helpers<cr>return helpers.dump()<left><c-r>=Eatchar('\s')<cr>

" fugitive git bindings
nnoremap <leader>gg :G<cr>
nnoremap <leader>ga :Git add<space>
nnoremap <leader>gs :Git status<cr>
nnoremap <leader>gc :Git commit<space>
nnoremap <leader>gd :Gdiff<cr>
nnoremap <leader>gl :Git log<space>
nnoremap <leader>gb :Git branch<space>
nnoremap <leader>go :Git checkout<space>
nnoremap <leader>gps :Dispatch! git push<cr>
nnoremap <leader>gpl :Dispatch! git pull<cr>

