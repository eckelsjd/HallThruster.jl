abstract type BoundaryCondition end

struct Dirichlet <: BoundaryCondition
    state::Vector{Float64}
end

struct Neumann <: BoundaryCondition end

struct Dirichlet_ionbohm <: BoundaryCondition 
    state::Vector{Float64}
end

struct Neumann_ionbohm <: BoundaryCondition end

function apply_bc!(U, bc::Dirichlet, left_or_right::Symbol)
    if left_or_right == :left
        @. @views U[:, begin] = bc.state
    elseif left_or_right == :right
        @. @views U[:, end] = bc.state
    else
        throw(ArgumentError("left_or_right must be either :left or :right"))
    end
end

function apply_bc!(U, ::Neumann, left_or_right::Symbol)
    if left_or_right == :left
        @. @views U[:, begin] = U[:, begin + 1]
    elseif left_or_right == :right
        @. @views U[:, end] = U[:, end - 1]
    else
        throw(ArgumentError("left_or_right must be either :left or :right"))
    end
end

function apply_bc!(U, bc::Dirichlet_ionbohm, left_or_right::Symbol, ϵ0::Float64, mᵢ::Float64) #recombination missing
    if left_or_right == :left
        #@views U[1, begin] = bc.state[1]
        if U[3, begin] > -sqrt(2/3*e*ϵ0/mᵢ)*U[2, begin]
            @views U[3, begin] = -sqrt(2/3*e*ϵ0/mᵢ)*U[2, begin]
        end
    elseif left_or_right == :right
        @. @views U[1:2, end] = bc.state[1:2]
        if U[3, end] < sqrt(2/3*e*ϵ0/mᵢ)*bc.state[2]
            @views U[3, end] = sqrt(2/3*e*ϵ0/mᵢ)*bc.state[2]
        end
    else
        throw(ArgumentError("left_or_right must be either :left or :right"))
    end
end
