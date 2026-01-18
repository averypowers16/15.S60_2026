"""
    Constructs a FacilityLocationData object and run the model
"""
function run_opt(FLD::FacilityLocationData)

    # build model
    m = Model(Gurobi.Optimizer)
    x, y = FacilityLocation.add_variables!(m, FLD)
    FacilityLocation.add_constraints!(m, FLD)
    FacilityLocation.add_objective(m, FLD)

    # solve the model
    optimize!(m)
    term_status = JuMP.termination_status(m)
    if term_status == MOI.OPTIMAL
        obj = JuMP.objective_value(m)
        x_val = JuMP.value.(m[:x])
        y_val = JuMP.value.(m[:y])
        return term_status, obj, (x_val, y_val)
    end
    return term_status, nothing, nothing
end