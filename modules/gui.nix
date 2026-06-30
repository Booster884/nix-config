{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    firefox
    thunderbird
    obsidian
    zathura
    spotify
    discord
    telegram-desktop
    wireshark
    eduvpn-client
    zotero
  ];

  programs.wireshark.enable = true;

  fonts.packages = with pkgs; [
    liberation_ttf
    noto-fonts-cjk-sans

    jetbrains-mono
    nerd-fonts.jetbrains-mono
    iosevka-bin
    (iosevka-bin.override { variant = "Slab"; })
  ];
}
