#https://machinelearningmastery.com/solve-linear-regression-using-linear-algebra/

using Plots
pyplot()
#Initialize Data
# data = [0.05 0.12
#         0.18 0.22
#         0.31 0.35
#         0.2 0.38
#         0.5 0.49]

data = [43 99
        21 65
        25 79
        42 75
        57 87
        59 81]

println("Data : $data")

#Insert Data to X and y
X, y = data[:,1], data[:,2]

#Reshape X from 1x5 --> 5x1
X = reshape(X, 6, :)

println("X : $X")
println("y : $y")



#deriv_cost_function =- ((X^T*thetha) - y) * x
#0 = -X*(X^T*thetha) + X*y
#X*(X^T*thetha) = X*y
#thetha = X*Y / X^T*X 

b = inv((X'*X)) * X' * y
println(b)

yhat = X*b
println(yhat)

display(plot(X, yhat, title="TEST"))








