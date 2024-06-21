#!/usr/local/bin/julia

using Sockets, JSON
const PORT = parse(Int, ARGS[1])

# Not used anymore
# cast(x) = x isa Array ? cast.(x) : convert(typeof(x),x)

# Receives an array of arrays w/ nested-flat annotations
# returns a julia proper array
# e.g.
# v = ["n",
#      ["f",[1,2,3],[4,5,6]],
#      ["f",[1,-2,3],[-4,-3,6]]]

nest(x) = if x isa Array
    if first(x) == "n"
        nest.(x[2:end])
    else
        stack(nest.(x[2:end]))
    end
else
    x
end

srv = listen(PORT)

clt = accept(srv)

running = true
while running
    cmd, arg = JSON.parse(readline(clt))
    println("cmd:\t$cmd")
    println("arg:\t$arg")
    res = nothing
    if cmd == "EXC"
        res = eval(Meta.parse(arg))
    elseif cmd == "PUT"
        res = eval(Meta.parse("$(arg[1])=nest($(repr(arg[2])))"))
    elseif cmd == "IMP"
        # do something when not properly called
        eval(Meta.parse("import $(arg)"))
        # res = eval(Meta.parse("filter(s->any(isa.(getproperty($arg,s),[Function])),names($arg))"))
        res = eval(Meta.parse("filter(s->getproperty($arg,s) isa Function,names($arg))"))
    elseif cmd == "CLL"
        res = eval(Meta.parse("$(arg[1])(nest($(repr(arg[2]))))"))
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
# - (maybe) simplify nestflat annotation. No annotation needed if all elements are scalars
# - fix EXC to handle knested jsons
# - handle julia errors - connection should stay alive and return jsoned
#  julia error (which I should unpack in k to throw a k error)
