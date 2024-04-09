##
global m=70
global cdv = 0.25
global g= 9.81
##
##funkcija za derivaciju
function deriva(v)
    dv=g-((cdv/m)*v*abs(v))
    return dv
end
#brzina function
function brzina(v0,dt,tp,tk)
    n=(tk-tp)/dt
    vi=v0
    ti=tp
    for i=1:n
        dvdt=deriva(vi)
        vi=vi+dvdt*dt
        ti=ti+dt
        #println("$i")
    end
    return vi
end
#poziv funkicje
rez=brzina(0,1,0,14)
display(rez)
## ukraden kod
function brzina2(v0,dt,tp,tk) # v0-početna vrijednost brzine (ovisne varijable),dt-vremenski korak, tp-početno vrijeme, tk-konačno vrijeme 
    vi=v0
    ti=tp
    s=dt # unosimo ovu varijablu da bi po potrebi negdje drugdje kasnije znali vrijednost dt
    br=zeros(0) # vektor za spremanje brzine svakog intervala (ovaj put želimo vratiti brzinu u svakoj točci, ne samo onu na kraju intervala)
    vrijeme=zeros(0) # 
    put=zeros(0) # ako želimo prijeđeni put u svakom koraku radimo ovaj vektor
    p=0 # za izračun puta
    while true
        if ti+dt>tk # testiranje da ne idemo preko konačnog intervala
            s=tk-ti # ako idemo preko intervala onda skraćujemo vrijeme koraka - time garantiramo da će korak završiti na tk
        end
        dvdt= deriva(vi)
        append!(br,vi) # da bi imali brzinu u svakom intervalu
        append!(vrijeme, ti)
        append!(put,p)
        p=p-vi*s 
        vi=vi+dvdt*s
        ti=ti+s
        if ti>=tk # kada je vrijeme ti veće od konačnog vremena intervala prekidamo petlju
            break
        end
        #println("$i")
    end
    append!(br,vi) # da bi imali brzinu u svakom intervalu
    append!(vrijeme, ti)
    append!(put,p)
    return vi, br, vrijeme, put
end
## pozivanje funkcije
rez, brzi, vrijeme, put=brzina2(0,0.5,0,14)