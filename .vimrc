set nocompatible

" Pathogen setup
execute pathogen#infect()
filetype plugin indent on

" Leader
let mapleader = ","

" General config
syntax on
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
set clipboard=unnamed " use system clipboard by default

" Smarttabs, 2 spaces
set tabstop=2
set shiftwidth=2
set smarttab
set expandtab

" Color scheme
set background=dark
colorscheme molokai
set guifont=AndaleMono:h14

" When vimrc is edited, reload it
augroup reload_vimrc " {
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }

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
  autocmd FileType ruby setl omnifunc=syntaxcompelete#Complete
augroup END

augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END

if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor
endif

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" Ctrl-P settings
let g:ctrlp_max_height = 20
"let g:ctrlp_prompt_mappings = {
    "\ 'PrtSelectMove("k")':   ['<Tab>'],
    "\ }
nnoremap <leader>y :tabe<CR>:CtrlP<CR>
"nnoremap <leader>t :CtrlP<CR>
set wildignore+=*/tmp/*,*.so,*.swp,*.zip

" Checktime reloads files editted outside vim (git)
nnoremap <leader>q :checktime

" Open NERDTree navigation
map <leader>n :NERDTreeToggle<CR>

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


" Tabs
nmap <leader>t :tabnew<CR>
nmap <leader>[ :tabp<CR>
nmap <leader>] :tabn<CR>

" Hide highlighting
nmap <leader>h :nohl<CR>

" Quick Ag
nmap <leader>a :Ag! 

nmap <leader>w :w<CR>

" Jumping lines
nmap <leader>j <C-d>
nmap <leader>k <C-u>

" Configure vim-rspec
let s:rspec_tmux_command = "tmux send -t 1.0 'rspec --drb {spec}' Enter" 
let g:rspec_command = "!echo " . s:rspec_tmux_command . " && " . s:rspec_tmux_command
nmap <leader>rf :call RunCurrentSpecFile()<CR>
nmap <leader>rr :call RunNearestSpec()<CR>
nmap <leader>rl :call RunLastSpec()<CR>

" Configure vim-slime
let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": "/tmp/pair", "target_pane": ":2.1"}
let g:slime_paste_file = "$HOME/.slime_paste"

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" ZoomWin 
nmap <leader>z <C-w>o

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Random leader commands
nnoremap <leader>g :Git
nnoremap <leader>{ :Tabularize /{
nnoremap <leader>o o<ESC>k
nnoremap <leader>O O<ESC>j
nnoremap <leader>{ :Tabularize /{

""""""""""""""""""
" Syntax
"""""""""""""""""
au FileType html setlocal shiftwidth=2 tabstop=2
au FileType javascript setlocal shiftwidth=2 tabstop=2
au FileType coffee setlocal shiftwidth=2 tabstop=2
au FileType cucumber setlocal shiftwidth=2 tabstop=2
au FileType ruby setlocal shiftwidth=2 tabstop=2
au BufRead,BufNewFile *.god et filetype=ruby
au BufRead,BufNewFile *.thor set filetype=ruby
au BufRead,BufNewFile *.rabl set filetype=ruby
au BufRead,BufNewFile *.axlsx set filetype=ruby
au BufRead,BufNewFile *.hamljs set filetype=haml
au BufRead,BufNewFile *.csvbuilder set filetype=ruby

" toggle red line at 101st character to keep lines under 80 chars
function! g:ToggleRedline()
  if(&colorcolumn == 101)
    set colorcolumn=0
  else
    set colorcolumn=101
  endif
endfunc
nnoremap <leader>l :call g:ToggleRedline()<cr>

"""""""""""""""""""""""""""
" Kill all the Whitespace
"""""""""""""""""""""""""""
function! TrimWhiteSpace()
    %s/\s\+$//e
endfunction

nnoremap <silent> <Leader>tws :call TrimWhiteSpace()<CR>

"autocmd FileType ruby,haml,javascript,coffee,cucumber autocmd FileWritePre    * :call TrimWhiteSpace()
"autocmd FileType ruby,haml,javascript,coffee,cucumber autocmd FileAppendPre   * :call TrimWhiteSpace()
"autocmd FileType ruby,haml,javascript,coffee,cucumber autocmd FilterWritePre  * :call TrimWhiteSpace()
"autocmd FileType ruby,haml,javascript,coffee,cucumber autocmd BufWritePre     * :call TrimWhiteSpace()
