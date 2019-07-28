using Pkg

packages = ["Calculus","ForwardDiff"]

for package in packages
    Pkg.add(package)
end