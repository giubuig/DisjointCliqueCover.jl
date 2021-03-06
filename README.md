# DisjointCliqueCover.jl

[![Build Status](https://travis-ci.com/giubuig/DisjointCliqueCover.jl.svg?branch=main)](https://travis-ci.com/giubuig/DisjointCliqueCover.jl)
[![][docs-latest-img]][docs-latest-url]
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.4723747.svg)](https://doi.org/10.5281/zenodo.4723747)

## Description

This package [DisjointCliqueCover](https://github.com/giubuig/DisjointCliqueCover.jl), written in the [Julia](https://julialang.org) language, implements a method to estimate a minimal _edge-disjoint edge clique cover (EECC)_ of a graph, according to the heuristic presented in Burgio et al. [[1](#references)]. A minimal edge clique cover is a minimal set of cliques able to cover the entire set of edges in the graph. In a EECC, the cliques are required to be all edge-disjoint, i.e., they can have no more than one vertex in common.

A graph can admit multiple minimal edge clique covers and finding one of them is known to be a NP-complete problem. Therefore, approximate heuristics are needed to estimate it in large graphs.

The notion of EECC is introduced in [[1](#references)] as a basis to define the Microscopic Epidemic Clique Equations (MECLE) model. This is a discrete-time markovian model describing complex contagion processes on higher-order networks, represented as hypergraphs and, specifically, as simplicial complexes. The model builds upon the cliques in the underlying graph of a considered higher-order network. As shown in [[1](#references)], in order to account for the higher-order dynamical correlations among the states of the nodes in those cliques, the latter are required to be edje-disjoint. This leads to the search for the minimal EECC of the underlying graph, hence to the respective heuristic whose source code is here provided.


## References

1. Giulio Burgio, Alex Arenas, Sergio Gómez and Joan T. Matamalas: Network clique cover approximation to analyze complex contagions through group interactions, _Comms. Phys._ **4**, 111 (2021) ([doi](https://doi.org/10.1038/s42005-021-00618-z))


## Authors

- [Giulio Burgio](https://scholar.google.es/citations?user=jnYkpVoAAAAJ) (Universitat Rovira i Virgili, Tarragona, Spain)

- [Alex Arenas](http://deim.urv.cat/alexandre.arenas) (Universitat Rovira i Virgili, Tarragona, Spain)

- [Sergio Gómez](http://deim.urv.cat/~sergio.gomez) (Universitat Rovira i Virgili, Tarragona, Spain)

- [Joan T. Matamalas](https://www.linkedin.com/in/jtmatamalas) (Harvard Medical School & Brigham and Women's Hospital, Boston, USA)


## Documentation

The full documentation of [DisjointCliqueCover.jl](https://github.com/giubuig/DisjointCliqueCover.jl) can be found [here][docs-latest-url]

[docs-latest-url]: https://giubuig.github.io/DisjointCliqueCover.jl/v0.1/
[docs-latest-img]: https://img.shields.io/badge/docs-latest-blue.svg
