"=============================================================================
" im.kayac.com Poster
" Version: 1.0
" Last Change: 2014/10/30 17:14:50.
" Author: mugetu
" License: MIT license  {{{
"     Permission is hereby granted, free of charge, to any person obtaining
"     a copy of this software and associated documentation files (the
"     "Software"), to deal in the Software without restriction, including
"     without limitation the rights to use, copy, modify, merge, publish,
"     distribute, sublicense, and/or sell copies of the Software, and to
"     permit persons to whom the Software is furnished to do so, subject to
"     the following conditions:
"
"     The above copyright notice and this permission notice shall be included
"     in all copies or substantial portions of the Software.
"
"     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
"     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
"     MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
"     IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
"     CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
"     TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
"     SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
" }}}
"=============================================================================
scriptencoding utf-8

let s:save_cpo = &cpo
set cpo&vim

function! imkayac#send(message, ...) "{{{
  if a:0 > 0
    let handler = a:1
  endif
  let param = {}

  let param["message"] = a:message

  if exists('g:imkayac_password')
    let param["password"] = g:imkayac_password
  endif

  if exists('g:imkayac_secretkey')
    let param["sig"] = Sha1(a:message . g:imkayac_secretkey)
  endif

  if exists('handler')
    let param["handler"] = handler
  endif

  let res = webapi#http#post("http://im.kayac.com/api/post/" . g:imkayac_username, param)
  let json = webapi#json#decode(res.content)
  if len(json.error) == 0
    echo json.result
  else
    echo json.error
  endif
endfunction
"}}}

let &cpo = s:save_cpo
unlet s:save_cpo

" __END__
" vim: foldmethod=marker
