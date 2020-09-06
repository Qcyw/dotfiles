syntax on
set number
set relativenumber
set nocompatible
set expandtab
set smartindent
set tabstop=4 softtabstop=4 shiftwidth=4
setlocal spell
set spelllang=en_us
set listchars=trail:·
set title titlestring=
set list
set noswapfile
set wildignore+=*/vendor,*/node_modules/*,_site,*/__pycache__,*/venv/*,*/target/*,*/.vim$,\~$,*/.log,*/.aux,*/.cls,*/.aux,*/.bbl,*/.blg,*/.fls,*/.fdb*/,*/.toc,*/.out,*/.glo,*/.log,*/.ist,*/.fdb_latexmk,*/.git
filetype off

" Vundle setup and plugins
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

"let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

"vimtex plugin"
Plugin 'lervag/vimtex'
        let g:tex_flavor='latex'
        let g:livepreview_previewer='zathura'

"vim latex conceal
Plugin 'KeitaNakamura/tex-conceal.vim'
    set conceallevel=1
    let g:tex_conceal='abdmg'
    hi Conceal ctermbg=none

"snippets
Plugin 'SirVer/ultisnips'
        let g:UltiSnipsExpandTrigger="<tab>"
        let g:UltiSnipsJumpForwardTrigger="<c-b>"
        let g:UltiSnipsJumpBackwardTrigger="<c-z>"
        let g:UltiSnipsEditTrigger="<c-e>"
        let g:UltiSnipsEditSplit="vertical"

"vim snippets"
Plugin 'honza/vim-snippets'

"Live preview Latex PDF
Plugin 'xuhdev/vim-latex-live-preview'

"Tags
Plugin 'ludovicchabant/vim-gutentags'

"coc to goto definition and autocomplete
Plugin 'neoclide/coc.nvim', {'branch': 'release'}

" commenting tool
Plugin 'preservim/nerdcommenter'

" surrond
Plugin 'tpope/vim-surround'

" window choosing with -
Plugin 't9md/vim-choosewin'

" auto closing
Plugin 'Townk/vim-autoclose'

" fzf and Rg and Ag
Plugin 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plugin 'junegunn/fzf.vim'

call vundle#end()
filetype plugin indent on


" Mappings
let mapleader = " "
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>
nnoremap <Leader>ps :Rg<space>
nnoremap <silent> <Leader>+ :vertical resize +5<CR>
nnoremap <silent> <Leader>- :vertical resize -5<CR>
nnoremap <silent> <leader>f :Files<CR>
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

"coc maps
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nnoremap <silent><nowait> <space>x :<C-u>CocList commands<cr>

" choose window maps
nmap  -  <Plug>(choosewin)
" show big letters
let g:choosewin_overlay_enable = 1

" Automatically deletes all trailing whitespace and newlines at end of file on save.
        autocmd BufWritePre * %s/\s\+$//e
        autocmd BufWritepre * %s/\n\+\%$//e

"Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"


"===================================================
" fzf window when searching need to install Ag and Rg and fzf in terminal also
" need a gvim
let g:fzf_layout = {'up':'~70%', 'window': { 'width': 0.8, 'height': 0.8,'yoffset':0.5,'xoffset': 0.5, 'highlight': 'Todo', 'border': 'sharp'  } }
let $FZF_DEFAULT_OPTS = '--layout=reverse --info=inline'
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden'

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }


let g:fzf_colors =
  \ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

let g:fzf_tags_command='ctags -R'

"Get Files
command! -bang -nargs=? -complete=dir Files
            \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)

" Get text in files with Rg

function! RipgrepFzf(query, fullscreen)
    let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
    let initial_command = printf(command_fmt, shellescape(a:query))
    let reload_command = printf(command_fmt, '{q}')
    let options = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
    call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(options), a:fullscreen)
endfunction

command! -nargs=* -bang RF call RipgrepFzf(<q-args>, <bang>0)
