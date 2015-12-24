func! beautifiers#jsbeautify#install()
    echoerr 'Please install js-beautify (github.com/beautify-web/js-beautify): npm install -g js-beautify'
endf

func! beautifiers#jsbeautify#run(opts)
    let cmd = 'js-beautify'
    let args = '-q -k -x -r --brace-style=collapse --indent-size='.&shiftwidth.' -f '.a:opts.input.' -o '.a:opts.output
    call beautify#system(cmd.' '.args)
endf
