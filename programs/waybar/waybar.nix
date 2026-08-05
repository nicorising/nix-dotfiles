let
  iconSize = "12";
in
{
  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        position = "top";
        layer = "top";

        modules-left = [
          "hyprland/workspaces"
        ];

        modules-center = [
          "custom/spotify"
        ];

        modules-right = [
          "bluetooth"
          "network"
          "pulseaudio"
          "backlight"
          "battery"
          "clock"
          "group/tray-drawer"
          "group/power-menu"
        ];

        "hyprland/workspaces" = {
          format = "{icon}";
          format-icons = {
            default = "";
            empty = "";
          };

          persistent-workspaces = {
            "*" = 10;
          };
        };

        "custom/spotify" = {
          exec = "playerctl --player=spotify metadata --format '{{ artist }} - {{ title }}'";
          exec-if = "pgrep spotify && [ \"$(playerctl -p spotify status 2>/dev/null)\" = \"Playing\" ]";
          interval = 1;

          format = ''<span font="${iconSize}" color="#83a598">󰝚</span> {}'';
          max-length = 50;
          escape = true;

          on-click = "playerctl --player=spotify play-pause";
          on-click-right = "playerctl --player=spotify next";
          on-click-middle = "playerctl --player=spotify previous";
        };

        bluetooth = {
          format = "<span font='${iconSize}' color='#83a598'>󰂯</span>";
          format-connected = "<span font='${iconSize}' color='#83a598'>󰂱</span>";
          format-disabled = "<span font='${iconSize}' color='#928374'>󰂲</span>";
          tooltip-format = "{controller_alias}\t{controller_address}";
          tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{device_enumerate}";
          tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
          on-click = "bluetooth-menu";
        };

        network = {
          interval = 1;
          format-wifi = "{icon}";
          format-disconnected = "󰤮";
          format-icons = [
            "󰤟"
            "󰤢"
            "󰤥"
            "󰤨"
          ];
          tooltip-format = "{ifname}: {ipaddr}/{cidr}\nSignal: {signalStrength}%";
          on-click = "nm-connection-editor";
        };

        pulseaudio = {
          format = ''<span font="${iconSize}" color="#b8bb26">{icon}</span> {volume}%'';
          format-muted = ''<span font="${iconSize}" color="#b8bb26">󰸈</span> {volume}%'';
          format-icons = {
            default = [
              "󰕿"
              "󰖀"
              "󰖀"
              "󰖀"
              "󰖀"
              "󰖀"
              "󰕾"
              "󰕾"
              "󰕾"
              "󰕾"
            ];
          };

          on-click = "pamixer -t";
          on-click-right = "pavucontrol";
          scroll-step = 1;
        };

        backlight = {
          format = ''<span font="${iconSize}" color="#fabd2f">{icon}</span> {percent}%'';
          format-icons = [
            "󰛩"
            "󱩎"
            "󱩏"
            "󱩐"
            "󱩑"
            "󱩒"
            "󱩓"
            "󱩔"
            "󱩕"
            "󱩖"
            "󰛨"
          ];

          on-scroll-up = "brightnessctl set 1%+";
          on-scroll-down = "brightnessctl set 1%-";
          on-click = "hyprctl hyprsunset identity";

          tooltip = false;
        };

        battery = {
          states = {
            warning = 20;
            critical = 10;
          };
          interval = 1;
          format = ''<span font="${iconSize}" color="#8ec07c">{icon}</span> {capacity}%'';
          format-charging = ''<span font="${iconSize}" color="#8ec07c">{icon}</span> {capacity}%'';
          format-warning = ''<span font="${iconSize}" color="#fabd2f">{icon}</span> {capacity}%'';
          format-critical = ''<span font="${iconSize}" color="#fb4934">{icon}</span> {capacity}%'';
          format-icons = [
            "󰁺"
            "󰁻"
            "󰁼"
            "󰁽"
            "󰁾"
            "󰁿"
            "󰂀"
            "󰂁"
            "󰂂"
            "󰁹"
          ];
        };

        clock = {
          interval = 1;
          format = ''<span font="${iconSize}" color="#fe8019">󱑍</span> {:%H:%M}'';
          format-alt = ''<span font="${iconSize}" color="#fe8019">󱑍</span> {:%m-%d-%Y %H:%M:%S}'';
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          calendar = {
            mode = "month";
            mode-mon-col = 3;
            weeks-pos = "right";
            on-scroll = 1;
            format = {
              months = "<span color='#fabd2f'><b>{}</b></span>";
              days = "<span color='#ebdbb2'><b>{}</b></span>";
              weeks = "<span color='#8ec07c'><b>W{}</b></span>";
              weekdays = "<span color='#b8bb26'><b>{}</b></span>";
              today = "<span color='#fb4934'><b><u>{}</u></b></span>";
            };
          };
        };

        "group/tray-drawer" = {
          orientation = "horizontal";
          drawer = {
            transition-left-to-right = false;
            transition-duration = 500;
            children-class = "tray-child";
          };
          modules = [
            "custom/tray-icon"
            "tray"
          ];
        };

        "custom/tray-icon" = {
          format = "󰀻";
          tooltip = false;
        };

        "tray" = {
          icon-size = 14;
          spacing = 10;
        };

        "group/power-menu" = {
          "orientation" = "horizontal";

          "drawer" = {
            "transition-left-to-right" = false;
            "transition-duration" = 500;
            "children-class" = "power-menu-child";
          };

          "modules" = [
            "custom/power"
            "custom/lock"
            "custom/reboot"
          ];
        };

        "custom/power" = {
          "format" = "";
          "on-click" = "shutdown now";
          "tooltip" = false;
        };

        "custom/lock" = {
          "format" = "󰍁";
          "on-click" = "hyprlock";
          "tooltip" = false;
        };

        "custom/reboot" = {
          "format" = "󰜉";
          "on-click" = "reboot";
          "tooltip" = false;
        };
      };
    };

    style = ./waybar.css;
  };
}
