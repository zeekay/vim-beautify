func! beautifiers#uglifyjs#install()
    echoerr 'Please install UglifyJS (https://github.com/mishoo/UglifyJS2): npm install -g uglify-js'
endf

func! beautifiers#uglifyjs#run(opts)
    let args = a:opts.args
    let tmpfile = a:opts.tmpfile

    " Parse a single expression, rather than a program (for parsing JSON)
    if a:opts.filetype == 'json'
        let args = '--expr '.args
    endif

    let cmd = 'uglifyjs'
    exe '%!'.cmd.' '.a:opts.input.' '.args
endf
