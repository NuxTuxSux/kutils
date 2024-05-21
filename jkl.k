\d JKL

   pt: $31337
   sp: "coding/ArrayLang/kutils/server.sh"                                                      /   need to solve this.

   st: {`x(("/bin/bash";sp;pt);"")}
   st[]
   ."\\sleep 2"                                                                                 /   server is not ready yet, as `x is non blocking

   cn: {.[<:;`$":",pt;`noconn]}
   jl: cn[]
   C: {jl 0:`j@(x;y); r:{$[#x;*x;x]}@0:jl; .[`j?;,r;{"Julia: ",$r}]}                            /   try to condense I and O in the communication with Julia server

   dn: {C[`STP]`}
   p: C[`PUT]
   e: C[`EXC]
   c: C[`CLL]

   fn: {$[1=#x;$x;"."/$x]}                                                                      /   `LinearAlgebra`transpose -> "LinearAlgebra.transpose"
   fc: {[nm]{c(fn x;y)}[nm]}                                                                    /   julia function's "symbol path" (see above) -> k wrapper function
   i: {fc'nms!(,x),/:nms:`$C[`IMP]x}                                                            /   gives the package as a dict of k wrapper functions over its functions

\d .



/   TODO
/   - solve the "sleep 2" issue
/   - cast julia return values to appropriate type
/   - test function calls on arrays of strings
/   - implement JKL.flt

