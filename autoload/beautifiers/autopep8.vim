func! beautifiers#autopep8#install()
    if executable('pip')
        exe '!pip install autopep8'
    else
        echoerr 'pip install autopep8'
    endif
endf

func! beautifiers#autopep8#run(opts)
    call beautify#system('autopep8 '.a:opts.args.' --in-place '.a:opts.input)
endf
