" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
set rtp+=~/.vim/bundle/vundle
call vundle#rc()
Bundle 'gmaric/vundle'
Bundle 'scrooloose/nerdtree'
" allow backspacing over everything in insert mode
set backspace=indent,eol,start
" колво комманд в памяти
set history=100
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
syntax on
set tabstop=4
" Insert spaces instead of tab symbols
"set expandtab
set shiftwidth=4
set number
set printoptions=number:y
set dir=~/.vim/swp
set mouse=a
"set makeprg=make\ %<

set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
set laststatus=2

"Cpp completion
set tags +=~/.vim/tags/cpp
nmap <F12> :!ctags -R --sort=yes --c++-kinds=+pl --fields=+iaS --extra=+q .<CR>
"OmniCppComplete
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
"let OmniCpp_MayCompleteDot = 1 " autocomplete after .
"let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
"let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest ",preview

function! GetTagFile()
  let cwd = getcwd()
  let g:TagFilename = cwd . "/tags.workfile"
endfunction

function! UpdateTags()
	call GetTagFile()
  	let f = expand("%:p")
	let cmd = 'ctags -a -f ' . g:TagFilename . ' --c++-kinds=+pl --fields=+iaS --extra=+q ' . '"' . f . '"'
	system(cmd)
endfunction

function! DelTags()
	call GetTagFile()
	let cmd = 'rm ' . g:TagFilename
	system(cmd)
endfunction

set tags+=./tags.workfile
"autocmd BufWritePost,BufEnter *.cpp,*.h,*.c call UpdateTags()
"autocmd VimLeave *.cpp,*.h,*.c call DelTags() call

"automatic close and open quifix window
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow
"automatic fit quickfixwin height
au FileType qf call AdjustWindowHeight(1, 20)
function! AdjustWindowHeight(minheight, maxheight)
  exe max([min([line("$"), a:maxheight]), a:minheight]) . "wincmd _"
endfunction
au FileType qf wincmd J

let g:jah_Quickfix_Win_Height = 1
" Toggles the quickfix window.
"command -bang -nargs=? QFix call QFixToggle(<bang>0)
"nnoremap <leader>q :call QuickfixToggle()<cr>

"function! QFixToggle(forced)
"  if exists("g:qfix_win") && a:forced == 0
"    cclose
"  else
"    execute "copen "
"  endif
"endfunction
" used to track the quickfix window
"augroup QFixToggle
" autocmd!
" autocmd BufWinEnter quickfix let g:qfix_win = bufnr("$")
" autocmd BufWinLeave * if exists("g:qfix_win") && expand("<abuf>") == g:qfix_win | unlet! g:qfix_win | endif
"augroup END
"Toggle quickfixwindow
let g:quickfix_is_open = 0
function! QuickfixToggle()
    if g:quickfix_is_open
        cclose
        let g:quickfix_is_open = 0
    else
        copen
        let g:quickfix_is_open = 1
    endif
endfunction

au WinLeave * if getbufvar(winbufnr(winnr()), "&buftype") == "quickfix" |cclose|let g:quickfix_is_open = 0|endif

nnoremap <silent> <F8> :call QuickfixToggle()<CR>

"switch to previous tab
let g:lasttab = 1
nmap <C-b> :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

set cst
set cspc=5
set cscopequickfix=g-,s-,c-,d-,i-,t+,e-
set ofu=syntaxcomplete#Complete
set csto=1

nmap <Leader>h :set hls!<CR>:set hls?<CR>
set hlsearch
set incsearch
set ic "case insensitive search

"set switchbuf=newtab
nmap <Leader>+ :set switchbuf+=newtab<CR>
nmap <Leader>_ :set switchbuf-=newtab<CR>
nmap <Leader>- :set switchbuf-=usetab<CR>
nmap <Leader>= :set switchbuf+=usetab<CR>

colors wombat256mod

"map <F2> :wall \| sil make \| redr! <CR> :cw <CR>
"nnoremap <F2> :wall \| sil make -C $kernel M=`pwd` modules \| redr! <CR> :cw <CR>
"nnoremap <F5> :wall \| sil! make zImage \| !beep <CR>
"map <F3> :w \| sil make \| redr! <CR> :cw <CR>

"Tagbar
"let g:tagbar_autoshowtag = 1
"let g:tagbar_foldlevel = 2
"let g:tagbar_autofocus = 1
"let g:tagbar_autoclose = 1
"let g:tagbar_left = 1
"nnoremap <silent> <F10> :TagbarToggle<CR>

"Tlist
nnoremap <silent> <F10> :TlistToggle<CR>
let Tlist_Use_Right_Window = 1
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Close_On_Select = 1
let Tlist_Enable_Fold_Column = 0
let Tlist_File_Fold_Auto_Close = 1


"NERDTree
nnoremap <silent> <F9> :NERDTreeToggle<CR>
let NERDTreeQuitOnOpen=1

"cscope
nmap <C-_>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-_>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-_>d :cs find d <C-R>=expand("<cword>")<CR><CR>

nmap <C-\>s :tab cs f s <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>g :tab cs f g <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>c :tab cs f c <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>t :tab cs f t <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>e :tab cs f e <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>f :tab cs f f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-\>i :tab cs f i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-\>d :tab cs f d <C-R>=expand("<cword>")<CR><CR>

" Using 'CTRL-spacebar' then a search type makes the vim window
" split horizontally, with search result displayed in
" the new window.
nmap <C-Space>s :scs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space>g :scs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space>c :scs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space>t :scs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space>e :scs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space>f :scs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-Space>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-Space>d :scs find d <C-R>=expand("<cword>")<CR><CR>
"
" Hitting CTRL-space *twice* before the search type does a vertical
" split instead of a horizontal one
nmap <C-Space><C-Space>s
	\:vert scs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space><C-Space>g
	\:vert scs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space><C-Space>c
	\:vert scs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space><C-Space>t
	\:vert scs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space><C-Space>e
	\:vert scs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space><C-Space>i
	\:vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-Space><C-Space>d
	\:vert scs find d <C-R>=expand("<cword>")<CR><CR>

"Mark plugin
set viminfo+=! "ability to save marks
let g:mwAutoLoadMarks = 1
let g:mwAutoSaveMarks = 1

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

"подсветка выхода за рамки
set cc=80
set cul
"hi ColorColumn ctermfg=red

"для утилиты find
set path+=**

"поддержка синтаксиса для разных расширений
"autocmd BufEnter *.aidl set filetype=java
autocmd BufEnter .workrc call SetFileTypeSH("bash")
autocmd BufEnter .commonrc call SetFileTypeSH("bash")
autocmd BufEnter *.exp set filetype=tcl
"autocmd BufEnter *.ptl set filetype=python
"autocmd BufEnter *.pti set filetype=python
"autocmd BufEnter *.sh colors xoria256

"autocmd BufEnter *.c set shiftwidth=8
"autocmd BufEnter *.h set tabstop=8

"подсветка переменных
"autocmd CursorMoved * silent! exe printf("match IncSearch /\\<%s\\>/", expand('<cword>'))

"подсветка пустых символов
set list
"set listchars=tab:··
set listchars=tab:│\ 
"set listchars=tab:\|-
"set listchars=tab:>-
set listchars+=trail:·

"discard highlighting
nnoremap <silent> <Space> :nohlsearch<Bar>:match<Bar>:echo<CR>
" highlight word under cursor and same words in whole text
map <F2> :silent! exe printf("match IncSearch /\\<%s\\>/", expand('<cword>'))<CR>

" make and run
map <F5> :w \| silent! make \| redr!<CR>
map <F6> :!a.out; rm a.out<CR>
map <F7> :!%< <CR>
map <F11> :!cscreate.sh <CR><CR>

"Hex editor
map <Leader>hon :%!xxd<CR>
map <Leader>hof :%!xxd -r<CR>

" Enable file type detection.
" Use the default filetype settings, so that mail gets 'tw' set to 72,
" 'cindent' is on in C files, etc.
" Also load indent files, to automatically do language-dependent indenting.
filetype plugin indent on

" XML stuff
let g:xml_syntax_folding = 1
"au FileType xml setlocal foldmethod=syntax

set nowrap

" LaTeX
au FileType tex set makeprg=pdflatex\ %

" Work specific commands
"autocmd BufRead MtilAPI.h :TagbarTogglePause

"grep
nnoremap gr :vimgrep <cword> **<CR>
