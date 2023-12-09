let s:help_text = [
\":Mhelp this help box",
\"\\ leader key",
\"\\4 syntax checker ",
\"<F3> relative numbers on/off",
\"\\<F3> normal number on/off",
\"<F4> tab, space, enter character normal on/off",
\"<F2> buffers to tab in normal",
\"Mclear clear last search pattern",
\"-----",
\"NETWR",
\"-----",
\":Vex open vertical split",
\"I show help banner",
\"gh show files",
\"",
\"",
\]


function s:Mhelp() abort
  call popup_create(s:help_text, #{
  	\ minwidth: 40,
  	\ minheight: 14,
  	\ time: 5000,
  	\ zindex: 300,
  	\ border: [],
  	\ })
endfunction

command! Mhelp call s:Mhelp()
