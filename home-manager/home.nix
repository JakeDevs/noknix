{ config, pkgs, inputs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "jake";
  home.homeDirectory = "/home/jake";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.

  #Default apps
  xdg.mime.enable = true;
  xdg.mimeApps.enable = true;
  xdg.mimeApps.defaultApplications = {
    "inode/directory" = [ "pcmanfm.desktop" ];
    "x-scheme-handler/http" = [ "firefox.desktop" ];
    "x-scheme-handler/https" = [ "firefox.desktop" ];
    "x-scheme-handler/about" = "firefox.desktop";
    "x-scheme-handler/unknown" = "firefox.desktop";
  };

  #User options
  xsession.enable = true;
  xsession.windowManager.command = "…";
  programs.mangohud.enable = true;
  programs.firefox.enable = true;
  qt.enable = true;

  services.network-manager-applet.enable = true;

  #Text Editor
  programs.neovim.enable = true;
  programs.neovim.defaultEditor = true;
  programs.neovim.withPython3 = true;
  programs.neovim.coc.enable = true;

  home.packages = with pkgs; [
    alacritty
    dunst
    libnotify
    swaybg
    wallutils
    waybar
    rofi-wayland
    source-code-pro
    webcord-vencord
    xplr
    pcmanfm
    pavucontrol
    material-design-icons
    unzip
    gnutar
    xz
    bzip2
    xorg.xeyes
    glib
    gsettings-desktop-schemas
    easyeffects
    tidal-hifi
    lutris
    scdoc
    wl-clipboard
    vscode-fhs
    gnumake42
    hyprland-protocols
    hyprpaper
    hyprpicker
    imv
    appimage-run
    pods
    podman-desktop
    prismlauncher
    nix-prefetch-github
    gnome.gnome-tweaks
    libadwaita
    gnome.adwaita-icon-theme
    gsettings-desktop-schemas
    patool
    qbittorrent
    qdirstat
    neofetch
    nitch
    revolt-desktop
    gparted
    polkit_gnome
    xorg.xhost
    grim
    slurp
    winetricks
    protontricks
    emacs-gtk
    flameshot
    blender
    zsh
    protonvpn-gui
    protonvpn-cli
    gnome.zenity
    obs-studio
    desktop-file-utils
    line-awesome
    font-awesome
    iosevka-bin
    jetbrains-mono
    font-manager
    nodejs_20
    unrar
    wine-staging
    protonup-qt
    obsidian
    godot_4
    pixelorama
    firefox
    nixfmt
    mold
    clang
    nim
    mangohud
    goverlay
    libreoffice-fresh
    eww-wayland
    pkg
    pkg-config
    sqlite
    openssl
    bottom
    #anchor		
  ];

  nixpkgs = {
    overlays = [

      (self: super: {
        waybar = super.waybar.overrideAttrs (oldAttrs: {
          mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
        });
      })

    ];
  };

  gtk = {
    enable = true;

    theme = {
      name = "palenight";
      package = pkgs.palenight-theme;
    };

    gtk3.extraConfig = { Settings = "gtk-application-prefer-dark-theme=1"; };
  };

  home.pointerCursor = let
    getFrom = url: hash: name: {
      gtk.enable = true;
      x11.enable = true;
      name = name;
      size = 24;
      package = pkgs.runCommand "moveUp" { } ''
        mkdir -p $out/share/icons
        ln -s ${
          pkgs.fetchzip {
            url = url;
            hash = hash;
          }
        } $out/share/icons/${name}
      '';
    };
  in getFrom
  "https://github.com/ful1e5/Google_Cursor/releases/download/v2.0.0/GoogleDot-Blue.tar.gz"
  "sha256-PmJeGShQLIC7ceRwQvSbphqz19fKptksZeHKi9QSL5Y=" "GoogleDot-Blue";

  home.file = {

    ".config/hypr".source = ../home-manager/dotfiles/hypr;

    ".config/alacritty".source = ../home-manager/dotfiles/alacritty;

    ".config/cava".source = ../home-manager/dotfiles/cava;

    ".config/dunst".source = ../home-manager/dotfiles/dunst;

    # ".config/waybar".source = ./home-manager/dotfiles/waybar;

    "/home/jake/.zshrc".source = ../home-manager/dotfiles/.zshrc;

  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/jake/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
