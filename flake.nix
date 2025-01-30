{
  description = "Testing out flakes for development environment";
  
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-tmux.url = "github:otaleghani/flake-tmux";
  };

  outputs = { self, nixpkgs, flake-tmux }@inputs:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
    # flake = import flake-tmux { inherit default; };
  in
  {
    packages.${system}.default = pkgs.mkShell {
      # packages = [ pkgs.tmux ];
      inputsFrom = [ inputs.flake-tmux.devShells.${system}.default ];
      
    };
  };
}
