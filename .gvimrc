set lines=60
set columns=200

set guifont=Ricty:h18.3
set guifontwide=Osaka-Mono:h16
"全角スペースを視覚化
highlight ZenkakuSpace cterm = underline ctermfg = lightblue guibg = #666666
au BufNewFile, BufRead * match ZenkakuSpace /　/
"set noimdisable
set imdisableactivate

colorscheme torte 
"colorscheme peaksea
"colorscheme getafe
"set transparency=8


" Mac の辞書.appで開く {{{
if has('mac')
    " 引数に渡したワードを検索
    command! -nargs=1 MacDict      call system('open '.shellescape('dict://'.<q-args>))
    " カーソル下のワードを検索
    command! -nargs=0 MacDictCWord call system('open '.shellescape('dict://'.shellescape(expand('<cword>'))))
    " 辞書.app を閉じる
    command! -nargs=0 MacDictClose call system("osascript -e 'tell application \"Dictionary\" to quit'")
    " 辞書にフォーカスを当てる
    command! -nargs=0 MacDictFocus call system("osascript -e 'tell application \"Dictionary\" to activate'")
    " キーマッピング
    nnoremap <silent><Leader>do :<C-u>MacDictCWord<CR>
    vnoremap <silent><Leader>do y:<C-u>MacDict<Space><C-r>*<CR>
    nnoremap <silent><Leader>dc :<C-u>MacDictClose<CR>
    nnoremap <silent><Leader>df :<C-u>MacDictFocus<CR>
endif
"}}}
