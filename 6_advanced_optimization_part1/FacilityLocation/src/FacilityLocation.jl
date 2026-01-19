module FacilityLocation

using JuMP, Gurobi
using CSV
using DataFrames
using Plots
using Distances
using StatsBase
using Random

include("data/struct.jl")
include("data/preprocessing.jl")

include("opt/constraints.jl")
include("opt/objective.jl")
include("opt/optimize.jl")
include("opt/variables.jl")

include("output/solution.jl")

# add more files as needed

end