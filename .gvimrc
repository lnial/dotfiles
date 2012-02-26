set lines=60
set columns=200

if has('gui_macvim')
  "透明度設定
  "set transparency=20
  "カラー設定
	"colorscheme zellner
  "日本語
  "set noimdisableactivate
endif

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
set transparency=8


