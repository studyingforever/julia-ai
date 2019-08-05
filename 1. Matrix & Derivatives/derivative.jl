using Calculus
using ForwardDiff

#Using differentiate
#String Expression
stringExpr = "x^2 + 2x"
#Expression
expr = Meta.parse(stringExpr)
println(typeof(expr), ": ", expr)
#Expression after differentiate (without simplify)
expr2 = differentiate(stringExpr, :x)
println(typeof(expr2), ": ", expr2)
#Expression after differentiate (with simplify)
expr2 = simplify(differentiate(stringExpr, :x))
println(typeof(expr2), ": ", expr2)

#Using derivative
f(x) = x^2 + 2x
#Comparison between ForwardDiff and Calculus derivative
for i = 1:10
    println(ForwardDiff.derivative(f, i), "\t", Calculus.derivative(f)(i))
end