script_dir = @__DIR__ 
include(joinpath(script_dir, "src/FacilityLocation.jl"))
using JuMP
using Plots
using CSV, DataFrames

# Load in experiments
# good practice to *not* hardcode parameters, and store experiment settings in a separate file 
experiments = CSV.read(joinpath(script_dir, "data/experiments.csv"), DataFrame)

# Run one experiment 
id = 11  # toggle the `id` only if you want to change parameter settings 
population_data_path = joinpath(script_dir, "data/formatted", "$(experiments[id, "population_data_path"])")
facility_data_path = joinpath(script_dir, "data/formatted", "$(experiments[id, "facility_data_path"])")
L = experiments[id, "L"]
B = experiments[id, "B"]
FLD = FacilityLocation.FacilityLocationData(population_data_path, facility_data_path, L, B)
ts, obj, (x_val, y_val) = FacilityLocation.run_opt(FLD)

# Run all our experiments 
dist = Float64[NaN for _ in 1:nrow(experiments)]
budget = Float64[NaN for _ in 1:nrow(experiments)]
for row in eachrow(experiments)
    population_data_path = joinpath(script_dir, "data/formatted", "$(row.population_data_path)")
    facility_data_path = joinpath(script_dir, "data/formatted", "$(row.facility_data_path)")
    L = row.L 
    B = row.B
    FLD = FacilityLocation.FacilityLocationData(population_data_path, facility_data_path, L, B)
    ts, obj, _ = FacilityLocation.run_opt(FLD)
    if ts == JuMP.OPTIMAL
        dist[row.id] = obj
    end
    budget[row.id] = B
end

scatter(budget, dist, ylab="Total distance traveled", xlab="Budget", legend=false)
