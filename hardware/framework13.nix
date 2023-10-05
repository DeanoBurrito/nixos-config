{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  networking.hostName = "wintermute";

  boot.initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "nvme" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" "acpi_call" ];
  boot.extraModulePackages = [ config.boot.kernelPackages.acpi_call ];

  boot.blacklistedKernelModules = [ "hid-sensor-hub" ];
  boot.kernelParams = [
    "mem_sleep_default=deep"
    "i915.enable_psr=1"
  ];

  services.fprintd.enable = true;
  services.fstrim.enable = true;
  services.fwupd.enable = true;

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/6d77718b-5bb5-469e-9165-237774642c72";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/A430-B0CF";
      fsType = "vfat";
    };

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.acpilight.enable = true;
  hardware.sensor.iio.enable = true;
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  hardware.opengl.extraPackages = with pkgs; [
    intel-media-driver
    vaapiIntel
    vaapiVdpau
    libvdpau-va-gl
  ];

  environment.etc = {
    issue.text = ''
    Welcome to

    ░▒█░░▒█░░▀░░█▀▀▄░▀█▀░█▀▀░█▀▀▄░▒█▀▄▀█░█░▒█░▀█▀░█▀▀
    ░▒█▒█▒█░░█▀░█░▒█░░█░░█▀▀░█▄▄▀░▒█▒█▒█░█░▒█░░█░░█▀▀
    ░▒▀▄▀▄▀░▀▀▀░▀░░▀░░▀░░▀▀▀░▀░▀▀░▒█░░▒█░░▀▀▀░░▀░░▀▀▀
    '';
  };
}
