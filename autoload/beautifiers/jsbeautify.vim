func! beautifiers#jsbeautify#install()
    echoerr 'Please install js-beautify (github.com/beautify-web/js-beautify): npm install -g js-beautify'
endf

let s:json = expand('<sfile>:p:h:h:h').'/jsbeautify.json'

func! beautifiers#jsbeautify#run(opts)
    let cmd = 'js-beautify'
    exe '%!'.cmd.' --config='.s:json.' --indent-size='.&shiftwidth.' -f -'
endf
