\d JKL

pt: $31337

/ need to solve this.
sp: "coding/ArrayLang/kutils/server.sh"

`x(("/bin/bash";sp;pt);"")


/ FIX this issue: we need this sleep because
/ server is not ready yet, as `x is not blocking
\sleep 2                         

jl:  .[<:;`$":",pt;`noconn]

/ do json parsing here
/ fix try block
C: {jl 0:`j@x; `j?*:0:jl}

s: {C"STOP"}
p: {C("PUT";x;y)}
g: {C("GET";x)}
c: {C("X";x)}
i: {C("IMP";x)}

\d .



/ TODO
/ implement package imports
/ implement "function imports" from k
/ JKL.c"using Plots"    gives an error
/ - after json parsing, cast the data to the most specific type
