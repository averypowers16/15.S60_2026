
"""
    Facility location data struct
"""
struct FacilityLocationData
    # constants 
    L::Int64        # location limit
    B::Float64      # budget
    
    # sets
    C::Vector{String}  # zip codes 
    F::Vector{String}  # facility IDs
    
    # parameters
    r::Dict{String,Int64}                  # demand 
    P::Dict{String,Int64}                  # facility capacity
    K::Dict{String,Float64}                # fixed cost
    d::Dict{Tuple{String,String},Float64}  # distances
    
    # extra information
    city_county::Dict{String,String}                     # city/county zip code map
    population_gps::Dict{String,Tuple{Float64,Float64}}  # GPS points of each zip code
    facility_gps::Dict{String,Tuple{Float64,Float64}}    # GPS points of each facility
end