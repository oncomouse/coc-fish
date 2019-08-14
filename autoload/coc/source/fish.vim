function! coc#source#fish#init() abort
  return {
        \'shortcut': 'fish',
        \'priority': 99,
        \'filetypes': ['fish'],
        \'firstMatch': 0,
        \'triggerCharacters': ['.'],
        \}
endfunction

function! s:handler(output, base, cb) abort
  let l:results = []
  let l:cmd = substitute(a:base, '\v\S+$', '', '')
  for l:line in a:output[0]
      let l:tokens = split(l:line, '\t')
      if len(l:tokens) > 0
        call add(l:results, {'word': l:cmd.l:tokens[0],
                            \'abbr': l:tokens[0],
                            \'menu': get(l:tokens, 1, '')})
      endif
  endfor
  call a:cb(l:results)
endfunction

function! coc#source#fish#complete(opt, cb) abort
  let l:out = []
  let l:job = 'fish -c "complete -C'.shellescape(a:opt.input).'"'
  if has('nvim')
    call jobstart(l:job, { 'on_stdout': {j,d,e -> add(l:out, d) }, 'on_exit': {-> <SID>handler(l:out, a:opt.input, a:cb)}})
  elseif !has('nvim') && has('job') && has('channel') && has('lambda')
    call job_start(l:job, { 'out_mode': 'nl', 'on_stdout': {j,d,e -> add(l:out, d)}, 'exit_cb': {-> <SID>handler(l:out, a:opt.input, a:cb)}})
  else
    call <SID>handler([split(system(l:job))], a:opt.input, a:cb)
  endif
endfunction

