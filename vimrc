
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
" Plug 'justinmk/vim-sneak'

" completion and linting
Plug 'neoclide/coc.nvim', {'branch': 'release'}         " intellisense engine
Plug 'ludovicchabant/vim-gutentags'                     " auto update tags file
Plug 'SirVer/ultisnips'                                 " snippet manager

" conveniences
Plug 'tpope/vim-commentary'                             " comment bindings
Plug 'tpope/vim-surround'                               " change brackets, parents, quotes, html tags
Plug 'tpope/vim-repeat'                                 " repeat plugin actions
Plug 'tpope/vim-abolish'                                " smart search and replace
Plug 'tpope/vim-eunuch'                                 " write a privileged files, other unix commands
" Plug 'LunarWatcher/auto-pairs'                          " autopairs, better?

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
let g:seoul256_background = 253
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
au CursorHold * checktime


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

" close all buffers
nnoremap <leader>dd :%bdelete<cr>

" exit
nnoremap K :bd<cr>
nnoremap <C-d> :q!<cr>
nnoremap <leader>q :q!<cr>

" edit snake case variable name
nnoremap <leader><space> vt_

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
nnoremap <silent><esc> :noh<cr>

" prevent vim from entering replace mode due to the above mapping
nnoremap <esc>^[ <esc>^[

" vimgrep I like better than FZF ripgrep
nnoremap <C-f> :vimgrep '' **/*<left><left><left><left><left><left>

" quickfix window
nnoremap <leader>c :copen 10<cr>
nnoremap <F6> :cnext<cr>zz
nnoremap <F7> @@
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
nnoremap <leader>ed :e ~/.dotfiles/<cr>

" save as root
command W :execute ':silent w !sudo tee % > /dev/null' | :edit!

" auto close pairs when on separate lines
inoremap {<cr> {<cr>}<esc>O
inoremap [<cr> [<cr>]<esc>O
inoremap (<cr> (<cr>)<esc>O

" open lazygit in vim
nnoremap <silent> <leader>lg :tab term ++close lazygit<cr>
nnoremap <silent> <leader>tl :tab term tail logs/law.access.log<cr>

" open dadbod in a separate tab
nnoremap <silent> <leader>db :tab DBUI<cr>

nnoremap <leader>p oimport pudb; pu.db


" ---------------------------------------------------------------------------
" Plugin Configuration
" ---------------------------------------------------------------------------

" Autosave
let g:auto_save = 1
let g:auto_save_in_insert_mode = 0

" Autopairs
" let g:AutoPairsCompleteOnlyOnSpace = 1

" Dadbod
let g:db_ui_execute_on_save = 0

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
" Use tab for trigger completion with characters ahead and navigate
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item and expand snippet if applicable
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
inoremap <silent><expr> <c-space> coc#refresh()

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

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
xmap <leader>F  <Plug>(coc-format-selected)
nmap <leader>F  <Plug>(coc-format-selected)

" Apply AutoFix to problem on the current line
nmap <leader>af  <Plug>(coc-fix-current)

" Show all diagnostics
nnoremap <silent><nowait> <leader>a  :<C-u>CocList diagnostics<cr>

" Show available snippets
nnoremap <silent><nowait> <leader>sn  :<C-u>CocList snippets<cr>

" Use <C-l> to trigger snippets completion
imap <C-l> <Plug>(coc-snippets-expand)

