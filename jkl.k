\d JKL

   pt: $31337
   env: !/+"="\'"\n"\`x(,"/usr/bin/env";"")                                                     /   we load the env dictionary to find $NGN_DIR, as
                                                                                                /    kutils should be in the same folder as ngn/k
   sp: (env"NGNK_DIR"),"/../kutils/server.sh"

   st: {`x(("/bin/bash";sp;pt);"");}
   cn: {jl:: (-1=){.[{."\\sleep 0.1";;<x};`$":",pt;-1]}/ -1}                                    /   tries connecting to julia server every tenth of a second

   C: {jl 0:`j@(x;y); r:{$[#x;*x;x]}@0:jl; .[`j?;,r;{"Julia: ",$r}]}                            /   try to condense I and O in the communication with Julia server

   dn: {C[`STP]`}
   p: C[`PUT]
   e: C[`EXC]
   c: C[`CLL]

   fn: {$[1=#x;$x;"."/$x]}                                                                      /   `LinearAlgebra`transpose -> "LinearAlgebra.transpose"
   fc: {[nm]{c(fn x;y)}[nm]}                                                                    /   julia function's "symbol path" (see above) -> k wrapper function
   i: {fc'nms!(,x),/:nms:`$C[`IMP]x}                                                            /   gives the package as a dict of k wrapper functions over its functions

   flt: {$[^``i`f`c`s?@x;`f,o'x;x]}                                                             /   recursively flatten a list to make a multidimensional array for Julia

   st[]
   cn[]
   
\d .



/   TODO
/   - cast julia return values to appropriate type
/   - test function calls on arrays of strings
/   - maybe importing a package should create a namespace populated w/ its (wrapped) functions
