{
  programs.librewolf = {
    enable = true;
    languagePacks = [ "en-GB" "es-ES" ];
    policies = {
      AutofillAddressEnabled = false;
      AutofillCreditCardEnabled = false;
      DisableSetDesktopBackground = true;
      DisableFirefoxAccounts = true;
      DisableFirefoxScreenshots = true;
      DisableForgetButton = true;
      DisableMasterPasswordCreation = true;
      DisablePasswordReveal = true;
      DisplayMenuBar = "never";
      EnableTrackingProtection = {
        Value = true;
        Category = "strict";
        BaselineExceptions = true;
      };
      FirefoxHome = {
        Search = false;
      };
      PasswordManagerEnabled = false;
      PictureInPictureEnabled = false;
      SanitizeOnShutdown = {
        Cookies = false;
        SiteSettings = false;        
      };
    };
    profiles.default = {
      search = {
        force = true;
        default = "ddg";
        engines = {
          nix-packages = {
            name = "Nix Packages";
            urls = [{ template = "https://search.nixos.org/packages?query={searchTerms}"; }];
          };
          nixos-wiki = {
            name = "NixOS Wiki";
            urls = [{ template = "https://wiki.nixos.org/w/index.php?search={searchTerms}"; }];
          };
        };
      };
      bookmarks.force = true;
      bookmarks.settings = [
        { name = "NixOS Discourse"; url = "https://discourse.nixos.org"; }
      ];     
      settings = {
        "browser.startup.page" = 3;
        "browser.startup.homepage" = "https://glance.sole-alkaid.ts.net";
        "middlemouse.paste" = false;
        "general.autoScroll" = false;
        "view_source.wrap_long_lines" = true;
      };
    };
    settings = {
      "privacy.clearOnShutdown.cookies" = false;
      "privacy.clearOnShutdown.history" = false;
      "privacy.resistFingerprinting.letterboxing" = false;
      "dom.event.clipboardevents.enabled" = false;
      "webgl.disabled" = true;
      "identity.fxaccounts.enabled" = false;
      "network.cookie.lifetimePolicy" = 0;
      "keyword.enabled" = false;
      "browser.urlbar.suggest.searches" = false;
      "browser.fixup.alternate.enabled" = false;
      # "media.autoplay.blocking_policy" = 2;
      "gfx.webrender.all" = true;
    };
  };
}
