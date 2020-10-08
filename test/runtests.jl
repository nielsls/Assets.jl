using Test
using Assets

@testset "testall" begin

    pkgpath = joinpath("foo", "bar", "MyPkg")
    filepath = joinpath(pkgpath, "src", "code.jl")
    @test Assets.getpkgfolder(filepath) == pkgpath

    @test Assets.is_standard_julia_session()

    pkgpath = joinpath("foo", "bar", "MyPkg")
    @test Assets.assetpath(pkgpath) == joinpath(pkgpath, "assets")

end
