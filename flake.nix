# {
#   inputs = {
#     nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
#   };
#   outputs = { self, nixpkgs }:
#     let
#       # define system once
#       system = "x86_64-linux";
#       # use it here, and bind platform-specific packages to `pkgs`
#       pkgs = nixpkgs.legacyPackages.${system};
#     in
#     {
#       # we can use `${system}` here!
#       packages.${system}.default = derivation {
#         name = "simple";
#         # with `with`, we can just do `bash`
#         builder = with pkgs; "${bash}/bin/bash";
#         args = [ "-c" "echo foo > $out" ];
#         src = ./.;
#         system = system;
#       };
#     };
# }

{
  description = "Testing out flakes for development environment";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in
  {
    devShells.${system}.default =
      pkgs.mkShell {
        buildInputs = [
          pkgs.neovim
          pkgs.tmux
        ];

        shellHook = ''
          echo "hello mom"
        '';
      };
  };
}
