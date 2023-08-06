# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "de";
    xkbVariant = "";
  };

  # Configure console keymap
  console.keyMap = "de";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.max = {
    isNormalUser = true;
    description = "Max";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      # Web Browsers
      firefox
      librewolf
      chromium
      brave

      # Email Clients
      thunderbird

      # GNOME Tools
      gnome.gnome-tweaks
      
      # Graphics
      inkscape
      gimp      
     
      # Security Tools
      keepassxc
      protonvpn-gui
      burpsuite
      john

      # Media Player
      vlc

      # Office Tools
      libreoffice-fresh
      masterpdfeditor
      flowtime
      calibre

      # Note Taking App
      joplin-desktop

      # Torrent
      qbittorrent

      # LaTeX
      texlive.combined.scheme-full
      texmaker

      # Development
      # vscode extensions can be installed within this file
      # by defining the packages within the square brackets
      (vscode-with-extensions.override {
        vscodeExtensions = with vscode-extensions; [
          ms-vscode.cpptools
        ];
      })

      # FTP File Manager
      filezilla
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Text Processing and Editing
    vim

    # Networking
    wget
    
    # Application Management
    appimagekit		# Used for packaging AppImages yourself
    appimage-run	# Used to execute AppImages
    
    # Development
    git

    # C/C++ Development
    gcc			  # GNU-Compiler for C and C++
    cmake		  # Build-System
    gnumake		# Make Tool
    gdb			  # GNU-Debugger

    # Python Development
    python3		          # Python 3 Runtime Environment
    python3Packages.pip # Packet Management Tool

    # R Development
    # The R package wasn't used because rWrapper has better support for installing r packages on nixos
    # The packages to installed are defined within the square brackets
    (rWrapper.override { 
      packages = with rPackages; [ tidyverse ggplot2 palmerpenguins rmarkdown markdown here skimr janitor ]; 
    })

    (rstudioWrapper.override {
      packages = with rPackages; [ tidyverse ggplot2 palmerpenguins rmarkdown markdown here skimr janitor ];
    })    

    # Java Development
    jdk17		# Open Java Runtime Environment
    maven		# Build-Tool
  ];

  # Install fonts
  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
  ];
  
  # Exclude GNOME applications from default installation
  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
    gnome-connections
  ]) ++ (with pkgs.gnome; [
    baobab	          # disk usage analyzer
    cheese	          # webcam tool
    epiphany	        # web browser
    file-roller       # archive managera
    geary	            # email client
    gnome-characters
    gnome-contacts
    gnome-font-viewer
    gnome-logs
    gnome-maps
    gnome-music
    gnome-weather
    seahorse          # password manager
    simple-scan       # document scanner
    totem	            # video player
    yelp              # help viewer
  ]);

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

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

  # Turn Anti-Aliasing of font on when program uses java
  environment.variables = {
    _JAVA_OPTIONS = "-Dawt.useSystemAAFontSettings=on";
  };

  # Remove NixOS documentation
  documentation.nixos.enable = false;

  # Enables Installing of flatpaks
  services.flatpak.enable = true;

}