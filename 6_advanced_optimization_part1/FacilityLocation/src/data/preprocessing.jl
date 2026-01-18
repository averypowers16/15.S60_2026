"""
Inputs:
- pop_fp: MA population filepath
- fac_fp: facility location filepath
- L: maximum facility locations that can be opened
- B: budget
"""
function FacilityLocationData(pop_fp::String, fac_fp::String, L::Int64, B::Float64)
    # note: this code is redundant with the above code, but that was preliminary data exploration
    # this allows us to modify the file path outside the constructor, and create new struct instances 
    population_data = CSV.read(pop_fp, DataFrame)
    population_data[:, "zip_code"] = replace.(population_data[:, "zip_code"], "z" => "")
    facility_data = CSV.read(fac_fp, DataFrame)
    
    # sets
    C = String.(population_data[:, "zip_code"])
    F = String.(facility_data[:, "facility_id"])
    
    # some extra info available in the pop dataframe
    city_county = Dict{String,String}(row["zip_code"] => row["city"] .* ", " .* row["county"] for row in eachrow(population_data) 
            if (!ismissing(row["city"]) & !ismissing(row["county"])))

    population_gps = Dict{String,Tuple{Float64,Float64}}(population_data[:, "zip_code"] .=> tuple.(population_data[:, "latitude"], 
            population_data[:, "longitude"]))

    facility_gps = Dict{String,Tuple{Float64,Float64}}(facility_data[:, "facility_id"] .=> tuple.(facility_data[:, "latitude"], 
        facility_data[:, "longitude"]))

    # facility capacity and fixed cost parameters
    P = Dict{String,Int64}(F .=> facility_data[:, "capacity"]) 
    K = Dict{String,Float64}(F .=> facility_data[:, "fixed_cost"])
                    
    # population parameters
    r = Dict{String,Int64}(population_data[:, "zip_code"] .=> population_data[:, "population"])
                
    # distances
    hav = Distances.Haversine(3958.8); # the radius of Earth in miles
    d = Dict{Tuple{String,String},Float64}(
        (res, fac) => Distances.evaluate(hav, rgps, fgps) for (res, rgps) in population_gps for (fac, fgps) in facility_gps)
                            
    return FacilityLocationData(L, B, C, F, r, P, K, d, city_county, population_gps, facility_gps)
end