
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
Plug 'tpope/vim-vinegar'                                " file bros
Plug 'vim-scripts/vim-auto-save'                        " auto save
Plug 'farmergreg/vim-lastplace'                         " return to last positon in file when opened

" completion and linting
Plug 'neoclide/coc.nvim', {'branch': 'release'}         " intellisense engine
Plug 'SirVer/ultisnips'                                 " snippet manager

" conveniences
Plug 'tpope/vim-commentary'                             " comment bindings
Plug 'tpope/vim-surround'                               " change brackets, parents, quotes, html tags
Plug 'tpope/vim-repeat'                                 " repeat plugin actions
Plug 'tpope/vim-abolish'                                " smart search and replace
Plug 'tpope/vim-eunuch'                                 " write a privileged files, other unix commands

" language helpers
Plug 'ap/vim-css-color'                                 " show colors on css hex values
Plug 'kalekundert/vim-coiled-snake'                     " python folding
Plug 'valloric/MatchTagAlways'                          " highlight matching html tags
Plug 'Vimjas/vim-python-pep8-indent'

" interface
Plug 'tpope/vim-fugitive'                               " git integration
Plug 'rhysd/conflict-marker.vim'                        " highlight git conflicts
Plug 'junegunn/vim-peekaboo'                            " preview registers
Plug 'vim-test/vim-test'                                " test runner

" writing
Plug 'junegunn/goyo.vim'                                " writing mode

call plug#end()

" ----------------------------------------------------------------------------------
" Seoul256
" ----------------------------------------------------------------------------------

" seoul256 light
"   Range:   252 (darkest) ~ 256 (lightest)
"   Default: 253
let g:seoul256_background = 253
colorscheme seoul256-light

" status line
hi StatusLine ctermbg=2 ctermfg=252
hi StatusLineNC ctermbg=2 ctermfg=253
hi StatusLineTerm ctermbg=2 ctermfg=253

set statusline=
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
" Everforest
" ----------------------------------------------------------------------------------

" if has('termguicolors')
"     set termguicolors
" endif
" set background=dark
" let g:everforest_background = 'soft'
" let g:everforest_better_performance = 1
" colorscheme everforest


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

" coc optimization
set encoding=utf-8
set nobackup
set nowritebackup
set updatetime=300

" other settings
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
set autoread


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

" writing mode
augroup md
    autocmd BufRead,BufNewFile *.md setlocal spell wrap
    " autocmd BufRead,BufNewFile *.md let b:coc_enabled = 0
    autocmd BufRead,BufNewFile *.md nnoremap <buffer> j gj
    autocmd BufRead,BufNewFile *.md nnoremap <buffer> k gk
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

" delete word with ctrl-backspace (terminal sends ^H)
inoremap <C-h> <C-w>

" close all buffers
nnoremap <leader>ca :%bdelete<cr>

" exit
nnoremap K :bd<cr>
nnoremap <leader>q l

" edit snake case variable name
nnoremap <leader><space> vt_

" window navigation
nnoremap <leader>v :vsp<cr>
nnoremap <leader>w <C-w>
nnoremap <tab> <C-w>w
nnoremap <S-tab> <C-w>W
nnoremap <C-p> <C-i>
nnoremap H ^
nnoremap L $

" clear highlighted search text until next explicit search or n/N
" <silent> - so as to not print :noh on last line when invoked
nnoremap <silent><esc> :noh<cr>

" prevent vim from entering replace mode due to the above mapping
nnoremap <esc>^[ <esc>^[

" vimgrep I like better than FZF ripgrep
nnoremap <C-f> :vimgrep '' **/*<left><left><left><left><left><left>

" quickfix window
nnoremap <leader>co :copen 10<cr>

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

" auto close pairs when on separate lines
inoremap {<cr> {<cr>}<esc>O
inoremap [<cr> [<cr>]<esc>O
inoremap (<cr> (<cr>)<esc>O



" shortcuts to edit configuation files
nnoremap <leader>ev :e $MYVIMRC<cr>
nnoremap <leader>so :so %<cr>
nnoremap <leader>es :e ~/.vim/UltiSnips<cr>
nnoremap <leader>ed :e ~/.dotfiles/<cr>

" save as root
command W :execute ':silent w !sudo tee % > /dev/null' | :edit!

" for writing
nnoremap <leader>ss :set spell!<cr>
nnoremap <leader>sw :set wrap!<cr>
nnoremap <leader>gg :Goyo<cr>

" Goyo settings
let g:goyo_width = 100

" Restore statusline colors after leaving Goyo
function! s:goyo_leave()
  hi StatusLine ctermbg=2 ctermfg=252
  hi StatusLineNC ctermbg=2 ctermfg=253
  hi StatusLineTerm ctermbg=2 ctermfg=253
endfunction

autocmd! User GoyoLeave nested call <SID>goyo_leave()



" ---------------------------------------------------------------------------
" Plugin Configuration
" ---------------------------------------------------------------------------

" Autosave
let g:auto_save = 1
let g:auto_save_in_insert_mode = 0

" FZF
nnoremap <leader>f :Files<cr>
nnoremap <nowait><leader>b :Buffers<cr>
nnoremap <leader>r :Rg<cr>
nnoremap <leader>h :History<cr>

" UltiSnips
let g:UltiSnipsExpandTrigger='<c-y>'
let g:UltiSnipsJumpForwardTrigger='<c-y>'
let g:UltiSnipsJumpBackwardTrigger='<c-z>'

" Coc.nvim
" Disable auto formatting on save
let g:coc_preferences_formatOnSaveFiletypes = []

" Completor-style keyboard mappings for CoC's popup menu
" Tab/Shift-Tab navigate through CoC's suggestions (when menu is visible)
inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"
" Enter accepts the selected completion (Ctrl-Y behavior)
inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<cr>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use <leader>k to show documentation in preview window
nnoremap <silent> <leader>k :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
xmap <leader>F  <Plug>(coc-format-selected)
nmap <leader>F  <Plug>(coc-format-selected)

" Show available snippets
nnoremap <silent><nowait> <leader>sn  :<C-u>CocList snippets<cr>

" Use <C-l> to trigger snippets completion
imap <C-l> <Plug>(coc-snippets-expand)

