/ › opt+shft+4   (on osx)
/ · opt+shft+9
/ ∞ opt+5

rR:{~^?[x+!y;z]}                                                 / in-range test
rD:rR["0";10]                                                    / digits

j:{$[`c~@x;x~;x]}                                                / characteristic f. inclusion - allows using "a" instead of "a"~


(›):T:{(0;j[x];j[y])}                                            / sequence of matches, the left-one needs to be a simple test, not a rx
(·):I:{(1;j[x];j[y])}                                            / alternatives matches
(∞):O:{(2;j[x];j[y])}                                            / loop or else, the left-one needs to be a simple test, not a rx

(›:):{y›x}/|:                                                    / monadic reduction. ex: ›"abc" is a short-hand for "a"›"b"›"c"
(·:):{y·x}/|:                                                    / monadic reduction, see above

Mt:{$[0~#z;0;x@*z;M[y;1_z];0]}
Mi:{M[x;z]|M[y;z]}
Mo:{$[0~#z;0;x@*z;o[x;y;1_z];M[y;z]]}                            / do we actually need the else function?

M:{y:$[1~#y;*y;y];$[`A~@x;((Mt;Mi;Mo)@*x)[x[1];x[2];y];x@y]}


/ exm
/ "t"›"h"›"e"·›["is"]·"a"∞"t"                                  / matches the, this, that, tht, thaaaat

