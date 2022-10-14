call plug#begin('~/AppData/Local/nvim/plugged')
" below are some vim plugins for demonstration purpose.
" add the plugin you want to use here.

" Appearance
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'ryanoasis/vim-devicons'

" Utilities
    Plug 'sheerun/vim-polyglot'
    Plug 'jiangmiao/auto-pairs'
    Plug 'ap/vim-css-color'
    Plug 'preservim/nerdtree'

" Completion / linters / formatters
    Plug 'neoclide/coc.nvim'
    Plug 'plasticboy/vim-markdown'

" Git
    Plug 'tpope/vim-fugitive'

call plug#end()

" Disable math tex conceal feature
let g:tex_conceal = ''
let g:vim_markdown_math = 1

" Markdown
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_conceal = 0
let g:vim_markdown_fenced_languages = ['tsx=typescriptreact']

" Normal mode remappings
nnoremap <C-q> :q!<CR>
nnoremap <F4> :bd<CR>
nnoremap <C-l> :NERDTreeToggle<CR>
nnoremap <F6> :sp<CR>:terminal<CR>

" Tabs
nnoremap <S-Tab> gT
nnoremap <Tab> gt
nnoremap <silent> <S-t> :tabnew<CR>
set clipboard=unnamedplus
set completeopt=noinsert,menuone,noselect
set hidden
set inccommand=split
set number
set fillchars=fold:\ ,vert:\│,eob:\ ,msgsep:‾
set splitbelow splitright
set title
set ttimeoutlen=0
set wildmenu

" Tabs size
set expandtab
set shiftwidth=2
set tabstop=2
filetype plugin indent on
syntax on
set t_Co=256

" True color if available
let term_program=$TERM_PROGRAM
if $TERM !=? 'xterm-256color'
        set termguicolors
    endif

let &t_ZH="\e[3m"
let &t_ZR="\e[23m"

" File browser
let g:netrw_banner=0
let g:netrw_liststyle=2
let g:netrw_browse_split=4
let g:netrw_altv=1
let g:netrw_winsize=25
let g:netrw_keepdir=0
let g:netrw_localcopydircmd='cp -r'

" Create file without opening buffer
function! CreateInPreview()
  let l:filename = input('please enter filename: ')
  execute 'silent !touch ' . b:netrw_curdir.'/'.l:filename
  redraw!
endfunction

" Netrw: create file using touch instead of opening a buffer
function! Netrw_mappings()
  noremap <buffer>% :call CreateInPreview()<cr>
endfunction

augroup auto_commands
    autocmd filetype netrw call Netrw_mappings()
augroup END

function! AirlineInit()
  let g:airline_section_a = airline#section#create(['mode', ' ' , 'branch'])
endfunction
autocmd VimEnter * call AirlineInit()
let g:airline#extensions#tabline#formatter = 'default'
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='supernova'
"owo, google_dark, base16_outrun_dark, lighthaus, alduin, supernova

function! GitStatus()
  let [a,m,r] = GitGutterGetHunkSummary()
  return printf('+%d ~%d -%d', a, m, r)
endfunction
set statusline+=%{GitStatus()}
set signcolumn=yes

" File browser
let NERDTreeShowHidden=1

let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']