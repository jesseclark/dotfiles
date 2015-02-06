" Use Vim settings, rather then Vi settings. This setting must be as early as
" possible, as it has side effects.
set nocompatible

" Pathogen setup
execute pathogen#infect()
filetype plugin indent on

" Leader
let mapleader = ","

" General config
set backspace=2   " Backspace deletes like most programs in insert mode
set nobackup
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set history=100
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set laststatus=2  " Always display the status line
set autowrite     " Automatically :write before running commands
set number        " turn on line numbers
set relativenumber " show absolute number on cursor line and relative numbers above/below
set numberwidth=3 " gutter width
set hlsearch      " Highlight search results
set showmatch     " Show matching braces
set noerrorbells  " No sound on errors
set visualbell
set autoread      " Set to auto read when a file is changed from the outside

" Smarttabs, 2 spaces
set tabstop=2
set shiftwidth=2
set shiftround
set smarttab

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
syntax enable

" When vimrc is edited, reload it
augroup reload_vimrc
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

augroup vimrcEx
  autocmd!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile *.md set filetype=markdown

  " Enable spellchecking for Markdown
  autocmd FileType markdown setlocal spell

  " Automatically wrap at 80 characters for Markdown
  autocmd BufRead,BufNewFile *.md setlocal textwidth=80

  " Automatically wrap at 72 characters and spell check git commit messages
  autocmd FileType gitcommit setlocal textwidth=72
  autocmd FileType gitcommit setlocal spell

  " Allow stylesheets to autocomplete hyphenated words
  autocmd FileType css,scss,sass setlocal iskeyword+=-

  " Ruby omnicomplete options
  autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
  autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
  autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
augroup END

if has("autocmd") && exists("+omnifunc")
  autocmd Filetype *
    \   if &omnifunc == "" |
    \           setlocal omnifunc=syntaxcomplete#Complete |
    \   endif
endif

augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END

"if !exists( "*RubyEndToken" )

  "function RubyEndToken()
    "let current_line = getline( '.' )
    "let braces_at_end = '{\s*\(|\(,\|\s\|\w\)*|\s*\)\?$'
    "let stuff_without_do = '^\s*\(class\|if\|unless\|begin\|case\|for\|module\|while\|until\|def\)'
    "let with_do = 'do\s*\(|\(,\|\s\|\w\)*|\s*\)\?$'

    "if match(current_line, braces_at_end) >= 0
      "return "\<CR>}\<C-O>O"
    "elseif match(current_line, stuff_without_do) >= 0
      "return "\<CR>end\<C-O>O"
    "elseif match(current_line, with_do) >= 0
      "return "\<CR>end\<C-O>O"
    "else
      "return "\<CR>"
    "endif
  "endfunction

"endif

"imap <buffer> <CR> <C-R>=RubyEndToken()<CR>


if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor
  
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

let g:ctrlp_working_path_mode = 'r'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip

" Color scheme
colorscheme molokai

" New buffer at direction
nmap <leader>sh  :leftabove  vnew<CR>
nmap <leader>sl  :rightbelow vnew<CR>
nmap <leader>sk  :leftabove  new<CR>
nmap <leader>sj  :rightbelow new<CR>

nnoremap <leader>wh <C-w>h
nnoremap <leader>wl <C-w>l
nnoremap <leader>wj <C-w>j
nnoremap <leader>wk <C-w>k
nnoremap <leader>W  <C-w>=

" NavigatingCancer navigation and panes settings

" Comma-T
nmap <leader>t :CtrlP<CR>

let g:ctrlp_prompt_mappings = {
    \ 'PrtSelectMove("k")':  ['<Tab>'],
    \ }

" Tabs
nmap <leader>T :tabnew<CR>
nmap <leader>[ :tabp<CR>
nmap <leader>] :tabn<CR>

" Quick Ack
nmap <C-a> :Ack

" Quick close
nmap <leader>q :q<CR>
nmap <leader>w :w<CR>

" Jumping lines
nmap <leader>j <C-d>
nmap <leader>k <C-u>

" Run specs on current file
nmap <leader>rf :call RunCurrentSpecFile()<CR>
nmap <leader>rr :call RunNearestSpec()<CR>
nmap <leader>rl :call RunLastSpec()<CR>

let g:rspec_runner = "os_x_iterm"

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

""""""""""""""""""
" Syntax
"""""""""""""""""

au BufRead,BufNewFile *.thor set filetype=ruby
au BufRead,BufNewFile *.rabl set filetype=ruby
au BufRead,BufNewFile *.axlsx set filetype=ruby
au BufRead,BufNewFile *.csvbuilder set filetype=ruby
au BufRead,BufNewFile *.hamljs set filetype=haml

" SLIME
let g:slime_target = "tmux"

"function! InsertTabWrapper(direction)
"  let col = col('.') - 1
"  if !col || getline('.')[col - 1] !~ '\k'
"    return "\<tab>"
"  elseif "back" == a:direction
"    return "\<c-p>"
"  else
"    return "\<c-n>"
"  endif
"endfunction

"inoremap <tab> <c-r>=InsertTabWrapper ("forw")<cr>
"inoremap <s-tab> <c-r>=InsertTabWrapper ("back")<cr>

