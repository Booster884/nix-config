{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    lazygit
    delta

    eza
    ranger
    ncdu
    btop
    wget
    tealdeer
    p7zip

    fzf
    ripgrep

    neovim
    tmux

    python3
    pyright
  ];
}
