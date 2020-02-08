scriptencoding utf-8
" Unique tag string generation plugin for Vim
" Author  : Koji Sato <litom501+vim@gmail.com>
" License : MIT License

let s:uniquetag_config_default = #{
      \   prefix: '[ID:',
      \   length: 4,
      \   suffix: ']'
      \ }

" 指定桁のランダムな文字列を返します
function! s:random_hex(len) abort
  let l:rv = ''
  let l:n = 0xff
  while len(l:rv) < a:len
    let seed = srand()
    let rand = rand(seed)
    let l:rv = l:rv . printf("%X", l:rand)
  endwhile
  return strpart(l:rv, 0, a:len)
endfunction


" 現在のバッファ内でユニークな文字列を生成します。
function! uniquetag#create(prefix, len, suffix) abort
  let l:rv = ''
  let l:trial = 0
  let l:save_cursor = getcurpos()

  while len(l:rv) == 0
    let l:v = a:prefix . s:random_hex(a:len) . a:suffix
    call cursor(1, 0)
    let l:match = search(escape(l:v, '\.*^$[!/'))
    if l:match == 0
      let l:rv = l:v
    else
      let l:trial = l:trial + 1
      if l:trial > 3
        :break
      endif
    endif
  endwhile

  call setpos('.', l:save_cursor)
  if l:trial > 3
    echoerr "couldn't generate a unique tag. trial exceeded."
  endif

  return l:rv
endfunction

function! uniquetag#tag() abort
  let config = get(g:uniquetag_config, '*', s:uniquetag_config_default)
  let config = get(b:, 'uniquetag_config', config)
  return uniquetag#create(config.prefix, config.length, config.suffix)
endfunction

" vim: tabstop=2 shiftwidth=2 expandtab
