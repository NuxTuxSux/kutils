\d box
 dsep: "•▶▷○◇"![3]+3*4                                                                                                  / choice the separator for dicts
 in: {(z<y)&z>x}                                                                                                        / exclusive interval
 b2i: {x+256*0>x}                                                                                                       / byte(s) to int - solves issue about neg numbs w/ chars over 127
 ulen: +/~in[127;192]b2i@                                                                                               / length of utf8 str - discards data bytes and counts just initiators

 / utake: {{z;(x+1)>+\~in[127;192]b2i@y}[x;y]#y}                                                                          / take x unicode chars from y - uses z for K combinator (f#x)
 ucut: {#[y]^*&x<+\~box.in[127;192]box.b2i@y}
 / udd: {$[x<ulen@y;utake[x-2;y],"..";y]}                                                                                 / cut long unicode lines taking x uchar inserting ".."

 mshp: {(#x),ulen@*x}                                                                                                   / shape of a char matrix
 / mpad: {(r;c):x-mshp@y;(y,\:c#" "),r#,(x@1)#" "}                                                                      / (right/down) space padding of a tile (i.e. char matrix)
 mpad: {s:mshp@y;p:{_%[;2]x-y}[x;s];?[(*x-s;x@1)#" ";p@0;?'[(*s;*|x-s)#" ";p@1;y]]}                                     / centered space padding of a tile
 confsz: ,/:\:/|/''{(*''x;+(*|)''x)}@mshp''                                                                             / gives conformed sizes for each tile in a tiles matrix
 cs: 0N 3#"\0\0 \0\0r\0\0u╰\0\0l─╯┴\0\0d╭│├╮┬┤┼"                                                                        / line chrs put in the right order to enable bit-controlled superposition.
                                                                                                                       / In "(cs@2/) r u l d" r, u, l and d are the bits telling presence of each segmentlet
 box: {l:*[*|mshp@x;3]#"─";,/(,"╭",l,"╮";"│",/:x,\:"│";,"╰",l,"╯")}                                                     / draws a box around a chr matrix
 draw: {cs@2/|/+2\cs?/:(x;y)}                                                                                           / takes two borders vec giving their superposition
 hcat: {(-3_'x),'draw[-3#'x;3#'y],'(3_'y)}                                                                              / horizontally concat of two char matrices - superpose borders when needed
 vcat: {(-1_x),(,,/draw[0N 3#*|x;0N 3#*y]),1_y}                                                                         / see above

 matsh: {vcat/hcat/'box''mpad''[confsz@x;x]}                                                                            / accepts a matrix of char tiles
 dicsh: {A:+(x;(#x)#,,dsep@0N,(!3),0N;y);vcat/box',/''+'mpad''[confsz[A];A]}
 tablim: {$[x<#y;(-[x;1]#y),,#[*y]#,,"⋮";y]}                                                                            / limits a char matrix representing a table to x rows adding ⋮ when needed
 tabsh: {a:tablim[-5+repl.lines]@,''`k''(!x;@'.*x),+.x;mp:mpad''[confsz@a;a];vcat[hcat/box',/'+2#mp;hcat/{box@*'x}'+2_mp]}

 / shape: {$[|/`A`F`I`S=@x;$[1=#ts:?o'x;,[;*ts];::](#x);!0]}
 repr: {$[`A~@x;$[(1=#?#'x)&(|/`I`F`A`S=*ts)&1=#ts:?@'x;matsh@o''x;matsh@,o'x];`m~@x;dicsh[o'!x;o'.x];`M~@x;tabsh@x;,`k@x]}   / gives a tile representing x
\d .
shw: {`0:{#[;x]box.ucut[repl.cols]x}'box.repr@x;}


/ -------- BUGS --------
/ show@,,"hi!" and show@,"hi!" give the same boxed result

/ -------- TODO --------
/ split width-exceding tiles vertically

