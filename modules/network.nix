{ config, pkgs, ... }:

{
  networking.networkmanager.enable = true;
  networking.firewall = {
    # Port for wireguard
    allowedUDPPorts = [ 51820 ];
    # Strict reverse path checking breaks wireguard through networkmanager
    checkReversePath = "loose";
  };
}
