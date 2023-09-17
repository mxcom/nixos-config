{ config, pkgs, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.max = {
    isNormalUser = true;
    description = "Max";
    extraGroups = [ "networkmanager" "wheel" "dialout" "sudo"  ];
    packages = with pkgs; [
      # Web Browsers
      firefox
      librewolf
      chromium
      brave

      # Email Client
      thunderbird
      electron-mail

      # GTK
      materia-theme
      flat-remix-icon-theme

      # Application Management
      appimagekit # For packaging AppImages yourself
      appimage-run # For executing AppImages

      # Graphics
      gimp
      inkscape
      drawio
      imagemagick

      # Security Tools
      keepassxc
      burpsuite
      john

      # Multimedia
      pavucontrol
      vlc

      # Office Tools
      libreoffice-fresh
      hunspell # for libreoffice spell checking
      hunspellDicts.en_US
      hunspellDicts.de_DE
      masterpdfeditor
      calibre
      joplin-desktop
      mate.atril

      # LaTeX
      texlive.combined.scheme-full
      texmaker
      lyx
      texmacs

      # Development
      # GTK/Gnome Development
      gnome-builder
    
      # vscode
      # vscode extensions are installed within the square brackets
      (vscode-with-extensions.override {
        vscode = vscodium;
        vscodeExtensions = with vscode-extensions; [
          ms-vscode.cpptools
          vscode-extensions.ms-python.python
          vscode-extensions.yzhang.markdown-all-in-one
        ];
      })

      # C++
      jetbrains.clion
      
      # R
      # R packages are installed within the square brackets
      (rWrapper.override {
        packages = with rPackages; [
          tidyverse
          ggplot2
          rmarkdown
        ];
      })
      
      # R Studio
      # R packages are installed within the square brackets
      (rstudioWrapper.override {
        packages = with rPackages; [
          tidyverse
          ggplot2
          rmarkdown
        ];
      })

      # JavaScript
      nodejs

      # Python
      jetbrains.pycharm-community

      # MIPS
      mars-mips

      # MISC
      openfortivpn
      protonvpn-gui
      qbittorrent
      filezilla
      anki-bin
      rpi-imager # raspberry pi imager
      threema-desktop
      pidgin  # irc chat client

      # games
      prismlauncher-unwrapped # foss minecraft launcher
    ];
  };
}
