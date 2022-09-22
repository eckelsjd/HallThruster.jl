module HallThruster

using StaticArrays
#using OrdinaryDiffEq
#using DiffEqCallbacks

using LinearAlgebra
using DocStringExtensions

using SparseArrays: Tridiagonal
using PartialFunctions
using QuadGK: quadgk
using DelimitedFiles: readdlm, writedlm
using SpecialFunctions: erf
using FunctionWrappers: FunctionWrapper
using Unitful: @u_str, uconvert, ustrip, Quantity
import SnoopPrecompile

using JSON3

# Packages used for making plots
using Measures: mm
using RecipesBase

# path to the HallThruster directory
const PACKAGE_ROOT = joinpath(splitpath(@__DIR__)[1:(end - 1)]...)
const REACTION_FOLDER = joinpath(PACKAGE_ROOT, "reactions")
const LANDMARK_FOLDER = joinpath(PACKAGE_ROOT, "landmark")
const LANDMARK_RATES_FILE = joinpath(LANDMARK_FOLDER, "landmark_rates.csv")

include("utilities/utility_functions.jl")
include("utilities/transition_functions.jl")

include("physics/physicalconstants.jl")
include("physics/gas.jl")
include("physics/conservationlaws.jl")
include("physics/fluid.jl")
include("physics/thermodynamics.jl")

include("wall_loss_models/wall_losses.jl")
include("wall_loss_models/no_wall_losses.jl")
include("wall_loss_models/constant_sheath_potential.jl")
include("wall_loss_models/wall_sheath.jl")

include("numerics/finite_differences.jl")
include("numerics/limiters.jl")
include("numerics/flux.jl")

include("collisions/anomalous.jl")
include("collisions/reactions.jl")
include("collisions/ionization.jl")
include("collisions/excitation.jl")
include("collisions/elastic.jl")
include("collisions/charge_exchange.jl")
include("collisions/collision_frequencies.jl")

include("simulation/initialization.jl")
include("simulation/geometry.jl")
include("simulation/postprocess.jl")
include("simulation/boundaryconditions.jl")
include("simulation/potential.jl")
include("simulation/heavy_species.jl")
include("simulation/electronenergy.jl")
include("simulation/sourceterms.jl")
include("simulation/update_values.jl")
include("simulation/configuration.jl")
include("simulation/restart.jl")
include("simulation/ssprk_step.jl")
include("simulation/simulation.jl")
include("visualization/plotting.jl")
include("visualization/recipes.jl")

export time_average, Xenon, Krypton

# Precompile statements to improve load time
SnoopPrecompile.@precompile_all_calls begin
    for flux_function in [global_lax_friedrichs, rusanov, HLLE]
        for reconstruct in [true, false]
            config = Config(;
                thruster = SPT_100,
                domain = (0.0u"cm", 8.0u"cm"),
                discharge_voltage = 300.0u"V",
                anode_mass_flow_rate = 5u"mg/s",
                scheme = HyperbolicScheme(;
                    flux_function, limiter = van_leer, reconstruct
                )
            )
            HallThruster.run_simulation(config; ncells=20, dt=1e-8, duration=1e-7, nsave=2)
        end
    end
end

#=
using HallThruster

config = HallThruster.Config(;
    thruster = HallThruster.SPT_100,
    domain = (0.0u"cm", 8.0u"cm"),
    discharge_voltage = 300.0u"V",
    anode_mass_flow_rate = 5u"mg/s",
)
HallThruster.run_simulation(config; ncells=20, dt=1e-8, duration=1e-7, nsave=2)
=#

end # module
