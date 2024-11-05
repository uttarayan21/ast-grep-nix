{
  description = "Run ast-grep on a repo";
  inputs = {};
  outputs = {self}: {
    mkLib = pkgs: rec {
      scanWithOptions = src: {
        config ? "${src}/sgconfig.yml",
        color ? "ansi",
        format ? null,
        # json ? false,
      }: let
        vColor = pkgs.lib.asserts.assertOneOf "color" color ["auto" "always" "never" "ansi"];
        vFormat = pkgs.lib.asserts.assertOneOf "format" format ["github" null];
        # vJson = pkgs.lib.asserts.assertOneOf "json" json [true false "pretty" "stream" "compact"];
      in
        pkgs.runCommand "ast-grep.scan" {
          inherit src;
          nativeBuildInputs = [pkgs.ast-grep];
        } ''
          sg scan -c ${config} ${src} \
            ${pkgs.lib.optionalString vColor "--color ${color}"} \
            ${pkgs.lib.optionalString (vFormat && !(isNull format)) "--format ${format}"} \
            &> $out
        '';
      scan = src: scanWithOptions src {};
    };
  };
}
