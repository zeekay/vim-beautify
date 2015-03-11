func! beautifiers#docformatter#install()
    if executable('pip')
        exe '!pip install docformatter'
    else
        echoerr 'pip install docformatter'
    endif
endf

func! beautifiers#docformatter#run(opts)
    call beautify#system('docformatter --no-blank --pre-summary-newline -i '.a:opts.input)
endf
