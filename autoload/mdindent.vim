function! mdindent#indent() range abort
    let old_indents = [] " Indents before formatting. Indices indicate the level of indentation. Values indicate the amount of indentation.

    for lineno in range(a:firstline, a:lastline)
        if lineno ==# a:firstline
            call add(old_indents, indent(lineno))
            let prev_indent = indent(lineno)
        else
            let this_indent_level = 0
            let is_existing_level = 0
            let this_indent = indent(lineno)
            for i in range(len(old_indents))
                if this_indent ==# old_indents[i]
                    let this_indent_level = i
                    let is_existing_level = 1
                    break
                endif
            endfor

            if is_existing_level ==# 0
                if old_indents[-1] > this_indent
                    throw "Invalid indentation."
                endif

                call add(old_indents, indent(lineno))
                let this_indent_level = len(old_indents) - 1
            endif

            let base_indent = old_indents[0]
            let spaces = ""
            for j in range(base_indent + shiftwidth() * this_indent_level)
                let spaces .= " "
            endfor
            call setline(lineno, substitute(getline(lineno), '^\s*', spaces, ""))
        endif
    endfor
endfunction
