" Slightly safer system() that will report errors nicely
func! beautify#system(cmd)
    silent let err = system(a:cmd)
    if err != ""
        echo '!'.a:cmd
        for line in split(err, '\n')
            echo line
        endfor
        let bin = split(a:cmd, ' ')[0]
        throw bin.' failed to execute: '.err
    endif
endf

func! beautify#write_tmpfile(opts)
    let firstline = a:opts.firstline
    let lastline  = a:opts.lastline

    " get new temp file name
    let tmpfile = tempname()

    " write temp file
    silent! exe firstline.','.lastline.'w '.tmpfile

    return tmpfile
endf

func! beautify#read_tmpfile(opts)
    let firstline    = a:opts.firstline
    let lastline     = a:opts.lastline
    let tmpfile      = a:opts.tmpfile
    let is_range     = a:opts.is_range
    let cursorline   = a:opts.cursorline

    " Get last line in file
    let endline = getline('$')

    " Delete existing lines
    exe firstline.','.lastline.'d'

    " Instert new lines, offset by 1 to prevent empty line
    let line = firstline - 1
    silent! exe line.'r '.tmpfile

    " Trim extraneous newline which can be added under certain circumstances.
    if endline != "" && getline('$') == ""
        normal Gdd
    endif
endf

func! beautify#get_definition(beautifier)
    if type(a:beautifier) == type("")
        if has_key(g:beautify.definitions, a:beautifier)
            return g:beautify.definitions[a:beautifier]
        else
            return {}
        endif
    endif

    return a:beautifier
endf

func! beautify#get_definitions(beautifiers)
    " Get definitions for beautifiers
    let definitions = []

    for b in a:beautifiers
        call add(definitions, beautify#get_definition(b))
    endfor

    return definitions
endf

func! beautify#get_beautifiers(filetype)
    if !has_key(g:beautify.beautifiers, a:filetype)
        throw 'No known beautifier for '.a:filetype
    endif

    let beautifiers = g:beautify.beautifiers[a:filetype]

    " Beautifiers should always be a list of beautifiers
    if type(beautifiers) != type([])
        return [beautifiers]
    else
        return beautifiers
    endif
endf

" Main entry point
func! beautify#command(count, first, last, ...) range
    let beautifiers = []
    let filetype    = &filetype

    " Filetype or beautifier can be optionally specified
    if a:0
        if has_key(g:beautify.definitions, a:1)
            " Beautifier to use was explicitly listed
            let beautifiers = [beautify#get_definition(a:1)]
        else
            " Filetype was specified
            let filetype = a:1
        endif
    endif

    " Try to get definitions for this filetype
    if empty(beautifiers)
        let beautifiers = beautify#get_definitions(beautify#get_beautifiers(filetype))
    endif

    if empty(beautifiers)
        echoerr 'Unable to determine filetype or beautifier to use, please specifiy.'
        return
    endif

    " Disable autocommands while beautifiers are running! Otherwise madness.
    let oldei = &eventignore
    let &eventignore = 'all'
    try
        call beautify#run({
            \ 'beautifiers':  beautifiers,
            \ 'filetype':     filetype,
            \ 'firstline':    a:first,
            \ 'lastline':     a:last,
            \ 'count':        a:count,
        \ })
    finally
        let &eventignore = oldei
    endtry
endf

func! beautify#run(opts)
    " Line we're at
    let a:opts.cursorline = line('.')

    " Detect whether a range is being used or not
    let a:opts.is_range = (a:opts.count == -1) ? 0 : 1

    " Write range/buffer to temporary file and save temp file name
    let a:opts.tmpfile = beautify#write_tmpfile(a:opts)
    let a:opts.input   = a:opts.tmpfile
    let a:opts.output  = a:opts.tmpfile

    " Call each beautifier
    for beautifier in a:opts.beautifiers
        " Make sure beautifier for this filetype is installed
        if !executable(beautifier.bin)
            " Check if we know how to install this beautifier
            if !has_key(beautifier, 'install')
                throw 'Unable to automatically install executable for '.beautifier.name
            endif

            " Try to install beautifier
            if !beautifier.install()
                throw 'Please manually install '.beautifier.bin.' to beautify '.a:opts.filetype
            endif
        endif

        " Pass along any defined args
        if has_key(beautifier, 'args')
            let a:opts.args = beautifier.args
        else
            let a:opts.args = ''
        endif

        call beautifier.run(a:opts)
    endfor

    " Read in modified file
    if exists('a:opts.inplace') && a.opts.inplace
        call beautify#read_tmpfile(a:opts)
    endif

    " Force a redraw!
    silent redraw!

    " Restore cursor
    if a:opts.is_range
        exe ':'.a:opts.firstline
    else
        exe ':'.a:opts.cursorline
    endif
endf

" Completion helper
func! beautify#complete(arg, cmdline, cursor)
    let options = []
    for [ft, cmds] in items(g:beautify.filetypes)
        call add(options, ft)
        for cmd in cmds
            call add(options, cmd)
        endfor
    endfor

    return filter(options, 'v:val =~ a:arg')
endf
