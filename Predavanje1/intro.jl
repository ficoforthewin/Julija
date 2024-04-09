##
println("hello world")
15+5
a=5
b=10
a+b
b=30

##
10+1
11+3
25+6
72/12
##
println("hello world\n")

println("Julija jeeeej")
##
ime="Julija"
godine=25
tezina=60
visina=170.3
println("moje ime je $ime, imam $godine godina, tezim $tezina kg i visoka sam $visina cm")

typeof(ime)
typeof(godine)
typeof(tezina)
typeof(visina)
##
1.5e-2
1.5f-2
1.0/Inf
1.0/0.0
100-Inf
Inf-Inf
##
rac=5//2
kompl=3+4im
typeof(rac)
typeof(kompl)
rac+kompl
float(rac)
numerator(rac)
denominator(rac)
##
5<2
5>2
typeof(ans)
true + true
true + false
false + false
true * true
true * false
false * false
##
function primjer1()
    z=12
    return 
end
function primjer2()
    global z=12
    return 
end
function primjer3()
    z=12
    return z
end
function primjer4()
    global z=12
    return z
end
2967*0.012
5.6*8
true && false
a=5
b=10
a!==b
function pozdrav(doba_dana)
    if doba_dana == "jutro"
        println("Dobro jutro!")
    elseif doba_dana == "podne"
        println("Dobar dan!")
    elseif doba_dana == "vecer"
        println("Dobro veče!")
    else
        println("Dobro doba dana!")
    end
end
pozdrav("jutro")
##
a,b,c=sin(0.5),cos(0.5),tan(0.5) #ovo radi aparantly
##
kvadrat(x)=x^2
function kvadrat2(x)
    return x^2
end
kvadrat3(x)=x->x^2
kvadrat(5)
kvadrat2(5)
kvadrat3(5)
a=kvadrat3(5)
b=kvadrat2(5)
c=kvadrat(5)
##
function nekafija(a,b=15;c,d=5)
    return a+b+c+d
    
end
nekafija(1,c=25)
nekafija(1,2,c=25)
##
8*5.6
50/0.012
##
for i in 1:5
    println(i)
end
for i=5:-1:1
    println(i)
end
for i in 1:2:5
    println(i)
end
osobe=["Ana","Ivan","Petar","Maja"]
for osoba in osobe
    println(osoba)
end
##
using Pkg
Pkg.status()
Pkg.update()
Pkg.add("Plots")
using Plots
##
10*10^3/((0.25*10^-3)*2+(1.001*10^3)/(10*10^3))