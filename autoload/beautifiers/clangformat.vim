func! beautifiers#clangformat#install()
    if has('mac') && executable('brew')
        exe '!brew install clang-format'
        return
    endif

    echoerr 'clang-format must be installed to beautify: http://clang.llvm.org/docs/ClangFormat.html'
endf

let s:yaml = expand('<sfile>:p:h:h:h').'/clang-format.yaml'

func! beautifiers#clangformat#run(opts)
    exe '%!clang-format -assume-filename='.a:opts.input_file.' -style='.s:yaml
endf
