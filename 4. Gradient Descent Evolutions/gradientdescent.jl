using Plots

println("Initiating data...\n")
# Initialize m, C
m = 100.0
println("m = $(m)")
C = -50.0
println("C = $(C)")

# Initialize dummy data
total_data = 11
println("\nTotal Data: $(total_data)")
x_data = Float64[i for i = 1:total_data]
println("X:\n$(x_data)")
y_data = Float64[i * 5 for i = 1:total_data]
println("Y:\n$(y_data)")

# Fill Dataset (using Dictionary)
dataset = Dict() 
for i = 1:total_data
    dataset[x_data[i]] = y_data[i]
end

# Prediction / Regression Line
# y' = mx + C
prediction_line(x) = m * x + C

# Real Data / Output
# f(x) = y
real_data(x) = dataset[x]

# Cost Function (y - y')
function cost_function(x_data)
    result = 0
    n = length(x_data)
    for i = 1:n
        t, o = real_data(x_data[i]), prediction_line(x_data[i])
        result += (t - o)
    end
    return result
end

# Loss Function = Mean Squared Error (1/n * Sigma((y - y')^2))
function mean_squared_error(x_data)
    squared_cf = 0
    n = length(x_data)
    for i = 1:n
        t, o = real_data(x_data[i]), prediction_line(x_data[i])
        squared_cf += ((t - o)^2)
    end
    n = length(x_data)
    return squared_cf / n 
end

# Derivative of Loss Function respect to m
# E = (1/n) * sigma((y - y')^2)
# E = (1/n) * sigma((y - (mx+c))^2)
# Em = (1/n) * sigma(2 * (y - (mx+c)) * (-x))
# Em = (-2/n) * sigma((y - y') * x)
function Em(x_data)
    n = length(x_data)
    sum = 0
    for i = 1:n
        x = x_data[i]
        t, o = real_data(x), prediction_line(x)
        sum += ((t - o) * x) 
    end
    result = (-2) * sum / n
    return result
end

# Derivative of Loss Function respect to C
# E = (1/n) * sigma((y - y')^2)
# E = (1/n) * sigma((y - (mx+c))^2)
# Ec = (1/n) * sigma(2 * (y - (mx+c)) * (-1)
# Ec = (-2/n) * sigma(y - y')
function Ec(x_data)
    n = length(x_data)
    result = (-2) * cost_function(x_data) / n
    return result
end

function draw_linear_regression(x_data, iteration, sleep_second)
    global m
    global C

    round_m = round(m, digits = 2)
    round_C = round(C, digits = 2)

    target = [real_data(x) for x in x_data]
    output = [prediction_line(x) for x in x_data]
    # Drawing Scatter
    result = Plots.plot(x_data, target, seriestype = :scatter,
                        xlabel = "Input",
                        ylabel = "Output", 
                        label = "Data",
                        title = "(i = $(iteration)) (m = $(round_m)) (C = $(round_C))")
    # Adding Prediction Line
    Plots.plot!(result, x_data, output, label = "Prediction Line")
    Plots.gui(result)
    # Sleep / Delay
    sleep(sleep_second)
end

# Gradient Descent
# m1 = m0 - (lr * Em)
# C1 = C0 - (lr * Ec)
function gradient_descent(learning_rate, loop, loop_print, limit_error)
    global x_data
    global m
    global C

    sleep_second = 0.3

    println("Doing Gradient Descent...")

    for iteration = 1:loop
        # 1. Calculate Cost / Error Function
        error = mean_squared_error(x_data)
        if (iteration % loop_print) == 0
            println("\nIteration: $(iteration)")
            println("[Error] = $(error)")
        end

        # 2. Checking Error Rate
        if error < limit_error
            println("\nStop at $(iteration)-th iteration")
            println("[Error] $(error) < [Limit Error] $(limit_error)")
            draw_linear_regression(x_data, iteration, sleep_second)
            break
        end

        # 2. Updating m & C
        new_m = m - (learning_rate * Em(x_data))
        new_C = C - (learning_rate * Ec(x_data))
        if (iteration % loop_print) == 0
            println("[Old] -> m = $(m) | C = $(C)")
            println("[New] -> m = $(new_m) | C = $(new_C)")
            draw_linear_regression(x_data, iteration, sleep_second)
        end
        m = new_m
        C = new_C
    end
end

# Ploting Current
# Param 1: x
# Param 2: Current iteration
# Param 3: Delay in Second
draw_linear_regression(x_data, 0, 0)

# Gradient Descent
# Param 1: Learning Rate
# Param 2: Maximum iteration
# Param 3: Print Data for each n iteration
# Param 4: Maximum Error Rate
gradient_descent(0.001, 100000, 100, 0.1)