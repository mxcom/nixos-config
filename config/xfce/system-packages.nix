{ config, pkgs, ... }:

{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # System Utilities
    vim
    wget
    dig
    zip
    unzip
    usbutils

    # Xfce
    xfce.xfce4-whiskermenu-plugin
    xfce.xfce4-pulseaudio-plugin
    xfce.xfce4-timer-plugin
    xfce.xfce4-time-out-plugin
    xfce.xfburn # media writer

    # Development
    git

    # GNOME Builder
    meson
    ninja
    pkg-config
    webkitgtk
    gettext
    glib
    gtk3
    gtk4
    appstream-glib

    # C/C++ Development
    gcc # GNU-Compiler for C and C++
    cmake # Build-System
    gnumake # Make Tool
    gdb # GNU-Debugger

    # Python Development
    python3 # Python 3 Runtime Environment
    python3Packages.pip # Python package manager tool

    # Java Development
    jdk17 # Open Java Runtime Environment
    maven # Build-Tool

    # Security
    clamav

    # MISC
    putty
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    solaar
  ];

  # VirtualBox  
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "max" ];
}
