func beautifiers#gofmt#install()
    echerr 'Unable to beautify, please install gofmt!'
endf

func! beautifiers#gofmt#run(opts)
    let view = winsaveview()

    " If spaces are used for indents, configure gofmt
    if &expandtab
        let tabs = ' -tabs=false -tabwidth=' . (&sw ? &sw : (&sts ? &sts : &ts))
    else
        let tabs = ''
    endif

    silent! execute "silent! %!" . g:gofmt_command . tabs
    redraw!

    if v:shell_error
        let errors = []
        for line in getline(1, line('$'))
            let tokens = matchlist(line, '^\(.\{-}\):\(\d\+\):\(\d\+\)\s*\(.*\)')
            if !empty(tokens)
                call add(errors, {"filename": @%,
                                 \"lnum":     tokens[2],
                                 \"col":      tokens[3],
                                 \"text":     tokens[4]})
            endif
        endfor
        if empty(errors)
            % | " Couldn't detect gofmt error format, output errors
        endif
        undo
    endif
    call winrestview(view)
endf
