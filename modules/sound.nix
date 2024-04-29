{ pkgs, ... }:

{
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    wireplumber.extraConfig.bluetoothEnhancements = {
      "monitor.bluez.properties" = {
          "bluez5.enable-sbc-xq" = true;
          "bluez5.enable-msbc" = true;
          "bluez5.enable-hw-volume" = true;
          "bluez5.roles" = [ "hsp_hs" "hsp_ag" "hfp_hf" "hfp_ag" "a2dp_source" "a2dp_sink" ];
      };
    };
  };

  environment.systemPackages = with pkgs; [
    # No longer provided automatically, but still useful for pactl.
    pulseaudio
    playerctl
    pavucontrol
    bluetuith
  ];

  hardware.bluetooth = {
    enable = true;
    settings = {
      General.MultiProfile = "multiple";
    };
  };
  services.blueman.enable = true;
}
