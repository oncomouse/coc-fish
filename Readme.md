# coc-fish

*This is a legacy, Vimscript-based version of this completion framework.*

Asynchronous completion source for [Coc](https://github.com/neoclide/coc.nvim) and [fish](https://github.com/fish-shell/fish-shell). Based on code from [vim-fish](https://github.com/dag/vim-fish).

## Installation

Dependencies:

* [Coc](https://github.com/neoclide/coc.nvim)
* [fish](https://github.com/fish-shell/fish-shell)

Add this repository using your favorite package manager. For instance, with [vim-plug](https://github.com/junegunn/vim-plug), the following will install this package:

~~~vim
Plug 'oncomouse/coc-fish'
~~~

This completion source depends on an executable `fish` binary in your `$PATH`.

After running `PlugInstall`, the source will be available for use in any fish files you edit.

## Similar Work

* [deoplete-fish](https://github.com/ponko2/deoplete-fish) – Source for [deoplete](https://github.com/Shougo/deoplete)
