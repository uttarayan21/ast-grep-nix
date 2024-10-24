{
  description = "Run ast-grep on a repo";
  inputs = {};
  outputs = {self}: {
    mkLib = pkgs: rec {
      scanWithOptions = src: {config ? "${src}/sgconfig.toml"}:
        pkgs.runCommand "ast-grep.scan" {
          nativeBuildInputs = [pkgs.ast-grep];
        } ''
          ast-grep scan -c ${config}
        '';
      scan = src: scanWithOptions src {};
    };
  };
}
