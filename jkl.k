\d JKL

    pt: $31337
    sp: "coding/ArrayLang/kutils/server.sh"                                                         / need to solve this.

    `x(("/bin/bash";sp;pt);"")

    ."\\sleep 2"                                                                                    / SOLVE this issue: we need this sleep because
                                                                                                    / server is not ready yet, as `x is not blocking
    jl:  .[<:;`$":",pt;`noconn]
    C: {jl 0:`j@(x;y); r:{$[#x;*x;x]}@0:jl; .[`j?;,r;{"Julia: ",$r}]}                               / try to condense I and O in the communication with Julia server

    s: {C["STOP"]`}
    p: C["PUT"]
    x: C["X"]
    i: C["IMP"]

\d .



/ TODO
/ implement "function imports" from k
/ make use of symbols over strings when possible
/ - after json parsing, cast the data to the most specific type
