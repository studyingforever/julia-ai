# https://en.wikibooks.org/wiki/Introducing_Julia
# https://www.statisticshowto.datasciencecentral.com/probability-and-statistics/regression-analysis/find-a-linear-regression-equation/

using Plots
pyplot()
println("========================")
println("|  LINEAR REGRESSION   |")
println("========================")
pyplot()
# Initialize Data
# age = [43,21,25,42,57,59]
# glucose = [99,65,79,75,87,81]

age = [1, 2, 3, 4]
glucose = [3,4,5,6]
n = length(age)

println("Initialize Data")
println("===============")
println("Data umur : $age")
println("Data glucose : $glucose")
println("Array Length : $n")

age2 = Array{Int}(undef, 0)
glucose2 = Array{Int}(undef, 0)
agexglucose = Array{Int}(undef, 0)
sumage = 0
sumglucose = 0
sumagexglucose = 0
sumage2 = 0
sumglucose2 = 0

# # Data Processing
# for i in 1:length(age)
#     global agexglucose = age[i] * glucose[i]
#     global sumagexglucose += agexglucose

#     x = age[i] * age[i] 
#     global sumage2 +=x
#     push!(age2, x)

#     y = glucose[i] * glucose[i]
#     push!(glucose2, y)
#     global sumglucose2 += y

#     global sumage += age[i]
#     global sumglucose += glucose[i]
# end

sumagexglucose = sum(age.*glucose)
sumage2 = sum(age.^2)
glucose2 = sum(glucose.^2)
sumage = sum(age)
sumglucose = sum(glucose)

println("\nPre Processed Data")
println("===============")
println("Data umur * glucose : $agexglucose")
println("Data umur^2 : $age2")
println("Data glucose^2 : $glucose2")
println("")
println("Total umur : $sumage")
println("Total glucose : $sumglucose")
println("Total umur * glucose : $sumagexglucose")
println("Total umur^2 : $sumage2")
println("Total glucose^2 : $sumglucose2")

println("\nResults")
println("===============")
alpha = ((sumglucose * sumage2 ) - (sumage * sumagexglucose)) / ( (n * sumage2) - (sumage * sumage))
println("Alpha : $alpha")

beta = ((n * sumagexglucose) - (sumage * sumglucose)) / ((n * sumage2) - (sumage * sumage))
println("Beta : $beta")

println("y = $alpha + $beta", "x")
# graph = plot(age,glucose, seriestype=:scatter, title= "Test")
# plot!(graph)
display(plot(age,glucose, title= "Test"))