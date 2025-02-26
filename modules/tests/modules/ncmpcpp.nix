(import ../lib.nix) {
  name = "ncmpcpp-test";
  nodes = {
    node1 = {self, ...}: {
   
      imports = [
	self.nixosModules.hjem-rum
      ];

      hjem.users.bob.rum = {
        programs.ncmpcpp = {
          enable = true;

          # This aims to test the ncmpcpp generator type conversion
          # Options where chose at random
          settings = {
            mpd_host = "localhost";
            mpd_port = 6600;
            mpd_crossfade_time = true;
          };

          bindings = {
            keys = [
              {
                binding = "ctrl-q";
                actions = ["stop" "quit"];
              }
              {
                binding = "q";
                actions = ["quit"];
                deferred = true;
              }
            ];
            commands = [
              {
                binding = "!sq";
                actions = ["stop" "quit"];
              }
              {
                binding = "!q";
                actions = ["quit"];
                deferred = true;
              }
            ];
          };
        };
      };
    };
  };

  testScript = ''
    # Checks if ncmpcpp config file exists in the expected place
    #node1.succeed("[ -r ~bob/.config/ncmpcpp/config]")

    # Checks if ncmpcpp runs with the config file at all
    #node1.succeed("ncmpcpp")
  '';
}
