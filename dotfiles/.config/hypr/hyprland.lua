hl.monitor({
  output = "HDMI-A-2",
  mode = "1920x1080@60",
  position = "0x0",
  scale = 1,
})

hl.monitor({
  output = "",
  mode = "preferred",
  position = "auto",
  scale = 1
})

hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("CLUTTER_BACKEND", "wayland")
-- hl.env("SDL_VIDEODRIVER", "wayland")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
-- hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("QT_QPA_PLATFORMTHEME", "gtk3")
hl.env("GTK_THEME", "Material-Black-Cherry-BE-Custom")

hl.on("hyprland.start", function() 
  hl.exec_cmd("dbus-update-activation-environment --systemd XDG_SESSION_TYPE XDG_CURRENT_DESKTOP XDG_SESSION_DESKTOP")
  hl.exec_cmd("hyprpaper")
  hl.exec_cmd("waybar")
  hl.exec_cmd("hypridle")
  hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
  hl.exec_cmd("wl-clip-persist --clipboard regular")
  hl.exec_cmd("playerctld daemon")

  hl.exec_cmd("qbittorrent")
  hl.exec_cmd("Telegram -startintray")
  hl.exec_cmd("firefox")

  hl.exec_cmd("hyprlock")
end)

local qbittorrent_handler

qbittorrent_handler = hl.on("window.open", function(window)
  if window.class == "org.qbittorrent.qBittorrent" then
    hl.dispatch(hl.dsp.window.close({ window = window }))
    qbittorrent_handler:remove()
  end
end)

hl.config({
  general = {
    gaps_out = 8,
    gaps_in = 4,
    border_size = 2,

    col = {
      active_border = "rgb(8c2d2a)",
      inactive_border = "rgba(191319eb)"
    }
  },

  decoration = {
    rounding = 3,
    dim_special = 0.4,
    dim_around = 0.4,

    shadow = {
      range = 5,
      render_power = 2
    },

    blur = {
      enabled = false
    }
  },

  dwindle = {
    preserve_split = true
  },

  input = {
    kb_layout = "us,ru,ua",
    kb_options = "grp:shifts_toggle",

    touchpad = {
      natural_scroll = true
    }
  },

  cursor = {
    hotspot_padding = 0
  },

  ecosystem = {
    no_update_news = true,
    no_donation_nag = true
  }
})

hl.device({
  name = "logitech-g102-lightsync-gaming-mouse",
  sensitivity = -0.8
})

hl.curve("easeOutQuint", { type = "bezier", points = { {0.23, 1}, {0.32, 1} } })
hl.curve("linear", { type = "bezier", points = { {0, 0}, {1, 1} } })
hl.curve("almostLinear", { type = "bezier", points = { {0.5, 0.5}, {0.75, 1} } })
hl.curve("quick", { type = "bezier", points = { {0.15, 0}, {0.1, 1} } })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 2.5, bezier = "quick" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 2.5, bezier = "quick", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 2.5, bezier = "quick", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 3.5, bezier = "quick" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 3.5, bezier = "quick" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 7, bezier = "quick" })

local mainMod = "SUPER"

hl.bind(mainMod .. " + R", hl.dsp.exec_cmd("pkill -x rofi || rofi -show drun"))
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd("alacritty"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("thunar"))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exit())
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("loginctl lock-session"))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("firefox"))
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd("pkill -x rmpc || alacritty -e rmpc"))

hl.bind(mainMod .. " + S", hl.dsp.window.swap({ next = true }))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.swap({ prev = true }))

hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

for index, key in ipairs({ 1, 2, 3, 4, 5, 6, 7, 8, 9, 0, "MINUS", "EQUAL" }) do
  hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = index }))
  hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = index }))
end

hl.bind(mainMod .. " + GRAVE", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + GRAVE", hl.dsp.window.move({ workspace = "special:magic" }))

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind("Print", hl.dsp.exec_cmd("$XDG_CONFIG_HOME/hypr/scripts/screenshot.sh"))
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 2%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl -p \"$(playerctl -l | head -n1)\" previous"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl -p \"$(playerctl -l | head -n1)\" next"), { locked = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set 2%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 2%-"), { locked = true, repeating = true })

hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0 })
hl.workspace_rule({ workspace = "f[1]", gaps_out = 0 })

hl.window_rule({
  match = { float = false, workspace = "w[tv1]" },
  border_size = 0,
  rounding = 0,
  no_shadow = true
})

hl.window_rule({
  match = { float = false, workspace = "f[1]" },
  border_size = 0,
  rounding = 0,
  no_shadow = true
})

hl.window_rule({
  match = { class = [[^org\.pulseaudio\.pavucontrol$]] },
  float = true,
  size = { 614, 500 },
  move = { "monitor_w - (window_w + 6)", 36 },
  animation = "slide top",
  dim_around = true
})

hl.window_rule({
  match = { class = [[^qimgv$]] },
  suppress_event = "maximize"
})

hl.window_rule({
  match = { class = [[org\.qbittorrent\.qBittorrent]], title = [[negative:^qBittorrent.*$]] },
  float = true
})

hl.window_rule({
  match = { class = [[^firefox$]], title = [[^Library$]] },
  float = true
})

hl.window_rule({
  match = { title = [[^(File Operation Progress|Rename ".*"|Choose .*|Extract( archive)?|Compress|Save .*|Open .*)$]] },
  float = true
})

hl.layer_rule({
  match = { namespace = "rofi" },
  animation = "slide top",
  dim_around = true
})

hl.layer_rule({
  match = { namespace = "notifications" },
  animation = "slide right"
})

