func! beautifiers#jsontool#install()
endf

func! beautifiers#jsontool#run(opts)
    let out = system('python -m json.tool '.a:opts.tmpfile)
    call writefile(split(out, '\v\n'), a:opts.tmpfile, 'b')
endf
