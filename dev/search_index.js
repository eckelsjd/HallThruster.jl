var documenterSearchIndex = {"docs":
[{"location":"","page":"Home","title":"Home","text":"CurrentModule = HallThruster\nDocTestSetup = quote\n    using HallThruster\nend","category":"page"},{"location":"#HallThruster.jl","page":"Home","title":"HallThruster.jl","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"A 1D fluid Hall thruster code written in Julia. This will be filled in as the code is developed further.","category":"page"},{"location":"internals/","page":"Internals","title":"Internals","text":"CurrentModule = HallThruster","category":"page"},{"location":"internals/","page":"Internals","title":"Internals","text":"","category":"page"},{"location":"internals/","page":"Internals","title":"Internals","text":"Modules = [HallThruster]","category":"page"},{"location":"internals/#HallThruster.Air","page":"Internals","title":"HallThruster.Air","text":"Air::Gas\n\nEarth air at standard temperature and pressure\n\n\n\n\n\n","category":"constant"},{"location":"internals/#HallThruster.Argon","page":"Internals","title":"HallThruster.Argon","text":"Argon::Gas\n\nArgon gas\n\n\n\n\n\n","category":"constant"},{"location":"internals/#HallThruster.Electron","page":"Internals","title":"HallThruster.Electron","text":"Electron::Species\n\nElectron\n\n\n\n\n\n","category":"constant"},{"location":"internals/#HallThruster.Krypton","page":"Internals","title":"HallThruster.Krypton","text":"Krypton::Gas\n\nKrypton gas\n\n\n\n\n\n","category":"constant"},{"location":"internals/#HallThruster.NA","page":"Internals","title":"HallThruster.NA","text":"NA\n\nNumber of atoms in a kg-mol (6.02214076e26 / kmol)\n\n\n\n\n\n","category":"constant"},{"location":"internals/#HallThruster.R0","page":"Internals","title":"HallThruster.R0","text":"R0\n\nUniversal gas constant (8314.46261815324 J / kmol K)\n\n\n\n\n\n","category":"constant"},{"location":"internals/#HallThruster.Xenon","page":"Internals","title":"HallThruster.Xenon","text":"Xenon::Gas\n\nXenon gas\n\n\n\n\n\n","category":"constant"},{"location":"internals/#HallThruster.e","page":"Internals","title":"HallThruster.e","text":"e\n\nElectron mass (1.602176634e-19 kg)\n\n\n\n\n\n","category":"constant"},{"location":"internals/#HallThruster.kB","page":"Internals","title":"HallThruster.kB","text":"kB\n\nBoltzmann constant (1.380649e-23 J/K)\n\n\n\n\n\n","category":"constant"},{"location":"internals/#HallThruster.ContinuityOnly","page":"Internals","title":"HallThruster.ContinuityOnly","text":"ContinuityOnly\n\nA ConservationLawSystem in which only continuity (mass conservation) is solved, while velocity and temperature are held constant. Must specify a constant velocity (in m/s) and temperature (in K).\n\njulia> equation = ContinuityOnly(u = 300, T = 500)\nContinuityOnly(300.0, 500.0)\n\n\n\n\n\n","category":"type"},{"location":"internals/#HallThruster.EulerEquations","page":"Internals","title":"HallThruster.EulerEquations","text":"EulerEquations\n\nA ConservationLawSystem for the inviscid Navier-Stokes equations, better known as the Euler equations\n\njulia> equation = EulerEquations()\nEulerEquations()\n\n\n\n\n\n","category":"type"},{"location":"internals/#HallThruster.Gas","page":"Internals","title":"HallThruster.Gas","text":"Gas\n\nA chemical element in the gaseous state. Container for element properties used in fluid computations.\n\nFields\n\nname::String        Full name of gas (i.e. Xenon)\n\nshort_name::String  Short name/symbol (i.e. Xe for Xenon)\n\nγ::Float64          Specific heat ratio / adiabatic index\n\nM::Float64          Molar mass (grams/mol) or atomic mass units\n\nm::Float64          Mass of atom in kg\n\ncp::Float64         Specific heat at constant pressure in J / kg / K\n\ncv::Float64         Specific heat at constant volume in J / kg / K\n\nR::Float64          Gas constant in J / kg / K\n\n\n\n\n\n","category":"type"},{"location":"internals/#HallThruster.Gas-Tuple{Any, Any}","page":"Internals","title":"HallThruster.Gas","text":"Gas(name::String, short_name::String; γ::Float64, M::Float64)\n\nInstantiate a new Gas, providing a name, short name, the adiabatic index, and the molar mass. Other gas properties, including gas constant, specific heats at constant pressure/volume, and mass of atom/molecule in kg will are then computed.\n\njulia> Gas(\"Xenon\", \"Xe\", γ = 5/3, M = 83.798)\nXenon\n\n\n\n\n\n","category":"method"},{"location":"internals/#HallThruster.IsothermalEuler","page":"Internals","title":"HallThruster.IsothermalEuler","text":"IsothermalEuler\n\nA ConservationLawSystem in which only continuity and inviscid momentum are solved, while temperature is held constant. Must specify a constant temperature (in K).\n\njulia> equation = IsothermalEuler(T = 500)\nIsothermalEuler(500.0)\n\n\n\n\n\n","category":"type"},{"location":"internals/#HallThruster.Species","page":"Internals","title":"HallThruster.Species","text":"Species\n\nRepresents a gas with a specific charge state. In a plasma, different ionization states of the same gas may coexist, so we need to be able to differentiate between these.\n\njulia> Species(Xenon, 0)\nXe\n\njulia> Species(Xenon, 1)\nXe+\n\njulia> Species(Xenon, 3)\nXe3+\n\n\n\n\n\n","category":"type"}]
}
