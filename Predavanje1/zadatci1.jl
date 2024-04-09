##1
x=y=1 #dobimo 1
x
y
##2
15=a #error krivi redoslijed
##3
xy #nije definirano
x*y #umnozak 1*1
##4
function volumen(a,vrsta)
    if vrsta=="kocka"
        return a^3
    elseif vrsta=="sfera"
        return 4/3*π*a^3
    end
end
volumen(3,"kocka")
volumen(3,"sfera")
##5
function abs(a)
    if a<0
        return -a
    else
        return a
    end
end
abs(-5)
##6
function udaljenost(x1,y1,x2,y2)
    return sqrt((x2-x1)^2+(y2-y1)^2)
end
udaljenost(1,1,2,2)
##7
for i=1:1:30
    if i%3!==0
        println(i)
    end
end
##8
str="Volim studirati u zagrebu"
count=0
for a in str
    if a == 'a'
        count += 1
    end
end
println(count)
##

