using Plots
plotly()
gr()
x=1:0.1:2*pi
y=cos.(x).^2
y2=sin.(x).^2	#elementwise
plot(x,y,label="cos^2(x)")
plot!(xlab="x",ylab="f(x)")
plot(x,y2,label="cos^2(x)")
##
using Plots
plotly()
gr()
a=1:20;b=rand(20,5)
c=1:5
d=rand(5,2)
g=1:25;h=rand1:25