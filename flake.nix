{
  description = "DFA AWS Step Function development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
      in
      {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            terraform
            terraform-ls
            awscli2
            jq
            nodejs
          ];

          shellHook = ''
            export AWS_CONFIG_FILE="$PWD/.aws/config"
            export AWS_SHARED_CREDENTIALS_FILE="$PWD/.aws/credentials"

            echo "DFA AWS Step Function development environment"
            echo "  - Terraform: $(terraform version -json | jq -r '.terraform_version')"
            echo "  - aws: $(aws --version 2>&1 | cut -d ' ' -f1) (AWS config: $AWS_CONFIG_FILE)"
            echo "  - node: $(node --version 2>&1 | head -1)"
            echo "  - jq: $(jq --version 2>&1 | head -1)"
          '';
        };
      }
    );
}
