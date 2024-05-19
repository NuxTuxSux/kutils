\d JKL

    pt: $31337
    sp: "coding/ArrayLang/kutils/server.sh"                                                         /   need to solve this.

    `x(("/bin/bash";sp;pt);"")

    ."\\sleep 2"
                                                                                                    /   server is not ready yet, as `x is non blocking
    jl:  .[<:;`$":",pt;`noconn]
    C: {jl 0:`j@(x;y); r:{$[#x;*x;x]}@0:jl; .[`j?;,r;{"Julia: ",$r}]}                               /   try to condense I and O in the communication with Julia server
                                                                                                    /   fix the try block
    s: {C[`STP]`}
    p: C[`PUT]
    e: C[`EXC]

    fn: {$[1=#x;$x;"."/$x]}                                                                         /   `LinearAlgebra`transpose -> "LinearAlgebra.transpose"
    fc: {[nm;as]e (fn@nm),"(JSON.parse(\"",(`j@as),"\"))"}                                          /   julia function's "symbol path" (see above) -> k wrapper function
    i: {nms!(,x),/:nms:`$C[`IMP]x}                                                               /   ~~BUG~~

\d .



/   TODO
/   - after json parsing, cast the data to the most specific type - DONE. TEST.
/   - add shape info OR post-json casting to appropriate type (example: Matrix)
/   - solve the "sleep 2" issue
/   - add "connect" functionality

/   Notes
/   - Julia's json gives matrices by cols. Do we need to fix this?
/   - json views matrices as list of rows, then Julia views them
/       simply as arrays of arrays. We should address this.
/   - JSON returns Any(s) in Julia, issues w/ function types
/   - we need annotations about the type in JSON :(
