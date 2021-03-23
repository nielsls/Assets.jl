# Assets

Install: `] add Assets`

Assets allows you to easily retrieve the path of an asset (txt-file, image, etc...) bundled with your Julia package.

```
absolute_path_to_image = asset"my_image.gif"
```
The above works both for ordinary Julia sessions - and for Julia apps compiled and bundled using PackageCompiler.


## When using PackageCompiler

When compiling apps using [PackageCompiler](https://github.com/JuliaLang/PackageCompiler.jl), the following code should be appended to your build script (i.e. right after `create_app(...)`):
```
using Assets
using MyPkgWithAssets
copy_assets(MyPkgWithAssets, app_folder)
```
where `app_folder` is the path of the folder containing `bin/` created by PackageCompiler. 

This will copy the contents of `MyPkgWithAssets/assets/` to `assets/` located next to `bin/` in the app bundle.


## Note

Your package must be organized as follows for Assets to find your assets.

```
package/
│
└───src/
│   │   code1
│   │   code2
│   │   ...
│   
└───assets/
    │   asset1
    │   asset2
    │   ...

```
