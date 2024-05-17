#!/usr/local/bin/julia

using Sockets, JSON
const PORT = parse(Int, ARGS[1])

srv = listen(PORT)#, backlog = 0)

clt = accept(srv)

while "STOP" != (l = readline(clt))
   # println(l)
   e = eval(Meta.parse(l))
   write(clt, isnothing(e) ? "\n" : json(e) * "\n")
   flush(clt)
end

write(clt,json("Bye"))
close(clt)





# USAGE
# tmux new-session -d -s jlkserver "jkl.jl"
# `x(("/usr/local/bin/tmux";"new-session";"-d";"-s";"jlksrv";"coding/ArrayLang/kutils/jkl.jl");"")       # in k


# NOTES
# - when something goes wrong (or maybe always) tmux session stays zombie
# - send large data in chunks
# - find a lighter alternative to tmux



# TODO
# - handle julia errors - connection should stay alive and return jsoned
#  julia error (which I should unpack in k to throw a k error)