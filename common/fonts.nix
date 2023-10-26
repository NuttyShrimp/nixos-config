{ config, pkgs, ... }:

{
  fonts.fontDir.enable = true;
  fonts = {
    fonts = with pkgs; [
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
      (nerdfonts.override {
        fonts = [
          "FiraCode"
          "Iosevka"
	  "JetBrainsMono"
        ];
      })
    ];
    fontconfig = {
      enable = true;
    };
  };
}
