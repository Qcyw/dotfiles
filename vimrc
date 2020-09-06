syntax on
set number
set relativenumber
set nocompatible
set expandtab
setlocal spell
set spelllang=en_us
set listchars=trail:·
set noswapfile
filetype off

" Vundle setup and plugins
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

"let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

"vimtex plugin"
Plugin 'lervag/vimtex'
	let g:tex_flavor='latex' 
	let g:vimtex_view_method='skim'

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

call vundle#end()
filetype plugin indent on


" Mappings
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u
