using JuMP
using Cbc

include("PCInstance.jl")
include("read_instance.jl")
instance = read_instance("instances/1.out")

# Model
m = Model(solver = CbcSolver())

# Variables
@variable(m, y[1:instance.n], Bin) # (18)
@variable(m, z[1:instance.K], Bin) # (19)

# Objective
@objective(m, Min, sum(instance.rho[k] * z[k] for k = 1:instance.K))  # (14)

#Parameter a
a = zeros(instance.n, instance.n, instance.K)
zq = 0

# Constraints
for i = 1:instance.n
  for k = 1:instance.K
    for j = 1:instance.n
		instance.d[i,j] <= instance.rho[k] ? a[i,j,k] = 1 : nothing
	end
    zq = z[k] + zq
    @constraint(m, sum(a[i,j,k] * y[j] for j = 1:instance.n) >= zq) # (22)
  end
end

@constraint(m, sum(y[j] for j = 1:instance.n) <= instance.p) # (16)
@constraint(m, sum(z[k] for k = 1:instance.K) == 1) # (17)

# Resolution
status = solve(m)
println("Objective value: ", getobjectivevalue(m))

for i = 1:instance.n 
	if (y[i] == 1)
		println("y = 1, index :", i)
	end
end