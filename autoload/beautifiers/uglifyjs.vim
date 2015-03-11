func! beautifiers#uglifyjs#install()
endf

func! beautifiers#uglifyjs#run(opts)
    let args    = '-b indent-level=2,quote-keys=true'
    let tmpfile = a:opts.tmpfile

    " Parse a single expression, rather than a program (for parsing JSON)
    if a:opts.filetype == 'json'
        let args = '--expr '.args
    endif

    let cmd = 'uglifyjs '.tmpfile.' '.args.' -o '.tmpfile
    call beautify#system(cmd)
endf
