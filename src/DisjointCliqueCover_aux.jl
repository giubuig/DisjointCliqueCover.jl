"""
    limited_maximal_cliques(G::SimpleGraph, m₀::Int64)

Calculate the maximal cliques of a graph `G` up to order `m₀`. Any clique
of order `m`>`m₀` is decomposed into its `Base.binomial(m, m₀)` sub-cliques of order `m₀`.

# Arguments

- `G::SimpleGraph`: a simple graph of the LightGraphs.SimpleGraph type
- `m₀::Int64`: an integer representing the maximum order of the cliques to consider

# Return

A vector containing the maximal cliques up to order `m₀`
"""
function limited_maximal_cliques(G::SimpleGraph, m₀::Int64)::Vector{Vector{Int64}}
    C = maximal_cliques(G)
    indxs = zeros(Int64, 0)

    len = length(C)
    for c in 1:len
        n = length(C[c])
        if n > m₀
            push!(indxs, c)
            append!(C, sort!.(collect(combinations(C[c], m₀))))
        else
            sort!(C[c])
        end
    end

    C = C[setdiff([1:length(C);], indxs)]
    unique!(C)
    sort!(C, by = x -> (-length(x), x[1], length(x) > 1 ? x[2] : 0))

    return C
end


function compute_scores!(G::SimpleGraph, C::Vector{Vector{Int64}},
                         EC::Vector{Vector{Int64}}, ord::Vector{Int64},
                         r::Vector{Float64}, indexes::Vector{Int64})
    len = length(C)
    for c in 1:len
        order = length(C[c])
        C[c] = sort!(C[c])
        ord[c] = order
        if order > 2
            size = binomial(order, 2)
            for i in 1:order
                for j in (i+1):order
                    f = 0
                    n = 1
                    while n <= len
                        if issubset([C[c][i],C[c][j]], C[n]) && n != c
                            f = 1
                            n += len
                        else
                            n += 1
                        end
                    end
                    if f == 1
                        r[c] += 1/size
                    end
                end
            end
        end
        # Including in the EECC those cliques of score zero
        if r[c] == 0
            push!(EC, C[c])
            push!(indexes, c)
        end
    end
end


"""
    get_EECC(G::SimpleGraph, m₀::Int64)

Calculate the edge-disjoint edge clique cover (EECC) of a graph `G` considering
cliques of order up to `m₀`, according to the heuristic proposed in the paper.

# Arguments

- `G::SimpleGraph`: a simple graph of the LightGraphs.SimpleGraph type
- `m₀::Int64`: an integer representing the maximum order of the cliques to consider

# Return

A vector containing the EECC
"""
function get_EECC(G::SimpleGraph, m₀::Int64)::Vector{Vector{Int64}}
    G_ = copy(G)
    C = limited_maximal_cliques(G_::SimpleGraph, m₀::Int64)   # set of the maximal cliques
    ord = zeros(Int64, length(C))   # vector of cliques' order
    r = zeros(Float64, length(C))   # vector of cliques' score
    EC = Vector{Vector{Int64}}()    # (abbreviation for EECC)

    # Computing the vector r of scores of the cliques, and including (removing) those with score zero in the EECC (from the set C)
    indexes_score0 = zeros(Int64, 0)
    compute_scores!(G_, C, EC, ord, r, indexes_score0)

    # Removing those cliques with score zero from C, r and G_
    len = length(C)
    C = C[setdiff([1:len;], indexes_score0)]
    ord = ord[setdiff([1:len;], indexes_score0)]
    r = r[setdiff([1:len;], indexes_score0)]
    for c in 1:length(EC)
        order = length(EC[c])
        for i in 1:order
            for j in (i+1):order
                rem_edge!(G_, EC[c][i], EC[c][j])
            end
        end
    end

    # Repeating the following until no edges are left to be covered (in which case ne(G_) = 0)
    while ne(G_) > 0
        # Finding (one of) the largest clique(s) with the minimum score, and including it in the EECC
        min_r = minimum(r)
        min_r_set = findall(x -> x == min_r, r)
        max_ord = maximum(ord[min_r_set])
        c_ = sample(findall(x -> x == max_ord, ord[min_r_set]))   # note: this is the only potentially non-deterministic step in the heuristic
        c = min_r_set[c_]
        cli = C[c]   # the selected clique to include in the EECC
        push!(EC, cli)
        # Removing cli from G_
        for i in 1:max_ord
            for j in (i+1):max_ord
                rem_edge!(G_, cli[i], cli[j])
            end
        end

        C = limited_maximal_cliques(G_, m₀)
        C = C[length.(C) .> 1]   # removing isolated nodes
        ord = zeros(Int64, length(C))
        r = zeros(Float64, length(C))

        # Updating the scores' vector r
        indexes_score0 = zeros(Int64, 0)
        compute_scores!(G_, C, EC, ord, r, indexes_score0)

        # Removing those cliques with score zero from C, r and G_
        len = length(C)
        C = C[setdiff([1:len;], indexes_score0)]
        ord = ord[setdiff([1:len;], indexes_score0)]
        r = r[setdiff([1:len;], indexes_score0)]
        for c in 1:length(EC)
            order = length(EC[c])
            for i in 1:order
                for j in (i+1):order
                    rem_edge!(G_, EC[c][i], EC[c][j])
                end
            end
        end

    end

    sort!(EC, by=x->(-length(x), x[1], x[2]))

    return EC
end
