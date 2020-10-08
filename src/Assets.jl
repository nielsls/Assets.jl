module Assets

export 
    @asset_str,
    copy_assets
    
macro asset_str(relpath)
    dir_path = string(__source__.file)
    parsed_relpath = esc(Meta.parse("\"$(escape_string(relpath))\""))
    return quote
        joinpath(assetpath(getpkgfolder($dir_path)), $parsed_relpath)        
    end
end

"""
Returns the full path to the project's assets.

If called from a regular Julia session it will just return
the supplied argument augmented with "/assets/"

However, if called from a session compiled using PackageCompiler
it will return the path to the assets subfolder in the packaged 
app. 
"""
function assetpath(pkgfolder::AbstractString)
    pkgfolder = normpath(pkgfolder)
    if is_standard_julia_session()
        return joinpath(pkgfolder, "assets")
    else 
        modulename = splitpath(pkgfolder)[end]
        return normpath(joinpath(Sys.BINDIR, "..", "assets", modulename))
    end
end

function getpkgfolder(path)
    folders = splitpath(path)
    while folders[end] != "src"
        pop!(folders)
    end
    pop!(folders)
    return joinpath(folders...)
end

"""
Returns true if called from a standard Julia session.
False if called from an app created using PackageCompiler.
"""
function is_standard_julia_session()
    julia_folder = splitpath(Sys.BINDIR)[end-1]
    return match(r"Julia.\d+\.\d+\.\d+", julia_folder) !== nothing
end

"""
Used in the build step of a new app created using PackageCompiler.
Copies all assets from pkg to the new app.
"""
function copy_assets(src_module::Module, appfolder)
    app_assetpath = joinpath(appfolder, "assets")
    mkpath(app_assetpath)
    dst = joinpath(pkgdir(src_module), "assets")
    src = joinpath(app_assetpath, string(src_module))
    cp(dst, src)
end

end
