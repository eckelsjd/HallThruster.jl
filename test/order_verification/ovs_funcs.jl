using HallThruster
using Statistics

function Lp_norm(v, p)
    factor = length(v)^(-1/p)
    return factor * norm(v, p)
end

function sin_wave(var; amplitude, phase, nwaves, offset = 0.0)
    return amplitude * sin(nwaves * (2π * var) + phase) + offset
end

function test_refinements(verification_func, refinements, norm_orders)
    norms = [
        let results = verification_func(ncells)
            [Lp_norm(res.sim .- res.exact, p) for res in results, p in norm_orders]
        end
        for ncells in refinements
    ] |> unzip

    slopes = [expsmooth(compute_slope(refinements, norm), 0.75)[end] for norm in norms]
    return slopes, norms
end

function unzip(v)
    ncolumns = length(v[1])
    nrows = length(v)
    return [
        [v[j][i] for j in 1:nrows] for i in 1:ncolumns
    ]
end

function compute_slope(refinements, errors)
    q = [
        #log(abs(errors[i+2]-errors[i+1])/abs(errors[i+1]-errors[i]))/log(0.5) for i in 1:length(errors)-2
        log(errors[i+1] / errors[i]) /
        log(refinements[i] / refinements[i+1])
        for i in 1:length(errors)-1
    ]
    return q
end

function expsmooth(xs, α)
    smoothed = copy(xs)
    for i in 2:length(xs)
        smoothed[i] = α * xs[i] + (1 - α) * smoothed[i-1]
    end
    return smoothed
end

titles_ions = ("Neutral continuity", "Ion continuity", "Ion momentum", "Neutral continuity", "Ion continuity", "Ion momentum", "Neutral continuity", "Ion continuity", "Ion momentum")
titles_ϕ = ("", "", "")
titles_pot = ["Potential"]
titles_grad = ("∇ϕ", "∇pe", "ue", "∇ϕ", "∇pe", "ue", "∇ϕ", "∇pe", "ue")
titles_norms = ("L1", "L2", "LInf")
titles_energy = ["Energy Implicit"]

function refines(num_refinements, initial, factor)
    return [
        round(Int, initial * factor^(p-1))
        for p in 1:num_refinements
    ]
end

struct OVS_Ionization <: HallThruster.IonizationModel end
struct OVS_Excitation <: HallThruster.ExcitationModel end

import HallThruster.load_reactions

function OVS_rate_coeff_iz(ϵ)
    return 1e-12 * exp(-12.12/ϵ)
end

function OVS_rate_coeff_ex(ϵ)
    return 1e-12 * exp(-8.32/ϵ)
end

function HallThruster.load_reactions(::OVS_Ionization, species)
    return [HallThruster.IonizationReaction(12.12, HallThruster.Xenon(0), HallThruster.Xenon(1), OVS_rate_coeff_iz)]
end

function HallThruster.load_reactions(::OVS_Excitation, species)
    return [HallThruster.ExcitationReaction(8.32, HallThruster.Xenon(0), OVS_rate_coeff_ex)]
end
