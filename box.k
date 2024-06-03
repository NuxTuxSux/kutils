in:{(z<y)&z>x}                                                                      / exclusive interval
b2i:{x+256*0>x}                                                                     / byte(s) to int - solves issue about neg numbs w/ chars over 127
ulen:+/~in[127;192]b2i@                                                             / length of utf8 str - discards data bytes and counts just initiators
utake:{{z;(x+1)>+\~in[127;192]b2i@y}[x;y]#y}                                        / take x unicode chars from y - uses z for K combinator
udd:{$[x<ulen@y;utake[x-2;y],"..";y]}                                               / cut long unicode lines taking x uchar inserting ".."
mshp:{(#x),ulen@*x}                                                                 / shape of a char matrix
mpad:{(r;c):x-mshp@y;(y,\:c#" "),r#,(x@1)#" "}                                      / (right/down) space padding of a char matrix
confsz:,/:\:/|/''{(*''x;+(*|)''x)}@mshp''                                           / gives conformed sizes for each tile in a tiles matrix
cs:0N 3#"\0\0 \0\0r\0\0u╰\0\0l─╯┴\0\0d╭│├╮┬┤┼"                                      / line chrs put in the right order to enable bit-controlled superposition.
                                                                                    / In "(cs@2/) r u l d" r, u, l and d are the bits telling presence of each segmentlet
box:{l:*[*|mshp@x;3]#"─";,/(,"╭",l,"╮";"│",/:x,\:"│";,"╰",l,"╯")}                   / draws a box around a chr matrix
draw:{cs@2/|/+2\cs?/:(x;y)}                                                         / takes two borders vec giving their superposition
hcat:{(-3_'x),'draw[-3#'x;3#'y],'(3_'y)}                                            / horizontally concat of two char matrices - superpose borders when needed
vcat:{(-1_x),(,,/draw[0N 3#*|x;0N 3#*y]),1_y}                                       / see above

matsh:{vcat/hcat/'box''mpad''[confsz@x;x]}                                          / accepts a matrix of char tiles

/ shape:{$[|/`A`F`I`S=@x;$[1=#ts:?o'x;,[;*ts];::](#x);!0]}
/ show:{t:@x;$[|/`C`c`F`I`i`S`s=t;,`k@x;`A~t;hcat/box','`k'x;`nyi]}
/ ashow:{$[`A~@x;$[1=#?@'x;matsh@,''`k''x;hcat/box'ashow'x];`k@x]}
ashow:{$[`A~@x;$[1=#?@'x;matsh@o''x;hcat/box'ashow'x];,`k@x]}



/ lim:{(x<ulen@y)(x#)/y}                                                            / adapt to ucode - avoid calculating str repr for big array






/ -- test data ----------------------------------

A:(10#" "),`c$"A"+!26
bs:+{3 4#100?A}@/:/:3 2#0

a:,"3 4 5 9 8 4 3"
b: ("0 1 2 3 4";"5 6 7 8 9")
c: ("0 1";"2 3";"4 5")
d: ("0 1 2 3";"4 5 6 7")
M: ((,"3 4 5 9 8 4 3";("0 1 2 3 4";"5 6 7 8 9"));(("0 1";"2 3";"4 5");("0 1 2 3";"4 5 6 7")))

B:vcat/hcat/'box''mpad''[confsz@bs;bs]
C:((a;b);(c;d))
C1:vcat/hcat/'box''mpad''[confsz@C;C]
C2:((C1;bs);(bs;C))
C2:((C1;B);(B;C1))


