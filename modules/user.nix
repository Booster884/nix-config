{ pkgs, ... }:

{
  programs.zsh.enable = true;

  users.users.sebastian = {
    createHome = true;
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ];
    shell = pkgs.zsh;

    packages = with pkgs; [
      git lazygit
      jujutsu lazyjj
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

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICkUtQ9ohBa4P4/lHKD1qAYdtqcWBScvWuan6EgNAHp3 sebastian@neodymium"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKZC7MS2eNnzKjivmJTtAJzagIeijJMYusEaj2QF0ltS sebastian@flerovium"
    ];
  };

  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-curses;
    enableSSHSupport = true;
  };
}
