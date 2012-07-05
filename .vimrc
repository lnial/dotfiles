"vimrc
syntax on
set number

"MacVimのメニューを表示しない"{{{
set guioptions-=T
"インデントはスマートインデント
set smartindent
"検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase
"検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
"検索時に最後まで行ったら最初に戻る
set wrapscan
"検索文字列入力時に順次対象文字列にヒットさせない
set noincsearch
"入力中のコマンドをステータスに表示する
set showcmd
"括弧入力時の対応する括弧を表示
set showmatch
"ステータスラインを常に表示
set laststatus=2
" コマンドライン補間をシェルっぽく
set wildmode=list:longest
" バッファが編集中でもその他のファイルを開けるように//一時保存せずにファイルを開ける
set hidden
" 外部のエディタで編集中のファイルが変更されたら自動で読み直す
set autoread
"マーカー文字列を埋め込んで、ソースコードを折り畳み表示する
set foldmethod=marker
"バックスペースの挙動を改善する。
set backspace=eol,indent,start
"検索時に、ヒットした単語をハイライトする設定
set hlsearch
" 自動的にインデントする設定（迷惑？）
set autoindent
"デフォルト文字コード UTF-8
set encoding=utf-8
set clipboard+=autoselect      " visual selection -> clipboard
set clipboard+=unnamed         " yank -> clipboard
"常にカーソルが真ん中になる
set scrolloff=1000

"カーソルの行と列をハイライト
set cursorline
set cursorcolumn
set colorcolumn=80
"新しいウィンドウを右に開く
set splitright

"highlight CursorLine term = underline cterm = underline guibg = #ff6347

set antialias
set iminsert=0 imsearch=0

" ファイル関連
"set nobackup   " バックアップ取らない
set backupdir=~/temp
set undodir=~/temp/undo// 
set autoread   " 他で書き換えられたら自動で読み直す
set noswapfile " スワップファイル作らない
set hidden     " 編集中でも他のファイルを開けるようにする

" tab
" =====================================================
set expandtab           "タブをスペースに置き換える
set tabstop=4           "ファイル内の <Tab> が対応する空白の数
set shiftwidth=4        "自動インデントの各段階に使われる空白の数
set softtabstop=0       "<Tab>を押した時に挿入される空白の量(0:ts'で指定した量
set shiftround          "インデントを'shiftwidth' の値の倍数に丸める
"Escの2回押しでハイライト消去
nmap <ESC><ESC> ;nohlsearch<CR><ESC>
nmap ,w :cw<CR>

" 補完候補の色づけ for vim7
"hi Pmenu        ctermfg=Black ctermbg=Grey
"hi PmenuSel     ctermbg=Blue
"hi PmenuSbar    ctermbg=Cyan

"}}}

"""----keymap------"""""{{{
" =====================================================
nnoremap j gj
nnoremap k gk
nnoremap J gJ
nnoremap <Down> g<Down>
nnoremap <Up> g<Up>
nnoremap H ^
nnoremap L g_

inoremap <C-a> <esc>I
inoremap <C-e> <esc>A

inoremap <C-d> <BS>
inoremap <C-f> <Right>
inoremap <C-b> <Left>
inoremap <C-d> <Del>

" 検索語が画面の真ん中に来るようにする
" nmap n nzz 
" nmap N Nzz 
nmap * *zz 
nmap # #zz 
nmap g* g*zz 
nmap g# g#zz

" date/time
inoremap ,date <C-R>=strftime('%Y/%m/%d %H:%M:%S')<CR>
"inoremap ,time <C-R>=strftime('%H:%M')<CR>
"inoremap ,w3cd <C-R>=strftime('%Y-%m-%dT%H:%M:%S+09:00')<CR>


"windowsのgvimで日本語入力を使いやすくする[http://d.hatena.ne.jp/fuenor/20090416/1239834980]
"挿入モード終了時にIME状態を保存しない
inoremap <silent> <ESC> <ESC>
inoremap <silent> <C-[> <ESC>
"IMEモード固定
inoremap <silent> <C-j> <C-^>
"日本語の行の連結時には空白を入力しない。
set formatoptions+=mM

map , <Leader>
map <F2> :bn<CR>
map <F4> :bd<CR>
imap <C-j> <C-[>

nnoremap ,v :vsp<CR>
nnoremap ,s :source ~/.vimrc<CR>
nnoremap ,t :Tlist<CR>
nnoremap ,m :make<CR>
nnoremap <silent> <Leader>/ :execute 'vimgrep /'.@/.'/g %'<CR>:copen<CR>
nnoremap <silent> <Leader>g :vimgrep /main/j **/*.
nnoremap <silent> <Leader>o :!open -a iTerm ./<CR>
"folding
nnoremap <Leader>z zMzvzz

"move window"
nnoremap { 4<c-w>>  
nnoremap } 4<c-w><   
nnoremap + 4<c-w>+ 
nnoremap - 4<c-w>-
"not recoard"
nnoremap q :q<CR>

"" Vim(Mac)Copy&Paste
nmap - :set paste<CR>:r !pbpaste<CR>:set nopaste<CR>
nmap _ :.w !pbcopy<CR><CR>
vmap _ :w !pbcopy<CR><CR>


"}}}

"""----filetype------"""""{{{
" =====================================================
"Objective-Cを認識設定
let g:filetype_m = 'objc'

"言語毎の設定
"
"php
autocmd filetype php :set makeprg=php\ -l\ %
autocmd filetype php :set errorformat=%m\ in\ %f\ on\ line\ %l
autocmd filetype php  nmap ,l :call PHPLint()<CR>
"文字列中のHTMLをハイライト
let php_htmlInStrings = 1
"文字列中のSQLをハイライト
let php_sql_query = 1
"勝手にfoldingしてくれる
let php_folding = 1
"au Syntax php set fdm = syntax
" PHPLint
function! PHPLint()
  let result = system( &ft . ' -l ' . bufname(""))
  echo result
endfunction



"python
autocmd filetype python :nmap <F3> :PythonFindDefinition<CR>
autocmd filetype py :imap ; :
augroup SetShebang
    autocmd! SetShebang
    autocmd BufNewFile *.py 0put =\"# -*- encoding: UTF-8 -*-\"|$
augroup END



"}}}

"""----plugin------"""""{{{
" =====================================================
"
"
"------------------------------------
"""Vundle"""
"------------------------------------
set nocompatible
filetype off                   " (1)
set rtp+=~/.vim/vundle.git/    " (2)
call vundle#rc()               " (3)
" " original repos on github
" Bundle 'tpope/vim-fugitive'
" 
" " vim-scripts repos
" Bundle 'rails.vim'
Bundle 'git://github.com/Shougo/unite.vim.git'
"Bundle 'git://github.com/vim-scripts/CD.vim.git'
Bundle 'git://github.com/chrismetcalf/vim-yankring.git'
Bundle 'git://github.com/Shougo/neocomplcache.git'
Bundle 'git://github.com/vim-scripts/taglist.vim.git'
Bundle 'git://github.com/vim-scripts/surround.vim.git'
Bundle 'git://github.com/vim-scripts/The-NERD-tree.git'
Bundle 'git://github.com/vim-scripts/The-NERD-Commenter.git'
Bundle 'git://github.com/vim-scripts/smartchr.git'
Bundle 'git://github.com/motemen/git-vim.git'
Bundle 'git://github.com/fuenor/qfixhowm.git'
Bundle 'git://github.com/vim-scripts/python.vim.git'
"Bundle 'git://github.com/ujihisa/quickrun.git'
Bundle 'git://github.com/thinca/vim-quickrun.git'
Bundle 'git://github.com/thinca/vim-ref.git'
Bundle 'git://github.com/vim-scripts/cursoroverdictionary.git'
Bundle 'git://github.com/vim-scripts/CTAGS-Highlighting.git'
Bundle 'git://github.com/vim-scripts/python_fold.git'
Bundle 'git://github.com/mileszs/ack.vim.git'
"Bundle 'git://github.com/fs111/pydoc.vim.git'
Bundle 'git://github.com/nathanaelkane/vim-indent-guides.git'
Bundle 'git://github.com/Shougo/vimfiler.git'
Bundle 'git://github.com/h1mesuke/vim-alignta.git'
Bundle 'git://github.com/plasticboy/vim-markdown.git'
Bundle 'git://github.com/Lokaltog/vim-powerline.git'
Bundle 'git://github.com/larssmit/vim-getafe.git'
Bundle 'git://github.com/Shougo/vimproc.git'
Bundle 'TaskList.vim'
Bundle 'git://github.com/scrooloose/syntastic.git'
Bundle 'git://github.com/hotoo/template.vim.git'
Bundle 'git://github.com/sjl/vitality.vim.git'
Bundle 'sontek/rope-vim'
Bundle 'git://github.com/kien/ctrlp.vim.git'
Bundle 'git://github.com/tyru/open-browser.vim.git'
Bundle 'git://github.com/alfredodeza/pytest.vim.git'
Bundle 'git://github.com/msanders/cocoa.vim.git'
Bundle 'git://github.com/yuratomo/w3m.vim.git'
"Bundle 'git://github.com/tpope/vim-fugitive.git'
"Bundle 'git://github.com/klen/python-mode.git'

"Bundle ''

"ftpluginにおかないとダメみたいなので，Bundleでインストールしない
"Bundle 'git://github.com/djmitche/pyflakes-vim.git'

" " non github repos
Bundle 'git://github.com/Shougo/vimshell.git'
" Bundle 'git://github.com/Shougo/vimproc.git'
"
filetype plugin indent on

"------------------------------------
"""taglist option"""
"------------------------------------
let Tlist_Use_Right_Window = 1
let Tlist_File_Fold_Auto_Close = 1
let tlist_objc_settings = 'objc;P:protocols;i:interfaces;I:implementations;M:instance methods;C:implementation methods;Z:protocol methods'

"------------------------------------
"""QFixHown"""
"------------------------------------
"qfixappにruntimepathを通す(パスは環境に合わせてください)
"set runtimepath+=~/.vim/plugin/qfixapp
"キーマップリーダー
let QFixHowm_Key = 'g'
"howm_dirはファイルを保存したいディレクトリを設定。
" QFixHowmのファイルタイプ
let QFixHowm_FileType    = 'markdown'
let howm_dir             = '~/Dropbox/memo/'
let howm_filename        = '%Y/%m/%Y-%m-%d-%H%M%S.mkd'
let howm_fileencoding    = 'utf-8'
let howm_fileformat      = 'unix'
"サブメニューで表示するファイル名
let SubWindow_Title = '~/__submenu__.howm'
"サブメニューの幅指定
let SubWindow_Width = 40
" タイトル記号
let QFixHowm_Title = '#'

"------------------------------------
"change pwd "
"------------------------------------
command! -nargs=? -complete=dir -bang CD  call s:ChangeCurrentDir('<args>', '<bang>') 
function! s:ChangeCurrentDir(directory, bang)
    if a:directory == ''
        lcd %:p:h
    else
        execute 'lcd' . a:directory
    endif
    if a:bang == ''
        pwd
    endif
endfunction

function! ChangeLogPrintTimeStamp()
    let now = localtime()
    let date  = strftime("[%H:%M:] ", now)
    execute "normal! a".date
endfunction

"{{{" YankRing.vim
nnoremap <silent> <F6> :YRShow<cr>
function! YRRunAfterMaps()
    nnoremap Y :<C-U>YRYankCount 'y$'<CR>
    omap <expr> L YRMapsExpression("",  "$")
    omap <expr> H YRMapsExpression("",  "^")
endfunction

" }}}
"
"------------------------------------
"NERDTree 
"------------------------------------
let g:NERDTreeWinSize = 25
noremap ,n :<C-u>CD<CR>:NERDTree ./<CR><C-w><C-w>
vmap \ "+y

"------------------------------------
"unite.vim
"------------------------------------
let g:unite_source_file_mru_time_format = ''
let g:unite_enable_start_insert = 1
let g:unite_source_file_mru_ignore_pattern='.*\/$\|.*Application\ Data.*'
nnoremap ,<C-r>  :<C-u>Unite file_mru<CR>
nnoremap ,<C-b>  :<C-u>Unite buffer <CR>
nnoremap ,<C-d>  :<C-u>Unite file<CR>
nnoremap ,\  :<C-u>Unite buffer <CR>
nnoremap [I  :<C-u>UniteWithCursorWord -no-quit line<CR>
"nnoremap <silent> <Leader>b :<C-u>Unite bookmark<CR>
"nnoremap <silent> <Leader>u  :<C-u>Unite buffer file_mru bookmark file<CR>
nnoremap <Leader>f  :<C-u>Unite file_rec -input=
autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
    imap <buffer> jj <Plug>(unite_insert_leave)
    imap <buffer> <C-j> <Plug>(unite_exit)
    imap <buffer> <ESC> <Plug>(unite_exit)
    imap <buffer> <C-o> <Plug>(unite_insert_leave):<C-u>call unite#mappings#do_action('above')<CR>
endfunction

" autocmd FileType vimshell call s:vimshell_my_settings()
" function! s:vimshell_my_settings()
"     inoremap <buffer> <C-x> <ESC><C-w>h:on<CR>
"     inoremap <buffer> <silent> <C-n>  <ESC>:<C-u>Unite buffer <CR>
"     inoremap <buffer> <silent> <C-r>  <ESC>:<C-u>Unite file_mru <CR>
"     nnoremap <buffer> <CR> Go$ 
"     imap <buffer> <C-x>     <ESC><C-w>h:on<CR>
"     nnoremap <buffer><silent> <C-n>  :<C-u>Unite buffer <CR>
"     inoremap <C-v> <C-R>+
"     inoremap <buffer><expr><C-h> pumvisible() ? "\<C-y>\<C-h>" : "\<C-h>"
"     imap <buffer> <C-o> <Plug>(vimshell_enter)
"     inoremap <buffer> <C-l> <C-y>
"     imap <buffer> <C-s> <Plug>(vimshell_history_complete_whole)
"     NeoComplCacheAutoCompletionLength 3
" endfunction

"------------------------------------
"neocomplcache.vim
"------------------------------------
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_underbar_completion = 1

"neocomplcache snippet
imap <C-k> <Plug>(neocomplcache_snippets_expand)
smap <C-k> <Plug>(neocomplcache_snippets_expand)


"------------------------------------
"Changelog setting 
"but Not plugin
"------------------------------------
let g:changelog_timeformat = "%Y-%m-%d"
let g:changelog_username = ":-)"
nnoremap <Leader>c :new ~/Dropbox/memo/changelog<cr>

"------------------------------------
"Alignta setting
"------------------------------------
"let g:alignta_default_options
"xnoremap <silent> A  :Alignta  = >\ = <CR>
xnoremap <silent> a:  :Alignta  = >\ = <CR>
xnoremap <silent> A: :Alignta  01 :<CR>
xmap <silent><expr> as mode() ! = # 'v' ? ':Alignta \S\ + '."\<CR>" : 'as'
xnoremap al :Alignta<Space>

"------------------------------------
"Powerline
"------------------------------------
let g:Powerline_symbols  =  'fancy'

"------------------------------------
"smartchr setting
"------------------------------------
" 演算子の間に空白を入れる
"inoremap <expr> < search('^#include\%#', 'bcn')? ' <': smartchr#one_of(' < ', ' << ', '<')
"inoremap <expr> > search('^#include <.*\%#', 'bcn')? '>': smartchr#one_of(' > ', ' >> ', '>')
"inoremap <expr> = smartchr#one_of(' = ', ' == ', ' === ', '=')
inoremap <expr> + smartchr#one_of(' + ', '++', '+')
inoremap <expr> - smartchr#one_of('-', ' - ', '--', '-')
"inoremap <expr> / smartchr#one_of('/',' / ', '//', '/* ','/')
inoremap <expr> * smartchr#one_of('*', '**', ' */','/')
inoremap <expr> ( search('\<\if\%#', 'bcn')? ' (': '('
inoremap <expr> = search('\(&\<bar><bar>\<bar>+\<bar>-\<bar>/\<bar>>\<bar><\) \%#', 'bcn')? '<bs>= '
\ : search('\(*\<bar>!\)\%#', 'bcn')? '= '
\ : smartchr#one_of(' = ', ' == ', ' === ','=')
inoremap <expr> & smartchr#one_of(' &', '&')
inoremap <expr> , smartchr#one_of(', ', ',')
"inoremap <expr> { smartchr#one_of('{<CR> ', '{')

" 下記の文字は連続して現れることがまれなので、二回続けて入力したら改行する
"inoremap <expr> } smartchr#one_of('}<CR>', '}')
"inoremap <expr> ; smartchr#one_of(';', ';<cr>')


"------------------------------------
"git.vim
"------------------------------------
let g:git_no_map_default  =  1
let g:git_command_edit  =  'rightbelow vnew'
nnoremap <Space>gD :<C-u>GitDiff --cached<Enter>
nnoremap <Space>gd :<C-u>GitDiff<Enter>
nnoremap <Space>gs :<C-u>GitStatus<Enter>
nnoremap <Space>gl :<C-u>GitLog<Enter>
nnoremap <Space>gL :<C-u>GitLog -u \| head -10000<Enter>
nnoremap <Space>ga :<C-u>GitAdd<Enter>
nnoremap <Space>gA :<C-u>GitAdd <cfile><Enter>
nnoremap <Space>gc :<C-u>GitCommit<Enter> 
nnoremap <Space>gC :<C-u>GitCommit --amend<Enter> 
nnoremap <Space>gp :<C-u>Git push origin master

"------------------------------------
"pyflakes.vim
"------------------------------------
let g:pyflakes_use_quickfix  =  1
filetype on            " enables filetype detection
filetype plugin on     " enables filetype specific plugins

"------------------------------------
"gtags.vim
"------------------------------------
" gtags
" 検索結果Windowを閉じる
nnoremap <C-q> <C-w><C-w><C-w>q
" Grep 準備
nnoremap <C-g> :Gtags -g
" このファイルの関数一覧
nnoremap <C-l> :Gtags -f %<CR>
" カーソル以下の定義元を探す
nnoremap <C-j> :Gtags <C-r><C-w><CR>
" カーソル以下の使用箇所を探す
nnoremap <C-k> :Gtags -r <C-r><C-w><CR>
" 次の検索結果
nnoremap <C-n> :cn<CR>
" 前の検索結果
nnoremap <C-p> :cp<CR>

"------------------------------------
"eclim.vim
"------------------------------------
"command -range -nargs=* Google call eclim#web#SearchEngine(
  "\ 'http://www.google.com/search?q=<query>', <q-args>, <line1>, <line2>)
"nnoremap <silent> <C-F8> :call eclim#vimplugin#FeedKeys('Meta+F8')<cr>


"------------------------------------
"indent_guide.vim
"------------------------------------
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 4
hi IndentGuidesOdd  guibg = red   ctermbg = 3
hi IndentGuidesEven guibg = green ctermbg = 4


"------------------------------------
"quickrun.vim
"------------------------------------
let g:quickrun_config  =  {}
let g:quickrun_config['_']  =  {}
let g:quickrun_config['_']['runner']  =  'vimproc'
let g:quickrun_config['_']['runner/vimproc/updatetime']  =  100
let g:quickrun_config['_'] = {'runmode': "async:remote:vimproc",  'split': 'below'}
"let g:quickrun_config      = {}
"let g:quickrun_config._    = {'runner' : 'vimproc'}

"------------------------------------
"tasklist.vim
"------------------------------------
nnorem ,l :TaskList<CR>

"------------------------------------
"pydoc.vim
"------------------------------------
let g:pydoc_cmd = "/Users/lnial/bin/pydoc"
let g:ref_open  =  'vsplit'


"------------------------------------
"syntastic.vim
"------------------------------------
let g:syntastic_enable_signs = 1
let g:syntastic_auto_loc_list = 2

"------------------------------------
"Vimshell.vim
"------------------------------------
",is:
nnoremap <silent> ,is :VimShell<CR>
let g:vimshell_split_command = "vsplit"

"------------------------------------
"python-mode.vim
"------------------------------------

"}}}
