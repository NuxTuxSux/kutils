\d plt
gppath: "/usr/local/bin/gnuplot"
pre: "\$a<<E\n"
menc: {("\n"/" "/'$+x),"\n"}
/ menc: {("\n"/" "/'4$$+x),"\n"}
post: {"\n"/("E";"plot \$a with ",x;"")}


plt: {`x((gppath;"-persist");pre,(menc y),post[x])}
sct: plt@"dots"
lns: plt@"lines"
\d .
