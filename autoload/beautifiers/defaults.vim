func! beautifiers#defaults#init()
    if !exists('g:beautify')
        let g:beautify = {}
    endif

    for k in ['beautifiers', 'definitions', 'filetypes']
        if !has_key(g:beautify, k)
            let g:beautify[k] = {}
        endif
    endfor

    " Default beautifier definitions
    let beautifier_defs = {
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
            \ 'filetypes': ['html', 'xml', 'html.handlebars'],
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
            \ 'args':      '--aggressive --aggressive',
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
        \ 'tsfmt': {
            \ 'filetypes': ['typescript'],
            \ 'bin':       'tsfmt',
            \ 'install':   function('beautifiers#tsfmt#install'),
            \ 'run':       function('beautifiers#tsfmt#run'),
            \ 'inplace':   1,
        \ },
    \ }

    " Overrides for default beautifier per filetype
    let overrides = {
        \ 'html':       ['html-beautify'],
        \ 'javascript': ['js-beautify'],
        \ 'json':       ['node'],
        \ 'python':     ['autopep8', 'docformatter'],
    \ }

    " Update definitions with defaults
    for [name, def] in items(beautifier_defs)
        " No definition globally, add default
        if !has_key(g:beautify.definitions, name)
            let g:beautify.definitions[name] = def
            continue
        endif

        " Update existing definition with any missing values
        for [k,v] in items(def)
            if !has_key(g:beautify.definitions[name], k)
                let g:beautify.definitions[name][k] = v
            endif
        endfor
    endfor

    " Create a map of all known filetype -> beautifiers
    for [name, definition] in items(g:beautify.definitions)
        for ft in definition.filetypes
            if !has_key(g:beautify.filetypes, ft)
                let g:beautify.filetypes[ft] = []
            endif

            call add(g:beautify.filetypes[ft], name)
        endfor
    endfor

    " Which beautifiers to use by default for a given language.
    let beautifiers = {}
    for [k, v] in items(g:beautify.filetypes)
        " Use first defined beautifier by default
        let beautifiers[k] = v[0]
    endfor

    " Override defaults per filetype in a few cases
    for [k, v] in items(overrides)
        let beautifiers[k] = v
    endfor

    " Update global per-filetype preferences
    for k in keys(beautifiers)
        if !has_key(g:beautify.beautifiers, k)
            let g:beautify.beautifiers[k] = beautifiers[k]
        endif
    endfor
endf
