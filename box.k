\d box
 dsep: "•▶▷○◇"![3]+3*4                                                                                                                      / choice the separator for dicts
 in: {(z<y)&z>x}                                                                                                                            / exclusive interval
 b2i: {x+256*0>x}                                                                                                                           / byte(s) to int - solves issue about neg numbs w/ chars over 127
 ulen: +/~in[127;192]b2i@                                                                                                                   / length of utf8 str - discards data bytes and counts just initiators

 ucut: {#[y]^*&x<+\~box.in[127;192]box.b2i@y}                                                                                               / gives str index of x-th uchar 

 lines:cols:999                                                                                                                             / thanks to repl.k
 upd:{(lines;cols)::`I$"\n"\`x(("/usr/bin/env";"tput";"-S");"lines\ncols\n")}                                                               / "

 mshp: {(#x),ulen@*x}                                                                                                                       / shape of a char matrix
 / mpad: {(r;c):x-mshp@y;(y,\:c#" "),r#,(x@1)#" "}                                                                                          / (right/down) space padding of a tile (i.e. char matrix)
 mpad: {s:mshp@y;p:{_%[;2]x-y}[x;s];?[(*x-s;x@1)#" ";p@0;?'[(*s;*|x-s)#" ";p@1;y]]}                                                         / centered space padding of a tile
 confsz: ,/:\:/|/''{(*''x;+(*|)''x)}@mshp''                                                                                                 / gives conformed sizes for each tile in a tiles matrix
 cs: 0N 3#"\0\0 \0\0r\0\0u╰\0\0l─╯┴\0\0d╭│├╮┬┤┼"                                                                                            / line chrs put in the right order to enable bit-controlled superposition.
                                                                                                                                            / In "(cs@2/) r u l d" r, u, l and d are the bits telling presence of each segmentlet
 box: {l:*[*|mshp@x;3]#"─";,/(,"╭",l,"╮";"│",/:x,\:"│";,"╰",l,"╯")}                                                                         / draws a box around a chr matrix
 draw: {cs@2/|/+2\cs?/:(x;y)}                                                                                                               / takes two borders vec giving their superposition
 hcat: {(-3_'x),'draw[-3#'x;3#'y],'(3_'y)}                                                                                                  / horizontally concat of two char matrices - superpose borders when needed
 vcat: {(-1_x),(,,/draw[0N 3#*|x;0N 3#*y]),1_y}                                                                                             / see above

 matsh: {vcat/hcat/'box''mpad''[confsz@x;x]}                                                                                                / accepts a matrix of char tiles
 dicsh: {A:+(x;(#x)#,,dsep@0N,(!3),0N;y);vcat/box',/''+'mpad''[confsz[A];A]}
 tablim: {$[x<#y;(-[x;1]#y),,#[*y]#,,"⋮";y]}                                                                                                / limits a char matrix representing a table to x rows adding ⋮ when needed
 tabsh: {a:tablim[-5+lines]@,''`k''(!x;@'.*x),+.x;mp:mpad''[confsz@a;a];vcat[hcat/box',/'+2#mp;hcat/{box@*'x}'+2_mp]}

 scrspl: *{#*x@1}{(ts;t):x;c:box.ucut[cols]'t;(ts,c#'t;c_'t)}/,[,();]@,:                                                                    / split a tile to show it seq on the screen


 
 mx: {&[1~#?@'x;1~#?#'x]}                                                                                                                   / tests if an array is a matrix
 smx: {|/`S`F`I`C=@*x}                                                                                                                      / tests if a matrix is a "scalar" matrix
 / repr: {$[(::)~x;,"";`A~@x;,$[(1=#?#'x)&(|/`I`F`A`S=*ts)&1=#ts:?@'x;matsh@o''x;matsh@,o'x];`m~@x;dicsh[o'!x;o'.x];`M~@x;,tabsh@x;,`k@x]}  / old version
 repr: {$[(::)~x;(); `m~@x;dicsh[o'!x;o'.x]; `M~@x;tabsh@x; `A~@x;$[1=#x;box@o@*x;mx@x;$[smx@x;`k'x;matsh@o''x];matsh@,o'x]; ,`k@x]}        / gives a tile representing x


 shw:{box.upd[];$[`M~@x;{$[cols<ulen[x];((ucut[cols-1]@x)#x),"⋯";x]}';scrspl]repr@x}




\d .
