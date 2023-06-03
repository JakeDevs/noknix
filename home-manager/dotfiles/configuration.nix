{ config, pkgs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      <home-manager/nixos>
    ];
  
  boot.kernelPackages = pkgs.linuxPackages_zen;

  # Use the systemd-boot EFI boot loader. 
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.enable = true;

  # networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
   time.timeZone = "US/Eastern";

  # Video drivers
   services.xserver.videoDrivers = [ "nvidia" ];
   hardware.nvidia.open = false;
   hardware.nvidia.nvidiaSettings = true;
   hardware.opengl.enable = true;
   hardware.nvidia.modesetting.enable = true;
   hardware.opengl.driSupport32Bit = true;
   hardware.nvidia.powerManagement.enable = true;

  #Waydroid
   virtualisation = {
    waydroid.enable = true;
    lxd.enable = true;
  };
  

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = {
  #   "eurosign:e";
  #   "caps:escape" # map caps to escape.
  # };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;
   services.pipewire.enable = true;
   services.pipewire.audio.enable = true;
   services.pipewire.wireplumber.enable = true;
   services.pipewire.pulse.enable = true;

   #Login manager

    services.greetd = {
    enable = true;
    vt = 7;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
        user = "greeter";
      };
    };
  };

  #User options.
   nix.settings.experimental-features = [ "nix-command" "flakes" ];
   nix.settings.allowed-users = [ "jake" ];
   services.getty.autologinUser = "jake";
   programs.hyprland.enable = true;
   programs.hyprland.nvidiaPatches = true;
   programs.xwayland.enable = true;
   programs.firefox.enable = true;
   programs.steam.enable = true;
   programs.gamemode.enable = true;
   programs.gamescope.enable = true;
   programs.gamescope.capSysNice = true;
   programs.corectrl.enable = true;
   qt.platformTheme = "gtk";
   services.flatpak.enable = true;

   nix.settings.auto-optimise-store = true;
   xdg.portal.enable = true;
   xdg.portal.wlr.enable = true;
   xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];
   xdg.portal.xdgOpenUsePortal = true;
   security.polkit.enable = true;

   services.throttled.enable = true;
   hardware.cpu.intel.updateMicrocode = true;

   home-manager.useUserPackages = true;
   home-manager.useGlobalPkgs = true;
 
   virtualisation.podman.enable = true;
   virtualisation.podman.enableNvidia = true;
   virtualisation.podman.dockerSocket.enable = true;
   virtualisation.podman.dockerCompat = true;

   programs.thunar.enable = true;
   programs.thunar.plugins = with pkgs.xfce; [thunar-volman thunar-dropbox-plugin thunar-archive-plugin thunar-media-tags-plugin];

   services.gvfs.enable = true;

   programs.zsh.enable = true;
   users.defaultUserShell = pkgs.zsh;

   programs.npm.enable = true;

   services.wg-netmanager.enable = true;

   users.users = {
    jake = {
     isNormalUser = true;
     useDefaultShell = true;
     extraGroups = [ "wheel" "podman" ]; # Enable ‘sudo’ for the user.
     packages = with pkgs; [
       #anchor
       ];
     };
   };


  # List packages installed in system profile. To search, run:
  # $ nix search wget
   environment.systemPackages = with pkgs; [
     wget
     git
     btop
     solaar
     logitech-udev-rules
     seatd
     starship
     micro
     xdg-utils
     python3
     python311Packages.pip
     pacman
     xorg.libX11
     libGL
     libglvnd
     mesa
     catppuccin-gtk
     catppuccin-cursors
   ];

   environment.sessionVariables = { NIXOS_OZONE_WL = "1"; };
   
   nixpkgs = {
    overlays = [
     
       (self: super: {
      waybar = super.waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      });
    })

    ];
    config = {
     allowUnfree = true; 
    };
   };


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };


  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}

