using Test
using LightGraphs
using Combinatorics
using StatsBase
using Random
using DisjointCliqueCover

# Set random seed
Random.seed!(666)

# Test Graph
begin   # Constructing the graph in Fig.1 in the paper
    G = SimpleGraph(14)
    add_edge!(G, 1, 2)
    add_edge!(G, 1, 14)
    add_edge!(G, 2, 4)
    add_edge!(G, 2, 13)
    add_edge!(G, 2, 14)
    add_edge!(G, 3, 4)
    add_edge!(G, 3, 5)
    add_edge!(G, 4, 5)
    add_edge!(G, 4, 13)
    add_edge!(G, 4, 14)
    add_edge!(G, 6, 7)
    add_edge!(G, 6, 13)
    add_edge!(G, 7, 8)
    add_edge!(G, 7, 13)
    add_edge!(G, 8, 9)
    add_edge!(G, 8, 13)
    add_edge!(G, 9, 10)
    add_edge!(G, 9, 11)
    add_edge!(G, 9, 13)
    add_edge!(G, 10, 11)
    add_edge!(G, 11, 12)
    add_edge!(G, 12, 13)
    add_edge!(G, 13, 14)
    G
end


# Sets of maximal cliques in G
C_2 = [[1, 2], [1, 14], [2, 4], [2, 13], [2, 14], [3, 4], [3, 5], [4, 5], [4, 13],
       [4, 14], [6, 7], [6, 13], [7, 8], [7, 13], [8, 9], [8, 13], [9, 10], [9, 11],
       [9, 13], [10, 11], [11, 12], [12, 13], [13, 14]]

C_3 = [[1, 2, 14], [2, 4, 13], [2, 4, 14], [2, 13, 14], [3, 4, 5], [4, 13, 14],
       [6, 7, 13], [7, 8, 13], [8, 9, 13], [9, 10, 11], [11, 12], [12, 13]]

C_4 = [[2, 4, 13, 14], [1, 2, 14], [3, 4, 5], [6, 7, 13], [7, 8, 13], [8, 9, 13],
       [9, 10, 11], [11, 12], [12, 13]]

# Cliques extraction
C_2_test = EECC.limited_maximal_cliques(G, 2)
C_3_test = EECC.limited_maximal_cliques(G, 3)
C_4_test = EECC.limited_maximal_cliques(G, 4)

# Test cliques extraction
@testset "Cliques_Extraction" begin
    @test Set(C_2_test) == Set(C_2)
    @test Set(C_3_test) == Set(C_3)
    @test Set(C_4_test) == Set(C_4)
    @test Set(C_4_test) == Set(sort.(maximal_cliques(G)))
end


# Vectors of scores of the maximal cliques in G
r_2 = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
       0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]

r_3 = [1/3, 1.0, 1.0, 1.0, 0.0, 1.0, 1/3, 2/3, 1/3, 0.0, 0.0, 0.0]

r_4 = [1/6, 1/3, 0.0, 1/3, 2/3, 1/3, 0.0, 0.0, 0.0]

# Score computation
EC_2 = Vector{Vector{Int64}}()
ord_2 = zeros(Int64, length(C_2))
r_2_test = zeros(Float64, length(C_2))
indexes_2 = zeros(Int64, 0)
EECC.compute_scores!(G, C_2, EC_2, ord_2, r_2_test, indexes_2)

EC_3 = Vector{Vector{Int64}}()
ord_3 = zeros(Int64, length(C_3))
r_3_test = zeros(Float64, length(C_3))
indexes_3 = zeros(Int64, 0)
EECC.compute_scores!(G, C_3, EC_3, ord_3, r_3_test, indexes_3)

EC_4 = Vector{Vector{Int64}}()
ord_4 = zeros(Int64, length(C_4))
r_4_test = zeros(Float64, length(C_4))
indexes_4 = zeros(Int64, 0)
EECC.compute_scores!(G, C_4, EC_4, ord_4, r_4_test, indexes_4)

# Test score computation
@testset "Score_Computation" begin
    @test r_2_test ≈ r_2  atol=1e-5
    @test r_3_test ≈ r_3  atol=1e-5
    @test r_4_test ≈ r_4  atol=1e-5
end


# EECCs of G
EECC_2 = [[1, 2], [1, 14], [2, 4], [2, 13], [2, 14], [3, 4], [3, 5], [4, 5], [4, 13],
          [4, 14], [6, 7], [6, 13], [7, 8], [7, 13], [8, 9], [8, 13], [9, 10], [9, 11],
          [9, 13], [10, 11], [11, 12], [12, 13], [13, 14]]

EECC_3 = [[1, 2, 14], [3, 4, 5], [4, 13, 14], [6, 7, 13], [8, 9, 13], [9, 10, 11],
          [2, 4], [2, 13], [7, 8], [11, 12], [12, 13]]

EECC_4 = [[2, 4, 13, 14], [3, 4, 5], [6, 7, 13], [8, 9, 13], [9, 10, 11],
          [1, 2], [1, 14], [7, 8], [11, 12], [12, 13]]

# EECC calculation
EECC_2_test = get_EECC(G, 2)
EECC_3_test = get_EECC(G, 3)
EECC_4_test = get_EECC(G, 4)

# Test EECC calculation
@testset "EECC_Calculation" begin
    @test Set(EECC_2_test) == Set(EECC_2)
    @test Set(EECC_3_test) == Set(EECC_3)
    @test Set(EECC_4_test) == Set(EECC_4)
end
