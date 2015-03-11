func! beautifiers#defaults#init()
    if !exists('g:beautify')
        let g:beautify = {}
    endif

    " Beautifier definitions
    if !exists('g:beautify.definitions')
        let g:beautify.definitions = {}
    endif

    let definitions = {
        \ 'astyle': {
            \ 'filetypes': ['c', 'cs', 'cpp', 'java'],
            \ 'bin':       'astyle',
            \ 'install':   function('beautifiers#astyle#install'),
            \ 'run':       function('beautifiers#astyle#run'),
        \ },
        \ 'gofmt': {
            \ 'filetypes': ['go'],
            \ 'bin':       'gofmt',
            \ 'install':   function('beautifiers#gofmt#install'),
            \ 'run':       function('beautifiers#gofmt#run'),
        \ },
        \ 'css-beautify': {
            \ 'filetypes': ['css'],
            \ 'bin':       'css-beautify',
            \ 'install':   function('beautifiers#cssbeautify#install'),
            \ 'run':       function('beautifiers#cssbeautify#run'),
        \ },
        \ 'html-beautify': {
            \ 'filetypes': ['html', 'xml'],
            \ 'bin':       'html-beautify',
            \ 'install':   function('beautifiers#htmlbeautify#install'),
            \ 'run':       function('beautifiers#htmlbeautify#run'),
        \},
        \ 'js-beautify': {
            \ 'filetypes': ['javascript', 'json'],
            \ 'bin':       'js-beautify',
            \ 'install':   function('beautifiers#jsbeautify#install'),
            \ 'run':       function('beautifiers#jsbeautify#run'),
        \ },
        \ 'node': {
            \ 'filetypes': ['json'],
            \ 'bin':       'node',
            \ 'install':   function('beautifiers#node#install'),
            \ 'run':       function('beautifiers#node#run'),
        \},
        \ 'uglifyjs': {
            \ 'filetypes': ['javascript', 'json'],
            \ 'bin':       'uglifyjs',
            \ 'install':   function('beautifiers#uglifyjs#install'),
            \ 'run':       function('beautifiers#uglifyjs#run'),
        \},
        \ 'autopep8': {
            \ 'filetypes': ['python'],
            \ 'bin':       'autopep8',
            \ 'install':   function('beautifiers#autopep8#install'),
            \ 'run':       function('beautifiers#autopep8#run'),
        \ },
        \ 'docformatter': {
            \ 'filetypes': ['python'],
            \ 'bin':       'docformatter',
            \ 'install':   function('beautifiers#docformatter#install'),
            \ 'run':       function('beautifiers#docformatter#run'),
        \ },
        \ 'json.tool': {
            \ 'filetypes': ['json'],
            \ 'bin':       'python',
            \ 'install':   function('beautifiers#jsontool#install'),
            \ 'run':       function('beautifiers#jsontool#run'),
        \ },
        \ 'tidy': {
            \ 'filetypes': ['html', 'xml'],
            \ 'bin':       'tidy',
            \ 'install':   function('beautifiers#tidy#install'),
            \ 'run':       function('beautifiers#tidy#run'),
        \ },
    \ }

    for k in keys(definitions)
        if !has_key(g:beautify.definitions, k)
            let g:beautify.definitions[k] = definitions[k]
        endif
    endfor

    " Create a map of all known filetype -> beautifiers
    if !exists('g:beautify.filetypes')
        let g:beautify.filetypes = {}
    endif

    for [name, definition] in items(g:beautify.definitions)
        for ft in definition.filetypes
            if !has_key(g:beautify.filetypes, ft)
                let g:beautify.filetypes[ft] = []
            endif

            call add(g:beautify.filetypes[ft], name)
        endfor
    endfor

    " Which beautifiers to use by default for a given language
    if !exists('g:beautify.beautifiers')
        let g:beautify.beautifiers = {}
    endif

    " Default to first defined beautifier for filetype
    let beautifiers = {}
    for [k, v] in items(g:beautify.filetypes)
        let beautifiers[k] = v[0]
    endfor

    " Override defaults
    let override = {
        \ 'html':       ['html-beautify'],
        \ 'javascript': ['js-beautify'],
        \ 'json':       ['node'],
        \ 'python':     ['autopep8', 'docformatter'],
    \ }

    for [k, v] in items(override)
        let beautifiers[k] = v
    endfor

    " Update global beautifiers
    for k in keys(beautifiers)
        if !has_key(g:beautify.beautifiers, k)
            let g:beautify.beautifiers[k] = beautifiers[k]
        endif
    endfor
endf
