\d plt
gppath: "/usr/local/bin/gnuplot"
pre: "\$a<<E\n"
menc: {("\n"/" "/'4$$+x),"\n"}
post: "E\nplot \$a with lines\n"


plt: {`x((gppath;"-persist");pre,(menc x),post)}
\d .
