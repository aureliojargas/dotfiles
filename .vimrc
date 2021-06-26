" Colors, please
syntax on

" Look mom, we're in the future!
set encoding=utf-8

" Fix common typos
cabbrev W w
cabbrev Q q
cabbrev Wq wq
cabbrev WQ wq

" No beeps, just flashes
set visualbell

" Show line/column number at bottom
set ruler

" Show status line at bottom (and "file has changed" indicator)
set laststatus=2

" Options for a better search experience
set incsearch hlsearch ignorecase smartcase magic

" Colors for highlighted text (use NONE for transparent)
highlight Visual ctermbg=Blue ctermfg=White
highlight MatchParen ctermbg=Blue ctermfg=White
highlight Search ctermbg=Yellow ctermfg=Black

" Make tab completion more bash-like
set wildmode=longest,list:full

" My (current) code preferences
set autoindent expandtab tabstop=4

" Commands '>' and '<' will walk $tabstop spaces
set shiftwidth=0

" Append one, not two spaces after periods in 'gq'
set nojoinspaces

" Remember cursor position, save command history
set viminfo='10,\"30,:40,%,n~/.viminfo
autocmd BufReadPost * if line("'\"")|execute("normal `\"")|endif

" Highlight tabs and trailing spaces
" Sample:  	   		foo bar    
set list listchars=tab:\|·,trail:█,precedes:<,extends:>

" Autosave, always
autocmd TextChanged,TextChangedI * silent write

" YAML defaults
autocmd FileType yaml set tabstop=2

" HTML/CSS defaults
autocmd FileType html,css set tabstop=2 textwidth=0

" Bash defaults
autocmd FileType sh set textwidth=100

" Python defaults
autocmd FileType python set textwidth=88  " black default
autocmd FileType python hi pythonString ctermfg=lightgreen
autocmd FileType python hi pythonRawString ctermfg=lightgreen

" txt2tags
autocmd BufNewFile,BufRead *.t2t set filetype=txt2tags

" Git commit message limited to 72 columns
autocmd FileType gitcommit set textwidth=72

" Quickly move betwwen open tabs
nnoremap H :tabprevious<CR>
nnoremap L :tabnext<CR>
