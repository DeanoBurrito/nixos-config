{ pkgs, ... }:

let
  customtexlive = (pkgs.texlive.combine {
    inherit (pkgs.texlive) scheme-basic geometry enumitem titlesec pgf parskip bytefield etoolbox listings latexmk;
  });

  # x86_64 toolchain is fine as is, but riscv insist on being difficult and wont allow building of shared objects
  # in the default toolchain.
  cross_rv64 = import <nixpkgs> { crossSystem.config = "riscv64-linux"; };
  cross_x86_64 = import <nixpkgs> { crossSystem.config = "x86_64-elf"; };
in
{
  imports = [
    (fetchTarball "https://github.com/nix-community/nixos-vscode-server/tarball/master")
    ];
  
  programs.zsh.enable = true;
  programs.steam.enable = true;
  programs.steam.remotePlay.openFirewall = true;
  
  services.vscode-server.enable = true;

  users.users.dean = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      # Environment
      ntfs3g
      customtexlive
      libnotify

      # Programming utils
      gnumake
      gdb
      gcc13
      clang
      lld
      clang-tools_16
      cross_rv64.buildPackages.gcc
      cross_x86_64.buildPackages.gcc

      # CLI tools
      jq
      bat
      btop
      ripgrep
      tokei
      xorriso

      # Graphical tools
      vlc
      qemu
      firefox
      kitty
      gparted
      discord
      zathura
      vscode
      speedcrunch
      gnome.nautilus #TODO: a more lightweight file explorer?
      element-desktop
    ];
  };
}
