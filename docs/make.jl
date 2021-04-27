using Documenter, DisjointCliqueCover

makedocs(sitename = "DisjointCliqueCover.jl",
         pages = [
             "Overview" => "index.md",
             "Getting started" => "getting_started.md",
             "Library" => "library.md"
         ]
         )

deploydocs(
    repo = "github.com/giubuig/DisjointCliqueCover.jl.git",
    devbranch = "main"
)
