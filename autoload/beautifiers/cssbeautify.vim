func! beautifiers#cssbeautify#install()
    echoerr 'Please install js-beautify (github.com/beautify-web/js-beautify), which provides css-beautify: npm install -g js-beautify'
endf

func! beautifiers#cssbeautify#run(opts)
    exe '%!css-beautify --indent-size='.&shiftwidth.' -f -'
endf
