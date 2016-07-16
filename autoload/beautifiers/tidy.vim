func! beautifiers#tidy#install()
    echoerr 'Please install html-tidy: https://github.com/w3c/tidy-html5'
endf

func! beautifiers#tidy#run(opts)
    let cmd = 'tidy'
    let args = [
        \ '-quiet',
        \ '-indent',
        \ '-modify',
        \ '-wrap 0',
        \ '--preserve-entities true',
        \ '--show-warnings false',
        \ '--fix-uri false',
        \ '--char-encoding utf8',
        \ '--input-encoding utf8',
        \ '--output-encoding utf8',
        \ '--ascii-chars true',
        \ '--fix-uri false',
        \ '--quote-ampersand false',
        \ '--vertical-space no',
        \ '--hide-comments false',
        \ '--doctype auto',
        \ '--tidy-mark false',
    \ ]

    " Simple heuristic to decide whether to show body or not. There is a
    " show-body-only auto setting, but it doesn't work very well.
    if match(getline(1,10), '<html') == -1
        call add(args, '--show-body-only true')
    endif

    call add(args, '-output '.a:opts.output)
    call add(args, a:opts.input)

    call beautify#system(cmd.' '.join(args))
endf
