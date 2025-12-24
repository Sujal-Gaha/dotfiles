" ===============================
" Vim Plug Plugins
" ===============================
call plug#begin()

Plug 'junegunn/fzf', { 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'prettier/vim-prettier', { 'do': 'yarn install'  }
Plug 'itchyny/lightline.vim'
Plug 'dense-analysis/ale'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

call plug#end()

" ===============================
" Basic Settings
" ===============================
syntax on
set number
set relativenumber
set scrolloff=12
set wildignore+=*/node_modules/*,*/dist/*,*/build/*,*/__pycache__/*,*/*-env/*,*.db
set noshowmode  " Hide mode indicator since lightline shows it
set splitright
set ignorecase
set hlsearch
set smartcase

set foldmethod=syntax
set foldenable
set foldcolumn=1
set foldlevelstart=99
set foldtext=CustomFoldText()

highlight Folded guifg=#c0caf5 guibg=#1f2335 ctermfg=252 ctermbg=235 cterm=NONE


function! CustomFoldText()
  let line = getline(v:foldstart)
  let lines = v:foldend - v:foldstart + 1
  return printf('  ▶ %s  [%d lines]', substitute(line, '^\s*', '', ''), lines)
endfunction

" ===============================
" NERDTree Configuration
" ===============================
" NERDTree toggle
nmap <F6> :NERDTreeToggle<CR>
" Show hidden files
let NERDTreeShowHidden=1

" Automatically open NERDTree
autocmd vimenter * NERDTree

" ===============================
" FZF Configuration
" ===============================
" Ctrl+P to search files in git repository (or fall back to all files)
nnoremap <C-p> :GFiles<CR>

" Ctrl+B to search open buffers
nnoremap <C-b> :Buffers<CR>

" Ctrl+F to search file contents (ripgrep)
nnoremap <C-f> :Rg<CR>

" Search all files (including non-git files)
nnoremap <Leader>p :Files<CR>

" ===============================
" Lightline Configuration
" ===============================
set laststatus=2  " Always show statusline
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component_function': {
      \   'filename': 'LightlineFilename'
      \ },
      \ }

function! LightlineFilename()
  return expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
endfunction

" ===============================
" ALE Configuration
" ===============================
" Enable ALE
let g:ale_enabled = 1

" Lint on save and when text changes
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:ale_set_highlights = 0
let g:ale_virtualtext_cursor = 'disabled'

let g:ale_python_flake8_options = '--max-line-length=120'

" Fix files on save
let g:ale_fix_on_save = 1

" Configure fixers for different file types
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['prettier', 'eslint'],
\   'typescript': ['prettier', 'eslint'],
\   'python': ['black', 'isort'],
\   'go': ['gofmt', 'goimports'],
\   'json': ['prettier'],
\   'html': ['prettier'],
\   'css': ['prettier'],
\   'scss': ['prettier'],
\}

" Configure linters
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'typescript': ['eslint', 'tsserver'],
\   'python': ['flake8', 'pylint'],
\   'go': ['gopls', 'golint', 'govet'],
\}

" Error and warning signs
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'

" Navigate between errors
nmap <silent> [a <Plug>(ale_previous_wrap)
nmap <silent> ]a <Plug>(ale_next_wrap)

" Show error details
nmap <leader>d <Plug>(ale_detail)

" ===============================
" vim-go Configuration
" ===============================
" Disable vim-gos LSP (we use CoC with gopls)
let g:go_gopls_enabled = 0
let g:go_code_completion_enabled = 0
let g:go_def_mapping_enabled = 0

" Enable syntax highlighting features
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1

" Auto format and import on save
let g:go_fmt_autosave = 1
let g:go_fmt_command = "goimports"

" Disable vim-go template on new file
let g:go_template_autocreate = 0

" ===============================
" CoC.nvim Key Mappings
" ===============================
" Navigate completion menu in Insert mode
inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <silent><expr> <CR> pumvisible() ? coc#pum#confirm() : "\<CR>"

" Trigger completion manually
inoremap <silent><expr> <C-j> coc#refresh()

" Go to definition / references
nnoremap <silent> gd <Plug>(coc-definition)
nnoremap <silent> gr <Plug>(coc-references)

" Hover documentation
nnoremap <silent> K :call CocActionAsync('doHover')<CR>

" Rename symbol
nnoremap <leader>rn <Plug>(coc-rename)

" Format
nnoremap <leader>f <Plug>(coc-format)
vnoremap <leader>f <Plug>(coc-format-selected)

" Diagnostics navigation
nnoremap <silent> [g <Plug>(coc-diagnostic-prev)
nnoremap <silent> ]g <Plug>(coc-diagnostic-next)

" ===============================
" Prettier Autoformat
" ===============================
let g:prettier#autoformat = 1
let g:prettier#autoformat_require_pragma = 0

" ===============================
" CoC Popup Menu Theme
" ===============================
" DARK MODE
highlight Pmenu       ctermbg=235 ctermfg=250 guibg=#1e1e2e guifg=#dcdcdc
highlight PmenuSel    ctermbg=237 ctermfg=255 guibg=#5f5faf guifg=#ffffff
highlight PmenuSbar   ctermbg=236             guibg=#333344
highlight PmenuThumb  ctermbg=240             guibg=#5f5faf

" LIGHT MODE (uncomment to use)
" highlight Pmenu       ctermbg=254 ctermfg=235 guibg=#f0f0f0 guifg=#1e1e1e
" highlight PmenuSel    ctermbg=180 ctermfg=235 guibg=#fabd2f guifg=#282828
" highlight PmenuSbar   ctermbg=252             guibg=#d0d0d0
" highlight PmenuThumb  ctermbg=180             guibg=#fabd2f
