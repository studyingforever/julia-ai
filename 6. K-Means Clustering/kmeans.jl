using Plots #For: plot, plot!, Animation, frame, gif, savefig 
using DelimitedFiles #For: writedlm, readdlm

#Full color <http://juliagraphics.github.io/Colors.jl/stable/namedcolors/>
colors = [:red :orange :yellow :green :cyan :blue :purple :brown :pink]

function load_csv(file)
    csv_file = readdlm(file)
    #Skip Header
    return csv_file[2:1:end,:]
end

#Load Dataset
function load_k_means_dataset(file)
    points = Matrix{Float64}(undef, 0, 2)
    n_data = 0
    println("Load Dataset <$(file)>...")
    csv_file = load_csv(file)
    for row in csv_file
        n_data = n_data + 1
        point = Float64[]
        for data in split(row, ",")
            push!(point, parse(Float64, data))
        end
        points = vcat(points, reshape(point, 1, 2))
    end
    println("Success Load! <Total Data: $(n_data)>")
    return n_data, points
end

#Euclidean Distance
function distance(point, centroid)
    x_diff = centroid[1] - point[1]
    y_diff = centroid[2] - point[2]
    return sqrt(x_diff^2 + y_diff^2)
end

#Assign Data to Cluster / Group
function updateGroups(points, centroids, groups)
    update = 0
    n_centroids = size(centroids, 1)
    n_points = size(points, 1)
    # println("Checking groups of each points...")
    for i = 1:n_points
        #Initialize with Max Distance
        min_dist = Inf
        group = groups[i]
        for j = 1:n_centroids
            curr_dist = distance(points[i,:], centroids[j,:])
            # println("Point-$(i) to Centroid-$(j) = $curr_dist")
            if curr_dist < min_dist
                min_dist = curr_dist
                group = j
            end
        end
        # println("Minimum Distance Point-$(i) to Centroid: $(min_dist)")
        if group != groups[i]
            # println("Point-$(i): Group-$(groups[i]) -> Group-$(group)")
            groups[i] = group
            update = update + 1
        end
    end
    println("Total group changes: $(update)")
    if update != 0
        println("Groups updated!")
    else
        println("No Groups updated!")
    end
    return groups, update
end

#Update Centroids Position
function updateCentroid(points, centroids, groups)
    n_centroids = size(centroids, 1)
    n_points = size(points, 1)
    total_x, total_y, total_members = [0.0 for i = 1:n_centroids], [0.0 for i = 1:n_centroids], [0.0 for i = 1:n_centroids]

    for i = 1:n_points
        total_x[groups[i]] += points[i,1]
        total_y[groups[i]] += points[i,2]
        total_members[groups[i]] += 1 
    end
    println("Updating Centroids...")
    for i = 1:n_centroids
        new_centroid_x = total_x[i] / total_members[i]
        new_centroid_y = total_y[i] / total_members[i]
        # print("Centroid-$(i) = ($(centroids[i,1]),$(centroids[i,2])) -> ($(newCentroidX),$(newCentroidY))")
        centroids[i,1] = new_centroid_x
        centroids[i,2] = new_centroid_y
    end
    println("Centroids Updated!")
    return centroids
end

#Drawing Plot
function draw(points, groups, centroids, n_centroid, labels, colors, iteration)
    result = plot(title = "K-Means (i-$(iteration))")
    point_colors = reshape([colors[groups[i]] for i = 1:length(groups)], length(groups), 1)
    #Drawing Points
    plot!(result, points[:,1], points[:,2], seriestype = :scatter, color = point_colors, label = "", markersize = 3)
    #Drawing Centroids
    plot!(result, reshape(centroids[:,1], 1, n_centroid), reshape(centroids[:,2], 1, n_centroid), seriestype = :scatter, color = colors, label = labels, markersize = 6)
    return result
end

#K-Means
function kmeans(points, centroids, groups, colors, labels, max_iteration, is_animation)
    update = -1
    n_centroid = size(centroids, 1)
    animation = Animation()
    last_iteration = 0

    for iteration = 1:max_iteration        
        println("\nLoop: $(iteration)")
        groups, update = updateGroups(points, centroids, groups)
        
        if is_animation
            result = draw(points, groups, centroids, n_centroid, labels, colors, iteration)
            frame(animation) #Save plot frame per iteration
        end

        if update == 0
            last_iteration = iteration
            break
        end
        centroids = updateCentroid(points, centroids, groups)
    end

    if is_animation
        return animation
    else
        return draw(points, groups, centroids, n_centroid, labels, colors, last_iteration)
    end
end

#Write result in CSV
function save_result_csv(points, groups, result_filename)
    n_data = length(groups)
    result = Matrix(undef, 0, 3)
    result = vcat(result, ["X" "Y" "Groups"])
    for i = 1:n_data
        result = vcat(result, [points[i,1] points[i,2] groups[i]])
    end
    open("$(result_filename).csv", "w") do file
        writedlm(file, result, ",")
    end
end

function do_kmeans(points, centroids, max_iteration, is_animation, result_filename)
    global colors
    
    println("Starting K-Means...")
    #Initiate label for each cluster
    n_centroid = size(centroids, 1)
    labels = ["Cluster-$(x)" for x = 1:n_centroid]
    #Initiate group for each point
    n_data = size(points, 1)
    groups = [0 for i = 1:n_data]
    
    #See Initial Points and Centroids
    # result = plot(title = "K-Means (i-0)")
    # plot!(result, points[:,1], points[:,2], seriestype = :scatter, color = :grey, label = "None", markersize = 3)
    # plot!(result, reshape(centroids[:,1], 1, n_centroid), reshape(centroids[:,2], 1, n_centroid), seriestype = :scatter, color = colors, label = labels, markersize = 6)
    # gui(result)
    # println("Press ENTER to Continue")
    # readline()

    if is_animation
        result = kmeans(points, centroids, groups, colors, labels, max_iteration, true)
        gif(result, "$(result_filename).gif", fps = 8)
    else
        result = kmeans(points, centroids, groups, colors, labels, max_iteration, false)
        savefig(result, "$(result_filename).png")
    end
    save_result_csv(points, groups, result_filename)
    println("Result has been saved!")
    println("K-Means Finished!")
end

#Open K-Means Result CSV File
function open_k_means_result(file)
    global colors
    csv_file = load_csv(file)
    result = plot(title = "K-Means")
    groups = Dict()
    for row in csv_file
        columns = split(row, ",")
        point = [0.0 0.0]
        group = 0
        for (index, data) in enumerate(columns)
            data = parse(Float64, data)
            if index == 1
                point[1] = data
            elseif index == 2
                point[2] = data
            else
                group = Int64(data)
            end
        end
        #Check group already exists -> get(dict, element, default value)
        if get(groups, group, 0) == 0
            groups[group] = length(groups) + 1
            plot!(result, [point[1]], [point[2]], seriestype = :scatter, color = colors[group], label = "Cluster-$(groups[group])", markersize = 3)
        else
            plot!(result, [point[1]], [point[2]], seriestype = :scatter, color = colors[group], label = "", markersize = 3)
        end
    end
    return result
end