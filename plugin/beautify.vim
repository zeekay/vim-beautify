if exists('g:loaded_beautify')
  finish
endif
let g:loaded_beautify = 1

call beautifiers#defaults#init()

command! -complete=customlist,beautify#complete -nargs=? -range=% Beautify :call beautify#command(<count>, <line1>, <line2>, <f-args>)
