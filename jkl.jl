#!/usr/local/bin/julia

using Sockets, JSON
const PORT = parse(Int, ARGS[1])

cast(x) = x isa Array ? cast.(x) : convert(typeof(x),x)

srv = listen(PORT)#, backlog = 0)

clt = accept(srv)

running = true
while running
   cmd, arg = JSON.parse(readline(clt))

   res = nothing
   if cmd == "EXC"
      res = eval(Meta.parse(arg))
   elseif cmd == "PUT"
      res = cast(eval(Meta.parse("$(arg[1])=($(repr(arg[2])))")))
   elseif cmd == "IMP"
      # do something when not properly called
      eval(Meta.parse("import $(arg)"))
      res = eval(Meta.parse("filter(s->getproperty($arg,s) isa Function,names($arg))"))
   elseif cmd == "STP"
      global running
      res = "Bye"
      running = false
   end
   println(res)
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