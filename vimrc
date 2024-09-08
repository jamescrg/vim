
" use '*' to search to desired section
" Options
" Keymaps
" Insertions

call plug#begin('~/.vim/plugged')

" colors
Plug 'junegunn/seoul256.vim'                            " preferred light colorscheme
Plug 'sainnhe/everforest'                               " preferred dark colorscheme

" files
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }     " fuzzy search utility
Plug 'junegunn/fzf.vim'                                 " fuzzy search integration
Plug 'tpope/vim-vinegar'                                " file broser
Plug 'vim-scripts/vim-auto-save'                        " auto save
Plug 'farmergreg/vim-lastplace'                         " return to last positon in file when opened

" movement
Plug 'justinmk/vim-sneak'

" completion and linting
Plug 'maralla/completor.vim'                            " better autocomplete, always on
Plug 'maralla/validator.vim'                            " code validation
Plug 'ludovicchabant/vim-gutentags'                     " auto update tags file
Plug 'SirVer/ultisnips'                                 " snippet manager

" conveniences
Plug 'tpope/vim-commentary'                             " comment bindings
Plug 'tpope/vim-surround'                               " change brackets, parents, quotes, html tags
Plug 'tpope/vim-repeat'                                 " repeat plugin actions
Plug 'tpope/vim-abolish'                                " smart search and replace
Plug 'tpope/vim-eunuch'                                 " write a privileged files, other unix commands
Plug 'LunarWatcher/auto-pairs'                          " autopairs, better?

" language helpers
Plug 'ap/vim-css-color'                                 " show colors on css hex values
Plug 'kalekundert/vim-coiled-snake'                     " python folding
Plug 'valloric/MatchTagAlways'                          " highlight matching html tags
Plug 'Vimjas/vim-python-pep8-indent'

" database
Plug 'tpope/vim-dadbod'                                 " database interaction
Plug 'kristijanhusak/vim-dadbod-ui'                     " ui for databse interaction
Plug 'kristijanhusak/vim-dadbod-completion'             " autocompletion for database ui

" interface
Plug 'tpope/vim-fugitive'                               " git integration
Plug 'rhysd/conflict-marker.vim'                        " highlight git conflicts
Plug 'junegunn/vim-peekaboo'                            " preview registers
Plug 'vim-test/vim-test'                                " test runner

call plug#end()


" ----------------------------------------------------------------------------------
" Appearance
" ----------------------------------------------------------------------------------

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
" let g:everforest_disable_italic_comment = 1
" set background=dark
" colorscheme everforest

" status line
hi StatusLine ctermbg=2 ctermfg=252
hi StatusLineNC ctermbg=2 ctermfg=253
hi StatusLineTerm ctermbg=2 ctermfg=253

set statusline=
" set statusline+=%{fugitive#statusline()}
set statusline+=\ %f
set statusline+=%=
set statusline+=\ %l:%c

" popup menu
hi Pmenu ctermbg=253 ctermfg=5
hi PmenuSel ctermbg=5 ctermfg=253

" tab line
hi TabLineFill ctermfg=253 ctermbg=2
hi TabLine ctermfg=2 ctermbg=253
hi TabLineSel ctermfg=2 ctermbg=252


" ----------------------------------------------------------------------------------
" Options
" ----------------------------------------------------------------------------------

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

set laststatus=2                                " always show status line
set cursorline                                  " always highlight cursor line
set ignorecase                                  " ignore case
set smartcase                                   " except when an upper case character is used
set incsearch                                   " start searching as it is typed
set hlsearch                                    " highlight search patterns
set mouse=a                                     " enable mouse usage
set noswapfile                                  " no swap files
set splitright                                  " open splits on the right
set splitbelow                                  " open splits on bottom
set foldmethod=indent                           " fold behavior
set foldlevel=99                                " folds closed by default
set expandtab                                   " inserts spaces when tab key is pressed
set tabstop=4                                   " sets for spaces for tabs
set softtabstop=4                               " number of spaces removed by backspace key
set shiftwidth=4                                " sets number of spaces to insert/remove using indentation commands
set autoindent                                  " autoindent
set shiftround                                  " use multiple of shiftwidth when indenting with '<' and '>'
set backspace=indent,eol,start                  " backspace
set ttimeoutlen=50                              " elminiate delay in escaping out of fzf
set undofile                                    " persistent undo history
set undodir=~/.vim/undodir                      " undo history file location
set viminfofile=~/.vim/viminfo                  " move viminfo to vim folder
set signcolumn=number                           " prevent signs from opening another gutter
set number                                      " always show line numbers
set relativenumber                              " use relative line numbers
set nowrap                                      " wrap lines
set linebreak                                   " break at whitespace not words
set display=lastline                            " show partial lines at the bottom of the screen
set scrolloff=3                                 " keep at least 5 lines visible above/below cursor
set guitablabel=%N/\ %t\ %M                     " more attractive tab labels


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
set wildignore+=logs/**


" ---------------------------------------------------------------------------
" Keymaps
" ---------------------------------------------------------------------------

" leader
let mapleader = ' '

" escaping
inoremap jj <esc>
inoremap jk <esc>

" exit
nnoremap K :bd<cr>
nnoremap <C-d> :q!<cr>
nnoremap <leader>q :q!<cr>

" window navigation
nnoremap <leader>v :vsp<cr>
nnoremap <leader>w <C-w>
nnoremap <tab> <C-w>w
nnoremap <S-tab> <C-w>W
nnoremap <C-p> <C-i>
nnoremap H Hzz
nnoremap L Lzz
vnoremap H Hzz
vnoremap L Lzz

" clear highlighted search text until next explicit search or n/N
" <silent> - so as to not print :noh on last line when invoked
nnoremap <silent> <esc> :noh<cr>

" vimgrep I like better than FZF ripgrep
nnoremap <C-f> :vimgrep '' **/*<left><left><left><left><left><left>

" quickfix window
nnoremap <leader>c :copen 10<cr>
nnoremap ]q :cnext<cr>zz
nnoremap [q :cprevious<cr>zz

" code folding
nnoremap , za

" search for word under cursor, including first word
nnoremap * *N

" center search results as they come into focus
nnoremap n nzz
nnoremap N Nzz

" search for visually selected text
vnoremap * y/\V<C-R>=escape(@",'/\')<cr><cr>N

" smart search and replace
nnoremap <C-h> :%Subvert//{,}/g<left><left><left><left><left><left>

" shortcuts to edit configuation files
nnoremap <leader>ev :e $MYVIMRC<cr>
nnoremap <leader>so :so %<cr>
nnoremap <leader>es :e ~/.vim/UltiSnips<cr>

" save as root
command W :execute ':silent w !sudo tee % > /dev/null' | :edit!

" auto close pairs when on separate lines
" inoremap {<cr> {<cr>}<esc>O
" inoremap [<cr> [<cr>]<esc>O
" inoremap (<cr> (<cr>)<esc>O

" open lazygit in vim
nnoremap <silent> <leader>lg :tab term ++close lazygit<cr>

" open dadbod in a separate tab
nnoremap <silent> <leader>db :tab DBUI<cr>


" ---------------------------------------------------------------------------
" Plugin Configuration
" ---------------------------------------------------------------------------

" Autosave
let g:auto_save = 1
let g:auto_save_in_insert_mode = 0

" Autopairs
let g:AutoPairsCompleteOnlyOnSpace = 1

" Dadbod
let g:db_ui_execute_on_save = 0

" FZF
nnoremap <leader>f :Files<cr>
nnoremap <nowait><leader>b :Buffers<cr>
nnoremap <leader>g :Rg<cr>
nnoremap <leader>h :History<cr>

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

