#!/usr/local/bin/julia

using Sockets, JSON
const PORT = parse(Int, ARGS[1])

srv = listen(PORT)#, backlog = 0)

clt = accept(srv)

running = true
while running
   cmd, args... = JSON.parse(readline(clt))

   res = nothing
   if cmd == "X"
      res = eval(Meta.parse(args[1]))
   elseif cmd == "PUT"
      res = eval(Meta.parse("$(args[1])=($(repr(args[2])))"))
   elseif cmd == "GET"
      res = eval(Meta.parse(args[1]))
   elseif cmd == "STOP"
      global running
      res = "Bye"
      running = false
   end
   write(clt, isnothing(res) ? "\n" : json(res) * "\n")
   flush(clt)
end

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