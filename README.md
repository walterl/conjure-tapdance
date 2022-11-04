# TapDance

Easily [`tap>`](https://clojuredocs.org/clojure.core/tap%3E) Clojure values in an nREPL connected [Conjure](https://github.com/olical/conjure).

Inspired by [Sean Corfield's Calva config](https://github.com/seancorfield/vscode-calva-setup/blob/b973b00/calva/config.edn).

## Installation

With [vim-plug](https://github.com/junegunn/vim-plug):

```
Plug 'walterl/conjure-tapdance'
```

## Usage

Hook up the `:TapForm`, `:TapWord` and `:TapV` commands to the mappings of your choice:

```vim
nnoremap <silent> <Leader>jT <Cmd>TapForm<CR>
nnoremap <silent> <Leader>jt <Cmd>TapWord<CR>
vnoremap <silent> <Leader>jt :TapV<CR>
nnoremap <silent> <Leader>jte <Cmd>TapExc<CR>
```

Using those mappings will wrap the form or word under the cursor, selected
text, or `*e` in a `(tap> ,,,)`-form, and evaluate it in Conjure's nREPL.

## License

Copyright © 2022 Walter

Distributed under the [MIT License](./LICENSE.md).
