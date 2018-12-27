func! beautifiers#prettier#install()
    echoerr 'Please install prettier (github.com/prettier/prettier): npm install -g prettier'
endf

let s:json = expand('<sfile>:p:h:h:h').'/prettier.config.js'

func! beautifiers#prettier#run(opts)
    let cmd = 'prettier'
    exe '%!'.cmd.' --parser=babylon --config='.s:json.' --tab-width='.&shiftwidth.' '.a:opts.input
endf
