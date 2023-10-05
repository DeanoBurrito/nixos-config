{ pkgs, ... }:

{
  programs.hyprland.enable = true;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = with pkgs; [
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk
  ];

  security.pam.services.swaylock.text = "auth include login";

  environment.systemPackages = with pkgs; [
    swaylock-effects
    swayidle
    dunst
    swaybg
    wl-clipboard
    # TODO: gsettings + a default theme
    grim
    slurp
    hyprpicker #TODO: remove this, we dont really need it
    eww-wayland
    xdg-utils
    wayvnc
    mate.mate-polkit #TODO: fix polkit not autostarting
    ];

  environment.sessionVariables = {
    NIXOS_XDG_OPEN_USE_PORTAL = "1";
    MOZ_ENABLE_WAYLAND = "1";
  };

  systemd = {
    user.services.polkit-mate-authentication-agent-1 = {
      enable = true;
      description = "Mate polkit agent";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after= [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
	ExecStart = "${pkgs.mate.mate-polkit}/libexec/polkit-mate-authentication-agent-1";
	Restart = "on-failure";
	RestartSec = 1;
	TimeoutStopSec = 1;
      };
    };
  };
}
