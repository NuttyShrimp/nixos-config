{ config, pkgs, ... }:

{
  fonts.fontDir.enable = true;
  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      liberation_ttf
      fira-code-symbols
      freefont_ttf
      montserrat
      source-han-sans-japanese
      source-han-serif-japanese
      symbola
      font-awesome
      material-design-icons
      (nerdfonts.override {
        fonts = [
          "FiraCode"
          "Iosevka"
          "JetBrainsMono"
        ];
      })
      berkeley-mono
    ];
    fontconfig = {
      enable = true;
    };
  };
}
