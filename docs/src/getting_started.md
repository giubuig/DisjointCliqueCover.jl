# Getting Started

## Contents

```@contents
  Pages = ["getting_started.md"]
  Depth = 3
```


## Installation and usage

Installation:
```@example gettingstarted
] add DisjointCliqueCover
```

Usage:
```@example gettingstarted
using DisjointCliqueCover 
```


## Input data

We need first an undirected network of the `SimpleGraph` type as provided by package `LightGraphs`. For example, let us create the following small network:

```@raw html
<img src="../figs/eecc.png" alt="eecc.png" width="450"/>
```

Using `LightGraphs` functions:

```@example gettingstarted
using LightGraphs

N = 14
edges_list = [(1, 2), (1, 14), (2, 4), (2, 13), (2, 14), (3, 4), (3, 5), (4, 5), (4, 13),
              (4, 14), (6, 7), (6, 13), (7, 8), (7, 13), (8, 9), (8, 13), (9, 10), (9, 11),
              (9, 13), (10, 11), (11, 12), (12, 13), (13, 14)]

G = SimpleGraph(N)
for e in edges_list
  add_edge!(G, e[1], e[2])
end
nothing  # hide
```


## Edge-disjoint edge clique cover (EECC)

EECC requires to decide the maximum order of the cliques to consider:
```@example gettingstarted
m₀ = 4
nothing  # hide
```

To estimate a minimal EECC, just call the `get_EECC` function:
```@example gettingstarted
using Random  # hide
Random.seed!(666)  # hide
eecc = get_EECC(G, m₀)
nothing  # hide
```

The result is a list of the cliques that form the EECC, where each clique is indicated by the list of nodes it contains:
```@example gettingstarted
for c in eecc
  println(c)
end
```

A graph can admit multiple minimal EECC, thus different executions may lead to different estimations. For example, for the same network but with maximum order `m₀ = 3` we may get:
```@example gettingstarted
m₀ = 3
Random.seed!(666)  # hide
eecc = get_EECC(G, m₀)
for c in eecc  # hide
  println(c)  # hide
end  # hide
nothing  # hide
```

but also
```@example gettingstarted
m₀ = 3
Random.seed!(669)  # hide
eecc = get_EECC(G, m₀)
for c in eecc  # hide
  println(c)  # hide
end  # hide
nothing  # hide
```

