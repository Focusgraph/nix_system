{
 services.glance = {
   enable = true;
   settings = {
     server = {
       port = 5050;
       host = "0.0.0.0";
       proxied = true;
     };
     branding.custom-footer = ''<p>Powered by <a href="https://github.com/glanceapp/glance">Glance</a></p>'';
     theme = {
       background-color = "0 0 16";
       primary-color = "43 59 81";
       positive-color = "61 66 44";
       negative-color = "6 96 59";
       contrast-multiplier = 1.3;
       disable-picker = true;
     };
     pages = [
       {
         name = "Home";
         show-mobile-header = true;
         columns = [
           {
             size = "small";
             widgets = [
               { type = "calendar"; }
               { type = "server-stats"; servers = [{ type = "local"; name = "Licher"; }]; }
               {
                 type = "monitor";
                 cache = "1m";
                 title = "Services";
                 timeout = "1m";
                 sites = [
                   {
                     title = "Jellyfin";
                     url = "https://jellyfin.sole-alkaid.ts.net";
                     check-url = "http://localhost:8096";
                     icon = "di:jellyfin";
                   }
                   {
                     title = "Actual Budget";
                     url = "https://actual.sole-alkaid.ts.net";
                     check-url = "http://localhost:3000";
                     icon = "di:actual-budget";
                   }
                   {
                     title = "Redlib";
                     url = "https://redlib.sole-alkaid.ts.net";
                     check-url = "http://localhost:8080";
                     icon = "di:redlib";
                   }
                   {
                     title = "Invidious";
                     url = "https://invidious.sole-alkaid.ts.net";
                     check-url = "http://localhost:2560";
                     icon = "di:invidious";
                   }
                 ];
               }
             ];
           }
           {
             size = "full";
             widgets = [
               {
                 type = "search";
                 search-engine = "duckduckgo";
                 bangs = [
                   {
                     title = "Youtube";
                     shortcut = "!yt";
                     url = "https://www.youtube.com/results?search_query={QUERY}";
                   }
                   {
                     title = "Reddit";
                     shortcut = "!rd";
                     url = "https://redlib.sole-alkaid.ts.net/search?q={QUERY}";
                   }
                 ];
               }
               { type = "to-do"; }
             ];
           }
         ];
       }
     ];
   };
 };
}
