using DifferentialEquations
using Plots; gr()
##pocetni parametri
alpha=1.2
beta=0.6
gamma=0.8
delta=0.3
p=(alpha,beta,gamma,delta)
##
function Lotka_Volterra(du,u,p,t)
    alpha,beta,gamma,delta=p
    du[1]=alpha*u[1]-beta*u[1]*u[2]
    du[2]=-gamma*u[2]+delta*u[1]*u[2]
end
##
u0=[5.0,2.0]
tspan=(0.0,30)
problem=ODEProblem(Lotka_Volterra,u0,tspan,p);
##
sol=solve(problem)
plot(sol, xlabel="Time", ylabel="Population", label=["Prey" "Predator"], title="Lotka-Volterra Model")

# Plot the relation between x and y
plot(sol, vars=(1,2), xlabel="Prey", ylabel="Predator", title="Phase Space Plot")
##
