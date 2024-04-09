using Pkg
Pkg.add("DataFrames")
Pkg.add("CSV")
using DataFrames
using CSV
##
##
populacija = CSV.read("C:/Users/Filip/.vscode/JulijaZaFaks/Julija/Predavanje4/Rast/Populacija_zemlja.csv", DataFrame) # učitamo podatke koje imamo u datoteci
show(populacija)
godina=populacija[:,1] 
broj=populacija[:,2]./1e9 # da imamo broj u milijardama
## vizualizacija poznatih podataka o populaciji
using Plots
plot(godina, broj, label="Stanovništvo svijeta", legend = :bottomright) # osnovna naredba za plot
plot!(xlab="vrijeme [god]", ylab="broj stanovnika [milijarde]")
savefig("Stanovništvo_poznato.png")
## pogledajmo koliki je ukupni rast i koliko je godišnji rast od 1950te do 2020 prema podacima modela koji imamo
show(populacija[1,2])
pop_prva_god=populacija[1,2]
pop_zadnja_god=populacija[nrow(populacija),2]
ukupni_rast=pop_zadnja_god-pop_prva_god
vrijeme_poc=populacija[1,1]
vrijeme_kon=populacija[nrow(populacija),1]
vrijeme=vrijeme_kon-vrijeme_poc
godisnji=ukupni_rast/vrijeme
## simulacija rasta po godisnji - koristeći samo godišnji rast - linearni rast
function model_1(t_prva,t_zadnja,pop0,god_rast)
    model=zeros(0)
    append!(model, pop0)
    for i in 2:(t_zadnja-t_prva)+1
        append!(model, model[i-1]+god_rast)
    end
    return model
end

model1=model_1(vrijeme_poc,vrijeme_kon,pop_prva_god,godisnji)

plot!(godina, model1./1e9, label="Stanovništvo svijeta_model1", legend = :bottomright) # osnovna naredba za plot
savefig("Stanovništvo_model1.png")
##
## ako uključimo rođenja i smrti - eksponencijalni rast
function model_2(t_prva,t_zadnja,pop0,stopa_rođenja, stopa_smrti)
    model=zeros(0)
    append!(model, pop0)
    for i in 2:(t_zadnja-t_prva)+1
        rast=(stopa_rođenja-stopa_smrti)*model[i-1]
        append!(model, model[i-1]+rast)
    end
    return model
end
model2=model_2(vrijeme_poc,vrijeme_kon,pop_prva_god, 0.03, 0.011)
#godina=1950:1:2300
plot!(godina, model2./1e9, label="Stanovništvo svijeta_model2", legend = :bottomright)
savefig("Stanovništvo_model2.png")
##
## ako uključimo rođenja i smrti - kvadratni rast
function model_3(t_prva,t_zadnja,pop0,alpha, beta)
    model=zeros(0)
    append!(model, pop0./1e9)
    for i in 2:(t_zadnja-t_prva)+1
        rast=alpha*model[i-1]+beta*model[i-1]*model[i-1]
        println(rast)
        append!(model, model[i-1]+rast)
    end
    return model
end
model3=model_3(vrijeme_poc,vrijeme_kon,pop_prva_god, 0.025, -0.0018)

plot!(godina, model3, label="Stanovništvo svijeta_model3", legend = :bottomright)
savefig("Stanovništvo_model3.png")
## pogledajmo rast u odnosu na broj ljudi u milijardama
populacija_vektor=range(0, 15, length=100)
rast=0.025.*populacija_vektor-0.0018*populacija_vektor.^2
plot(populacija_vektor,rast, label="Stopa rasta ovisno o populaciji")
plot!(xlab="broj stanovnika [milijarde]", ylab="stopa rasta [milijarde]")
savefig("Stopa rasta.png")

## model konačni
function model_4(t_prva,t_zadnja,pop0,r, K)
    model=zeros(0)
    append!(model, pop0./1e9)
    for i in 2:(t_zadnja-t_prva)+1
        rast=r*model[i-1]*(1-(model[i-1]/K))
        #println(rast)
        append!(model, model[i-1]+rast)
    end
    return model
end
function parametri_populacije(alpha, beta)
    K=-(alpha/beta)
    r=alpha
    return r,K
end
r, Kap=parametri_populacije(0.025,-0.0018)
model4=model_4(vrijeme_poc,vrijeme_kon, pop_prva_god, r, Kap)

plot!(godina, model4, label="Stanovništvo svijeta_model4", legend = :bottomright)
savefig("Stanovništvo_model4.png")


###
### PROJEKCIJA POPULACIJE DO 2300 godine
r, Kap=parametri_populacije(0.025,-0.0018)
predikcija=model_4(vrijeme_poc,2300,populacija[1,2], r, Kap)
godine=1950:1:2300
plot!(godine, predikcija, label="Stanovništvo svijeta_projekcija", legend = :bottomright)
savefig("Stanovništvo_projekcija.png")
## usporedba projekcije s projekcijom UNa do 2100
projekcija = CSV.read("Projekcija.csv", DataFrame) # učitamo podatke koje imamo u datoteci
show(pro)
pro=vcat(populacija,projekcija)
godine=pro[:,1] 
broj=pro[:,2]./1e9
plot(godine, broj, label="Stanovništvo svijeta_UN projekcija", legend = :bottomright) # osnovna naredba za plot
plot!(xlab="vrijeme [god]", ylab="broj stanovnika [milijarde]")
r, Kap=parametri_populacije(0.025,-0.0018)
predikcija=model_4(pro[1,1],2100,pro[1,2], r, Kap)
show(predikcija)
godine=1950:1:2100
plot!(godine, predikcija, label="Stanovništvo svijeta_modelirana projekcija", legend = :bottomright)
savefig("Stanovništvo_projekcija_usporedba.png")

##
## populacija linearni rast
der_pop_1 = function (du,u,p,t) 
    alpha = p
    du[1] = u[1]*alpha
end
#
stopa_rođenja, stopa_smrti=0.03, 0.011
p = stopa_rođenja-stopa_smrti
#
u0 = [pop_prva_god./1e9]; 
tspan = (1950.0,2020.0) 
using DifferentialEquations

problem = ODEProblem(der_pop_1,u0,tspan,p); # zadaje se ODE problem - unutar solvea će se zvati naša prethodno napisana funkcija
# Rješimo problem
sol1 = solve(problem) # rješava se ode problem
#sol = solve(problem,DP5());
# Vizualizacija problema
plot(godina, broj, label="Stanovništvo svijeta", legend = :bottomright) # osnovna naredba za plot
plot!(xlab="vrijeme [god]", ylab="broj stanovnika [milijarde]")
plot!(sol1,label="Stanovništvo svijeta_model_lin_derivacija", legend = :topright)
savefig("Stanovništvo svijeta_model_lin_derivacija.png")

## populacija logički rast - derivacija
der_pop_2 = function (du,u,p,t)
    r, K=p
    du[1] = u[1]*(r*(1-u[1]/K))
    
end
#
alp, beta=0.025, -0.0018
p = (alp, -(alp/beta))
#
u0 = [pop_prva_god./1e9] # 
tspan = (1950.0,2020.0) 
problem = ODEProblem(der_pop_2,u0,tspan,p); # zadaje se ODE problem - unutar solvea će se zvati naša prethodno napisana funkcija
# Rješimo problem
sol2 = solve(problem) # rješava se ode problem
#sol1 = solve(problem,Euler(),dt=1);
# Vizualizacija problema
plot!(sol2,label="Stanovništvo svijeta_model_log_derivacija", legend = :topright)
savefig("Stanovništvo svijeta_model_log_derivacija.png")