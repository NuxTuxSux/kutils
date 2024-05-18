\d JKL

    pt: $31337
    sp: "coding/ArrayLang/kutils/server.sh"                                                         /   need to solve this.

    `x(("/bin/bash";sp;pt);"")

    ."\\sleep 2"
                                                                                                    /   server is not ready yet, as `x is not blocking
    jl:  .[<:;`$":",pt;`noconn]
    C: {jl 0:`j@(x;y); r:{$[#x;*x;x]}@0:jl; .[`j?;,r;{"Julia: ",$r}]}                               /   try to condense I and O in the communication with Julia server
                                                                                                    /   fix the try block
    s: {C[`STOP]`}
    p: C[`PUT]
    x: C[`X]

    fn: {$[1=#x;$x;"."/$x]}                                                                         /   `LinearAlgebra`transpose -> "LinearAlgebra.transpose"
    fc: {[nm;as]x fn@nm,"(JSON.parse(\"",(`j@as),"\"))"}                                            /   julia function's "symbol path" (see above) -> k wrapper function
    i: {`$C[`IMP]x}

\d .



/   TODO
/   - after json parsing, cast the data to the most specific type
/   - solve the "sleep 2" issue

/   Notes
/   - Julia's json gives matrices by cols. Do we need to fix this?
/   - json views matrices as list of rows, then Julia views them
/       simply as arrays of arrays. We should address this.
