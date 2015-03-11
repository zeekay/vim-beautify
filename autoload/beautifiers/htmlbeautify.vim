func! beautifiers#htmlbeautify#install()
    echoerr 'Please install js-beautify (github.com/beautify-web/js-beautify), which provides html-beautify: pip install jsbeautifier'
endf

func! beautifiers#htmlbeautify#run(opts)
    exe '%!html-beautify -f -'
endf
