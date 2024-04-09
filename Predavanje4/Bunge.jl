using Pkg
Pkg.add("DifferentialEquations")
##
using DifferentialEquations
using Plots
##
L=30 #dulina užeta
cd=0.25 #koeficijent otpora
m=70 #masa
k=40 #elastičnost užeta (konst opruga)
gamma=8 #koeficijent prigušenja
##
p=(L,cd,m,k,gamma)
##
skok=function (du,u,p,t)
    L,cd,m,k,gamma=p
    g=9.81
    opruga=0
    pocetni_put=u[1]
    pocetna_brzina=u[2]
    if pocetni_put>L
        opruga=(k/m)*(pocetni_put-L)+(gamma/m)*pocetna_brzina
    end
    du[1]=pocetna_brzina
    du[2]=g-pocetna_brzina*abs(pocetna_brzina)*(cd/m)-opruga
    
end
##
u0=[0.0,0.0] #početni uvjeti
tspan=(0.0,50.0) #vremenski interval
problem=ODEProblem(skok,u0,tspan,p)
##
sol=solve(problem)
display(sol.u)
##
plot(sol,linewidth=2,title="Bungee jump",xaxis="Vrijeme",yaxis="Visina",label=["Visina","Brzina"])
##
##DZ
masses = [60, 65, 70, 75, 80]
for m in masses
    p = (L, cd, m, k, gamma)
    problem = ODEProblem(skok, u0, tspan, p)
    sol = solve(problem)
    plot!(sol, linewidth=2, label="m = $m kg")
end
plot!(xlims=(0, 50), ylims=(0, 2L), title="Bungee jump", xaxis="Vrijeme", yaxis="Visina", legend=:topright, annotations=[(50, 60, text("Max Distance: 60", :right))])