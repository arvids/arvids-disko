{
  disko.devices = {
    disk = {
      vdb = {
        type = "disk";
        device = "/dev/disk/by-diskseq/1";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              priority = 1;
              name = "ESP";
              start = "1M";
              end = "128MiB";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "defaults"];
              };
            };
            root = {
              size = "100%";
              content = {
                type = "btrfs";
                extraArgs = [ "-f" ]; # Override existing partition
                subvolumes = {
                  "/root"= {
                    mountOptions = [ "compress=zstd" "noatime" ];
                    mountpoint = "/";
                  };
                  "/swap" = {
                    mountpoint = "/swap";
                  };
                  "/home" = {
                    mountOptions = [ "compress=zstd" ];
                    mountpoint = "/home";
                  };
                  "/nix" = {
                    mountOptions = [ "compress=zstd" "noatime" ];
                    mountpoint = "/nix";
                  };
                  "/persist" = {
                    mountOptions = [ "compress=zstd" "noatime" ];
                    mountpoint = "/persist";
                  };
                  "/log" = {
                    mountOptions = [ "compress=zstd" "noatime" ];
                    mountpoint = "/var/log"
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
