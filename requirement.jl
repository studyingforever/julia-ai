using Pkg

packages = ["Calculus","ForwardDiff","Plots"]

for package in packages
    Pkg.add(package)
end