\d JKL

p: $31337

/ need to solve this.
sp: "coding/ArrayLang/kutils/server.sh"

`x(("/bin/bash";sp;p);"")


/ FIX this issue: we need this sleep because
/ server is not ready yet, as `x is not blocking
\sleep 2                         

jl:  .[<:;`$":",p;`noconn]

C: {jl 0:x; .[{`j?x};(*:0:jl);$]}

s: {C@"STOP"}
p: {C@`j@("PUT";x;y)}
g: {C@`j@("GET";x)}
c: {C@`j@("X";x)}

\d .



/ TODO
/ implement package imports
/ implement "function imports" from k
/ JKL.c"using Plots"    gives an error
/ - after json parsing, cast the data to the most specific type
