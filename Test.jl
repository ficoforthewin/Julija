function factorial(n)
    if n == 0
        return 1
    else
        return n * factorial(n - 1)
    end
end

println("Enter a number:")
number = readline()
println(factorial(parse(Int, number)))