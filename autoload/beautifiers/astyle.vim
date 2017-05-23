func! beautifiers#astyle#install()
    if has('mac') && executable('brew')
        exe '!brew install astyle'
        return
    endif

    echoerr 'astyle must be installed to beautify: http://astyle.sourceforge.net'
endf

func! beautifiers#astyle#run(opts)
    exe '!astyle -k1 -p -F -C -N -Y -U -H -xe -xy -q --indent=spaces -c --style=kr '.a:opts.tmpfile
endf
