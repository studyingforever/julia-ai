using LinearAlgebra

#Intialize
println("INTIALIZE\n=================")
matrix1 = Array{Int64,2}(undef, 3, 3)
println("Matrix 1:\n", matrix1, "\nCreated using Array{Int64,2}(undef,3,3)\n", "Type: ", typeof(matrix1), "\n")
matrix2 = Matrix{Int64}(undef, 3, 3)
println("Matrix 2:\n", matrix2, "\nCreated using Matrix{Int64}(undef,3,3)\n", "Type: ", typeof(matrix2), "\n")
matrix3 = zeros(Int64, 3, 3)
println("Matrix 3:\n", matrix3, "\nCreated using zeros(Int64,3,3)\n", "Type: ", typeof(matrix3), "\n")
matrix4 = rand(0:0, 3, 3)
println("Matrix 4:\n", matrix4, "\nCreated using rand(0:0,3,3)\n", "Type: ", typeof(matrix4), "\n")

#Accessing Matrix
println("\nACCESSING\n=================")
num = 1
for i = 1:size(matrix1, 1), j = 1:size(matrix1, 2)
    println("Loop: ", num)
    println("Matrix1 Row[$i] Column[$j]: $num")
    matrix1[i,j] = num
    global num += 1
end
println("Matrix1: $(matrix1)")


#Arithmathic Operation
println("\nARITHMATIC\n=================")
A = [1 2 
    3 4]
println("A = ", A)
B = [4 3
    2 1]
println("B = ", B)
println("A + B = $(A + B)")
println("A - B = $(A - B)")
println("A * B = $(A * B)")
println("A / B = $(A / B)")
println("A * inv(B) = $(A * inv(B))")
println("A * 3 = $(A * 3)")
println("A .^ 3 = $(A.^3)") #Power (Dot Operation)
println("A ^ 3 = $(A^3)")

A = collect(1:2:18)
println("Array A: $(A)")
B = reshape(A, 3, 3)
println("Matrix B (3x3) (Reshape from A): $(B)")
println("Transpose B: $(transpose(B))")
println("Inverse B: $(inv(B))")
I = [1 0 0
    0 1 0
    0 0 1]
println("Matrix I: $(I)")
println("Determinant I: $(det(I))")
println("Sum of diagonal I: $(tr(I))")

#Vector
println("\nVECTOR\n=================")
A = [1; 2; 3]
println("A [$(typeof(A))]= ", A)
B = [3; 4; 5]
println("B [$(typeof(B))]= ", B)
println("A x B = $(cross(A, B))") #Cross Product