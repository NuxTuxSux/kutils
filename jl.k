\d JL
jp: "/usr/local/bin/julia"
x: {`j?`j?`x(,jp;x)}
\d .



/ TODO
/ `j?.`x(,"/usr/local/bin/julia";"using JSON;json(rand(3,2))")
/ get rid of JSON import and json call wrt user
/ make it accept args
/ matrices happen to be transposed


/ nc -l 1234 | julia | nc -l 1235
/ nc -l 1234 | julia &              / non credo
/ tmux new-session -d -s sessione "nc -k -l 32236|julia|nc localhost 32237"
/ nc -k -l 32237
/ prima di lanciare tmux / julia, devo essere in ascolto, altrimenti julia si incazza un po' per broken pipe
/ appena chiudo netcat in ascolto cade la connessione
/ IMPORTANTE: forse devo mettere nc in ascolto in bg tramite `x, in modo da poter continuare col programma

/ QUESTO RISOLVE MOLTO
/ socat TCP-LISTEN:32258,reuseaddr,fork EXEC:'julia',pty,stderr
/ però mi mostra tutti i fronzoli della shell, perdo l'interazione. se uso julia -q allora mi evita il logo, ma resta il prompt. Però:

/ -- POSSO scrivere un server julia che incapsuli l'interprete [ tramite eval(Meta.parse(input)) ] e lanciarlo con tmux da k
/ questo mi darebbe tutta la libertà che voglio, permettendomi anche di incapsulare il funzionamento JSON.
/           MI PIACE.

/ ANCORA MEGLIO
/ socat TCP-LISTEN:32258,reuseaddr,fork EXEC:'julia',stderr
/ posso mettere un preambolo usando julia -i -e "using JSON", ad esempio
/ devo fare in modo di inviare l'espressione e poi attendere l'output
/ devo inviare gli eventuali input serializzati e poi leggere gli output serializzati
/ questo funziona. Devo solo collegarmi, sia in input che in output al processo, da k spero basti l'I/O

/ incapsulare la chiamata in un mini-protocollo. Ad esempio inviando linee per la ricezione e per la fine del messaggio.

/ f 0:"rand(100,100)";:s:`j?*0:f