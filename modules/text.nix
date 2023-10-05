{ pkgs, ... }:

{
  fonts = {
    fonts = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji

      (nerdfonts.override { fonts = [ "FiraMono" ]; })
    ];

    fontconfig = {
      enable = true;
      defaultFonts.monospace = [ "FiraMono Nerd Font Mono" ];
      defaultFonts.serif = [ "Noto Serif" ];
      defaultFonts.sansSerif = [ "Noto Sans" ];
    };
  };

  i18n = {
    defaultLocale = "en_GB.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_AU.UTF-8";
      LC_IDENTIFICATION = "en_AU.UTF-8";
      LC_MEASUREMENT = "en_AU.UTF-8";
      LC_MONETARY = "en_AU.UTF-8";
      LC_NAME = "en_AU.UTF-8";
      LC_NUMERIC = "en_AU.UTF-8";
      LC_PAPER = "en_AU.UTF-8";
      LC_TELEPHONE = "en_AU.UTF-8";
      LC_TIME = "en_AU.UTF-8";
    };
  };
}
