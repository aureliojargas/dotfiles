" Colors, please
syntax on

" Look mom, we're in the future!
set encoding=utf-8

" Fix common typos
cab W w | cab Q q | cab Wq wq | cab WQ wq

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
au BufReadPost * if line("'\"")|execute("normal `\"")|endif

" Highlight tabs and trailing spaces
" Sample:  	   		foo bar    
set list listchars=tab:\|·,trail:█,precedes:<,extends:>

" Autosave, always
autocmd TextChanged,TextChangedI * silent write

" YAML defaults
au FileType yaml set tabstop=2

" HTML/CSS defaults
au FileType html,css set tabstop=2 textwidth=0

" Bash defaults
au FileType sh set textwidth=100

" Python defaults
au FileType python set textwidth=100
au FileType python hi pythonString ctermfg=lightgreen
au FileType python hi pythonRawString ctermfg=lightgreen

" txt2tags
au BufNewFile,BufRead *.t2t set filetype=txt2tags

" Git commit message limited to 72 columns
au FileType gitcommit set textwidth=72
