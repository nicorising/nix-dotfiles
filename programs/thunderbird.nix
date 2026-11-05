{
  accounts.email = {
    maildirBasePath = "mail";

    accounts = {
      Personal = {
        primary = true;
        address = "nico@nicoris.ing";
        userName = "nico@nicoris.ing";
        realName = "Nico Rising";

        imap = {
          host = "mail.nicoris.ing";
          port = 993;
          tls.enable = true;
        };

        smtp = {
          host = "mail.nicoris.ing";
          port = 465;
          tls.enable = true;
        };

        thunderbird = {
          enable = true;
          profiles = [ "default" ];

          settings =
            id:
            let
              folder = name: "imap://nico%40nicoris.ing@mail.nicoris.ing/${name}";
            in
            {
              "mail.identity.id_${id}.fcc_folder" = folder "Sent";
              "mail.identity.id_${id}.draft_folder" = folder "Drafts";
              "mail.identity.id_${id}.archive_folder" = folder "Archive";
              "mail.server.server_${id}.spamActionTargetAccount" = "imap://nico%40nicoris.ing@mail.nicoris.ing";
              "mail.server.server_${id}.spamActionTargetFolder" = folder "Junk";

              "mail.identity.id_${id}.reply_on_top" = 1;
              "mail.identity.id_${id}.sig_bottom" = false;
            };
        };
      };
    };
  };

  programs.thunderbird = {
    enable = true;

    profiles.default = {
      isDefault = true;

      settings = {
        "general.useragent.override" = "";
        "network.cookie.cookieBehavior" = 2;

        "security.tls.version.min" = 3;
        "security.tls.version.max" = 4;

        "mail.biff.show_alert" = true;
        "mail.biff.use_system_alert" = true;

        "browser.cache.disk.enable" = true;
        "browser.cache.memory.capacity" = 256000;
      };
    };
  };
}
