\d csv

sep: ","
esc: "\""

ptypes: {ts:{$[|/~^`I$x;`i;~|/^`F$x; `f; #x; `c; `s]}'x;?ts}                                / caution: test if there's only one type (i.e. blank col)
conform: {``c`c`F`I@*&+/``c`C`f`i=/:(#x)#x}                                                 / maybe we can use an if to enlist x

cparse: {(conform ptypes x)$x}

escaped: &/esc=*+1 -1#\:
unesc: {e:escaped x;(e_(-e)_x)}
split: {s:sep,x,sep;-1_/: 1_ -1 _ (&1,(sep=s)&(~2!+\esc=s))_s}
read: +{(`s$*x)!cparse'+1_x}@unesc''split'0::

replacemiss: {$[|//(0n;0N)=\:x;"";x]}
write: {x 0:{sep/(`k@'x)}' ((,$!y),replacemiss''+.y)}

\d .

/ TODO - Notes
/ - Character encoding issue. Sometimes there are few bytes at the beginning
/ - Test with blank cols and empty colnames

