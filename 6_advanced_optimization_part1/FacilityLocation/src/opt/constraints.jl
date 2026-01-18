"""
    Add constraints
"""
function add_constraints!(m::Model, FLD::FacilityLocationData)

    x = m[:x]
    y = m[:y]

    # budget constraint 
    @expression(m, budget, sum(FLD.K[i] * y[i] for i in FLD.F))
    @constraint(m, budget <= FLD.B)

    # number of facilities 
    @constraint(m, num_loc, sum(y) <= FLD.L)

    # capacity
    @constraint(m, capacity[i in FLD.F], sum(x[i,:]) <= FLD.P[i] * y[i])

    # demand
    @constraint(m, demand[j in FLD.C], sum(x[:,j]) == FLD.r[j])
    
    return nothing
end

# can also make functions for "groups" of constraints (e.g., passenger constraints, fleet constraints, etc.)