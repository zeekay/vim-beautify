# vim-beautify
Why live with ugly code? Adds filetype specific `:Beautify` command which
beautifies buffers or ranges.

## Built-in support
- C, C++
  - astyle
- CSS
  - css-beautify
- HTML, XML
  - html-beautify _(default)_
  - tidy
- Java
  - astyle
- JavaScript
  - js-beautify
- JSON
  - js-beautify
  - json.tool
  - node _(default)_
  - uglifyjs
- Go
  - gofmt
- Python
  - autopep8 _(default)_
  - docformatter _(default)_

## Usage
You can beautify a buffer or range using `:Beautify`. The appropriate beautifier
(or beautifiers) will be run according to detected filetype.

An optional filetype or beautifier name may also be specified to trigger a
specific beautifier regardless of detected filetype. For instance, to beautify a
block of JSON inside of a Markdown file you can simply select a range and call
`:Beautify json`.

## API
You can customize the existing beautifiers, arguments used or define new
beautifiers:

```vim
let g:beautify = {
    \ "beauifiers": {
        \ "python": ["autopep8", "docformatter"],
    \ },
    \ "definitions": {
        \ "autopep8": {
            \ "args": "--aggressive",
        \ }
    \ }
\ }
```
