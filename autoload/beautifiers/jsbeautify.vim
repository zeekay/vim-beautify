func! beautifiers#jsbeautify#install()
    echoerr 'Please install js-beautify (github.com/beautify-web/js-beautify): pip install jsbeautifier'
endf

func! beautifiers#jsbeautify#run(opts)
    call system('js-beautify -k -x --brace-style=collapse --indent-size='.&shiftwidth.' -r -f '.a:opts.tmpfile)
endf
