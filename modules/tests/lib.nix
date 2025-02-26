# Helper function to import the testing framework with special args.
#
# This function imports runTest from nixpkgs:/nixos/lib/testing-lib/runTest
# to run our test derivation (the argument of this function),
# passing some args in the process, notably self, allowing us to
# use inputs and outputs from our flake.
#
# Usage: (import ./location-of-lib.nix) {test-script-here}
test: {
  pkgs,
  self,
}: let
  inherit (self) lib;
  nixos-lib = import (pkgs.path + "/nixos/lib") {};
in
  (nixos-lib.runTest {
    hostPkgs = pkgs;
    defaults = {
      documentation.enable = lib.mkDefault false;
      users.groups.bob = {};
      users.users.bob = {
        isNormalUser = true;
        home = "/home/bob";
        password = "";
      };
    };
    node.specialArgs = {inherit self;};
    imports = [test];
  })
  .config
  .result
