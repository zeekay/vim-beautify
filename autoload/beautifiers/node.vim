func! beautifiers#node#install()
endf

func! beautifiers#node#run(opts)
    let args    = '-b indent-level=2,quote-keys=true'
    let tmpfile = a:opts.tmpfile

    " Parse a single expression, rather than a program (for parsing JSON)
    if a:opts.filetype == 'json'
        let args = '--expr '.args
    endif

    let cmd = "node -e \"fs=require('fs'); fs.writeFileSync('".a:opts.input."', JSON.stringify(JSON.parse(fs.readFileSync('".a:opts.output."').toString()), null, 2))\""
    call beautify#system(cmd)
endf
