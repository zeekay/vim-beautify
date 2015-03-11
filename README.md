# vim-beautify

Adds filetype specific `:Beautify` command which beautifies the current buffer.

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
You can beautify an entire buffer or range using `:Beautify`. You can pass an
optional filetype or beautifier name to trigger a specificy type of
beautification, if you are editing a Markdown file and want to beautify a JSON
code block, for instance: `:Beautify json`.

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
