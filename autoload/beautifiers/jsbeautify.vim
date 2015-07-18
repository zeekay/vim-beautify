func! beautifiers#jsbeautify#install()
    echoerr 'Please install js-beautify (github.com/beautify-web/js-beautify): pip install jsbeautifier'
endf

func! beautifiers#jsbeautify#run(opts)
    let cmd = 'js-beautify'
    let args = '-q -k -x -r --brace-style=collapse --indent-size='.&shiftwidth.' -f '.a:opts.input
    call beautify#system(cmd.' '.args)
endf
