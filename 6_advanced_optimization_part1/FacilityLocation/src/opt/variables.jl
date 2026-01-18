"""
    Create variables
"""
function add_variables!(m::Model, FLD::FacilityLocationData)

    # demand to facility assignment 
    @variable(m, x[FLD.F, FLD.C] >= 0)

    # facility selection
    @variable(m, y[FLD.F], Bin)

    return x, y
end

# can also make functions for "groups" of variables (e.g., passenger variables, fleet variables, etc.)