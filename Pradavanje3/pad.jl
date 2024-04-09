##
## parametri i varijable
m=70
cdv=0.25
t=0:0.5:14
##t=collect(t)
g=9.81
##
v = sqrt(g * m / cdv) .* tanh.((sqrt.(g * cdv / m) .* t))
##
using Plots

plot(t, v, xlabel="Time", ylabel="Velocity", title="Velocity vs Time", label="Brzina ovisna o vremenu", ylims=(0, maximum(v)*1.1))
hline!([sqrt(g * m / cdv)], linestyle=:dash, label="Terminal Velocity")
##

