"""
Module that contains the functions required to extract the
edge-disjoint edge clique cover (EECC) of a graph
"""
module DisjointCliqueCover

using LightGraphs, Combinatorics, StatsBase

export get_EECC

# Load source from files
include("DisjointCliqueCover_aux.jl")

end # module
