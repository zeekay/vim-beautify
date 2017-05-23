func! beautifiers#tsfmt#install()
    echoerr 'Please install tsfmt (https://github.com/vvakame/typescript-formatter): npm install -g typescript-formatter'
endf

let s:json = expand('<sfile>:p:h:h:h').'/tsfmt.json'

func! beautifiers#tsfmt#run(opts)
    " Prefix absolute path with escapes equal to cwd depth
    let path = ''
    for i in split(getcwd(), '/')
        let path = path.'../'
    endfor
    exe '%!tsfmt --stdin --useTsfmt '.path.s:json
endf
