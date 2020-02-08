scriptencoding utf-8
" Unique tag string generation plugin for Vim
" Author  : Koji Sato <litom501+vim@gmail.com>
" License : MIT License

let s:save_cpo = &cpo
set cpo&vim

if exists('g:loaded_uniquetag')
  finish
endif
let g:loaded_uniquetag = 1

function! s:configure() abort
  let filetype = &filetype
  if exists('g:uniquetag_config')
    if has_key(g:uniquetag_config, filetype)
      let b:uniquetag_config = copy(g:uniquetag_config[filetype])
    endif
  endif
endfunction

augroup uniquetag
  autocmd!
  autocmd FileType * call s:configure()
augroup END

inoremap <expr> <Plug>(uniquetag-insert-tag) uniquetag#tag()
command! UniqueTag silent normal a<C-R>=uniquetag#tag()<ESC>

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: tabstop=2 shiftwidth=2 expandtab
