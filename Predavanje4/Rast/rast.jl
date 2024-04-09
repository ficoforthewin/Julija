import Pkg
Pkg.add("CSV")
Pkg.add("DataFrames")
##
using CSV
using DataFrames
##
# Read the CSV file into a populacijaFrame
populacija = CSV.read("C:/Users/Filip/.vscode/JulijaZaFaks/Julija/Predavanje4/Rast/Populacija_zemlja.csv", DataFrame)
show(populacija, allcols=true, allrows=true)
populacija=populacija.Broj_ljudi
godina=populacija.Godina
##
using Plots

##
plot(populacija.Godina, populacija.Broj_ljudi, title="World Population", xaxis="Godina", yaxis="Broj_ljudi", label="Population", linewidth=2)
##

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