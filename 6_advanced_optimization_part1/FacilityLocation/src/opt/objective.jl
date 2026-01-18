
"""
    Create model objective
"""
function add_objective(m::Model, FLD::FacilityLocationData)
    x = m[:x]
    @objective(m, Min, sum(FLD.d[(j,i)] * x[i,j] for i in FLD.F for j in FLD.C))
end

# the @expression macro can also be useful, if your objective has many components (but good to benchmark)