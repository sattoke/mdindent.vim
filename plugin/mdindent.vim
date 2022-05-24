if exists('g:loaded_mdindent')
	finish
endif
let g:loaded_indent = 1

command! -range=% MDIndent <line1>,<line2>call mdindent#indent()
