if exists('g:loaded_unicode_table') || &compatible
	finish
endif

let g:loaded_unicode_table = 1


""""
"" global functions
""""
"{{{
" \brief	generate unicode table
"
" \param	a:1		start symbol value
" \param	a:2		number of symbols to print
" \param	a:3		buffer open command, e.g. split
function s:unicode_table(...)
	" init args
	let start = get(a:, "1", "0x21")
	let n = get(a:, "2", "128576")
	let open = get(a:, "3", "tabnew")
	
	" init loop variables
	let i = 0
	let j = 0
	let table = []
	call add(table, "")

	" open buffer
	exec open . " unicode-table"
	setlocal modifiable
	setlocal buftype=nofile bufhidden=hide buflisted noswapfile

	" create character map
	while i < n
		" get symbol hex code
		let hex = printf("%6.6x", start + i)

		" get symbol
		exec 'let sym ="' . printf('\U%s', hex) . '"'

		" generate row
		let table[j] .= hex . " " . sym . "  "

		" increment
		let i += 1

		" add new row to table
		if i % 10 == 0
			let j += 1
			call add(table, "")
		endif
	endwhile

	" add rows to buffer
	call append(0, table)
	silent! exec ":0"

	" set buffer options
	setlocal nomodified nomodifiable
endfunction
"}}}

""""
"" commands
""""
"{{{
command -nargs=* UnicodeTable call s:unicode_table(<f-args>)
"}}}
