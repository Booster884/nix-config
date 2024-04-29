{ pkgs, ... }:

{
  imports = [
    ./gui.nix
  ];

  programs.sway = {
    enable = true;
    xwayland.enable = true;
    extraPackages = with pkgs; [
        swaylock
        swayidle
        rofi
        wl-clipboard
        grim
        slurp
        brightnessctl

        whitesur-cursors

        alacritty
        st
    ];
  };
  programs.waybar.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
    ];
    wlr.enable = true;
  };

  programs.dconf.profiles.user.databases = [
    {
      lockAll = true;
      settings = {
        "org/gnome/desktop/interface" = {
          color-scheme = "prefer-dark";
          gtk-theme = "Adwaita-dark";
          cursor-theme = "WhiteSur";
        };
      };
    }
  ];
}
