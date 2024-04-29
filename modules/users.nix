{ pkgs, ... }:

{
  imports = [
    ./terminal.nix
  ];

  programs.zsh.enable = true;

  users.users.booster = {
    createHome = true;
    isNormalUser = true;
    extraGroups = [ "wheel" "input" "video" "audio" "pulse" "networkmanager"
    "dialout" "wireshark" "docker"];
    shell = pkgs.zsh;
  };

  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-curses;
    enableSSHSupport = true;
  };

  # Thanks to https://discourse.nixos.org/t/best-way-to-remap-caps-lock-to-esc-with-wayland/39707/6
  services.interception-tools =
    let
      itools = pkgs.interception-tools;
      itools-caps = pkgs.interception-tools-plugins.caps2esc;
    in
    {
      enable = true;
      plugins = [ itools-caps ];
      udevmonConfig = pkgs.lib.mkDefault ''
        - JOB: "${itools}/bin/intercept -g $DEVNODE | ${itools-caps}/bin/caps2esc -m 1 | ${itools}/bin/uinput -d $DEVNODE"
          DEVICE:
            EVENTS:
              EV_KEY: [KEY_CAPSLOCK, KEY_ESC]
      '';
    };
}
