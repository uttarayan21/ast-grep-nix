# ast-grep

Utility library to run ast-grep as a nix target

Usage: 

```nix
{}: let 
    pkgs = import nixpkgs { system = "x86_64-linux" };
    sgLib = ast-grep.mkLib pkgs;
in {
    custom = sgLib.scanWithOptions ./. { format = "github"; color = "always" };
    default = sgLib.scan ./.;
}
```
