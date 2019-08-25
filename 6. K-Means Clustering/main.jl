include("kmeans.jl")
using Random #For: shuffle

result_filename = "K-Means Result"

#Initiate Random Dataset
# range_data = 100
# n_data = 3000
# points = rand(n_data, 2) * range_data #rand(n_data, 2) -> 2-D data from 0 to 1

#Initiate Dataset <From: https://github.com/mubaris/friendly-fortnight>
n_data, points = load_k_means_dataset("xclara.csv")

#Intialize Centroids
n_centroid = 9
shuffled = points[shuffle(1:end), :]
centroids = view(shuffled, 1:n_centroid, :) #Initialize from random points

#Do K-Means Clustering
max_iteration = 1000
is_animation = true
# Param 1: Dataset (2-D)
# Param 2: Centroid (2-D)
# Param 3: Maximum Iteration
# Param 4: Do Animation (True = Gif, False = Png)
# Param 5: Result Filename
do_kmeans(points, centroids, max_iteration, is_animation, result_filename)

# See result here
# result = open_k_means_result("$(result_filename).csv")
# gui(result)
# println("Press ENTER to EXIT...")
# readline()