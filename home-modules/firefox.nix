{ pkgs, inputs, ... }:
{
  imports = [ inputs.arkenfox.hmModules.arkenfox ];
  programs.firefox = {
    enable = true;
    arkenfox = {
      enable = true;
      version = "140.0";
    };
    # languagePacks = [ "en-GB" "es-ES" ];
    # policies = {
    #   AutofillAddressEnabled = false;
    #   AutofillCreditCardEnabled = false;
    #   DisableSetDesktopBackground = true;
    #   DisableFirefoxAccounts = true;
    #   DisableFirefoxScreenshots = true;
    #   DisableForgetButton = true;
    #   DisableMasterPasswordCreation = true;
    #   DisablePasswordReveal = true;
    #   DisplayMenuBar = "never";
    #   FirefoxHome.Search = false;
    #   EnableTrackingProtection = {
    #     Value = true;
    #     Category = "strict";
    #     BaselineExceptions = true;
    #   };
    #   PasswordManagerEnabled = false;
    #   PictureInPictureEnabled = false;
    #   SanitizeOnShutdown = {
    #     Cookies = false;
    #     SiteSettings = false;        
    #   };
    # };
    profiles.default = {
      arkenfox = {
        enable = true;
        "0100" = {
          enable = true;
          "0102"."browser.startup.page".value = 3;
          "0103"."browser.startup.homepage".value = "https://glance.sole-alkaid.ts.net";
          
        };
        "0200".enable = true;
        "0300" = {
          enable = true;
          "0350"."browser.tabs.crashReporting.sendReport".value = true;
        };
        "0400".enable = true;
        "0600".enable = true;
        "0700".enable = true;
        "0800" = {
          enable = true;
          "0830"."browser.search.separatePrivateDefault".value = false;
        };
        "0900".enable = true;
        "1000".enable = true;
        "1200".enable = true;
        "1600".enable = true;
        "1700".enable = false;
        "2000".enable = true;
        "2400".enable = true;
        "2600".enable = true;
        "2700".enable = true;
        "2800" = {
          enable = true;
          "2811"."privacy.clearOnShutdown_v2.historyFormDataAndDownloads".value = false;
          "2812"."privacy.clearOnShutdown_v2.browsingHistoryAndDownloads".value = false;
        };
        "4000".enable = true;
        "4500".enable = true;
        "5500".enable = true;
        "6000".enable = true;
      };
    #   search = {
    #     force = true;
    #     default = "ddg";
    #     engines = {
    #       nix-packages = {
    #         name = "Nix Packages";
    #         urls = [{ template = "https://search.nixos.org/packages?query={searchTerms}"; }];
    #       };
    #       nixos-wiki = {
    #         name = "NixOS Wiki";
    #         urls = [{ template = "https://wiki.nixos.org/w/index.php?search={searchTerms}"; }];
    #       };
    #     };
    #   };
    #   bookmarks.force = true;
    #   bookmarks.settings = [
    #     { name = "Redlib"; url = "https://redlib.sole-alkaid.ts.net"; }
    #     { name = "NixOS Discourse"; url = "https://discourse.nixos.org"; }
    #     { name = "NixOS Search"; url = "https://search.nixos.org"; }
    #   ];     
    };
  };
}
