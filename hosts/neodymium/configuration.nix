{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/network.nix
    ../../modules/sound.nix
    ../../modules/sway.nix
    ../../modules/users.nix
  ];

  # Nix settings
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader = {
    efi.canTouchEfiVariables = true;
    grub = {
      enable = true;
      devices = [ "nodev" ];
      efiSupport = true;
      useOSProber = true;
    };
  };

  networking.hostName = "neodymium";

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";
  time.hardwareClockInLocalTime = false;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_AU.UTF-8";

  # Enable OpenGL
  hardware.graphics.enable = true;

  # services.xserver.videoDrivers = ["nvidia"];
  # hardware.nvidia = {
  #   package = config.boot.kernelPackages.nvidiaPackages.stable;
  #   modesetting.enable = true;
  #   powerManagement.enable = false;
  #   powerManagement.finegrained = false;
  #   open = false;
  #   nvidiaSettings = true;
  # };

  services.syncthing = {
    enable = true;
    user = "booster";
    configDir = "/home/booster/.config/syncthing";
  };

  users.users.booster = {
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICkUtQ9ohBa4P4/lHKD1qAYdtqcWBScvWuan6EgNAHp3 booster@neodymium"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBbIyIzAbJL3vXX4zJ9rQhlbUjNftrgnduyJorxgS6Ku booster@iridium"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP9c4G5iRz8GXa2l1RavoTG9qp33gDIotlW0IkuxUSdR booster@phone"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKZC7MS2eNnzKjivmJTtAJzagIeijJMYusEaj2QF0ltS booster@flerovium"
    ];
  };

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
      LogLevel = "VERBOSE";
    };
    # Port is only open to WireGuard by making wg1 trusted below.
    openFirewall = false;
  };
  networking.firewall = {
    # Conenctions through this wireguard interface are trusted
    trustedInterfaces = [ "wg1" ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}

