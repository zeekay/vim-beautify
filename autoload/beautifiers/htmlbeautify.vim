func! beautifiers#htmlbeautify#install()
    echoerr 'Please install js-beautify (github.com/beautify-web/js-beautify), which provides html-beautify: npm install -g js-beautify'
endf

func! beautifiers#htmlbeautify#run(opts)
    let cmd  = 'html-beautify'
    let args = [
        \ '--quiet',
        \ '--wrap-line-length=200',
        \ '-U a,inline',
        \ '-E html,head,body,form,ul,ol,section',
        \ '--indent-size='.&shiftwidth,
        \ '-f '.a:opts.input,
        \ '-o '.a:opts.output,
    \ ]
    call beautify#system(cmd.' '.join(args))
endf
