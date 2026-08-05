{
  wayland.windowManager.hyprland = {
    enable = true;
    configType = "lua";

    settings = {
      config = {
        general = {
          border_size = 1;
          gaps_in = 4;
          gaps_out = 8;
          resize_on_border = true;

          col = {
            active_border = "rgb(83a598)";
            inactive_border = "rgb(3c3836)";
          };
        };

        dwindle = {
          force_split = 2; # Always open windows to the right
        };

        decoration = {
          rounding = 4;
          inactive_opacity = 0.9;
        };

        input = {
          kb_layout = "us";
          kb_model = "pc104";
          repeat_rate = 35;
          repeat_delay = 200;

          follow_mouse = 2;
        };

        gestures = {
          workspace_swipe_invert = false;
          workspace_swipe_forever = true; # Allow swiping multiple workspaces at once
          workspace_swipe_min_speed_to_force = 1;
          workspace_swipe_cancel_ratio = 0.02;
        };

        ecosystem = {
          no_update_news = true;
          no_donation_nag = true;
        };

        xwayland.force_zero_scaling = true;

        misc = {
          disable_hyprland_logo = true;
          focus_on_activate = true;
        };
      };

      window_rule = [
        {
          match.class = "^floating$";
          float = true;
          size = [
            "monitor_w * 0.8"
            "monitor_h * 0.8"
          ];
        }
        {
          match.class = "^com\\.flipperdevices\\.$";
          border_size = 0;
          no_blur = true;
          no_shadow = true;
        }
      ];

      monitor = [
        {
          output = "eDP-1";
          mode = "preferred";
          position = "auto";
          scale = 1.666;
        }
        {
          output = "";
          mode = "preferred";
          position = "auto";
          scale = 1;
        }
      ];

      gesture = [
        {
          fingers = 3;
          direction = "horizontal";
          action = "workspace";
        }
      ];
    };

    extraConfig = builtins.readFile ./hyprland.lua;
  };
}
