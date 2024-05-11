import os
import subprocess

from libqtile import bar, layout, widget, extension, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy


mod = "mod4"
terminal = "alacritty"
editor = "emacsclient -c"

lock_command = "betterlockscreen --lock"


keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Switch between windows
    Key([mod], "left", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "right", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "down", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "up", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),

    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "left", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "right", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "down", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "up", lazy.layout.shuffle_up(), desc="Move window up"),

    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "left", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "right", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "down", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "up", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),

    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),

    Key([mod, "shift"], "q", lazy.window.kill(), desc="Kill focused window"),

    Key(
        [mod],
        "f",
        lazy.window.toggle_fullscreen(),
        desc="Toggle fullscreen on the focused window",
    ),

    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control", "shift"], "r", lazy.restart()),

    Key([mod, "control", "shift"], "q", lazy.shutdown(), desc="Shutdown Qtile"),

    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "t", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "d", lazy.spawn("rofi -show combi")),
    Key([mod], "l", lazy.spawn(lock_command), desc="Lock Session"),
    Key([mod], "e", lazy.spawn(editor), desc="Run Editor"),
    Key([mod], "w", lazy.spawn("firefox"), desc="Run Firefox"),

    Key([], "XF86AudioRaiseVolume", lazy.spawn("pulsemixer --change-volume +5")),
    Key([], "XF86AudioLowerVolume", lazy.spawn("pulsemixer --change-volume -5")),
    Key([], "XF86AudioMute", lazy.spawn("pulsemixer --toggle-mute")),
]


groups = [
    Group("1: Edit", spawn=editor),
    Group("2: Web"),
    Group("3: Files", spawn="thunar"),
    Group("4: Term", spawn=terminal),
    Group("5: Chat"),
    Group("6: Music"),
    Group("7: Misc"),
]


for index, group in enumerate(groups):
    num_key = index + 1

    keys.extend(
        [
            # mod1 + letter of group = switch to group
            Key(
                [mod],
                str(num_key),
                lazy.group[group.name].toscreen(),
                desc="Switch to group {}".format(group.name),
            ),

            # mod1 + shift + letter of group = move focused window to group
            Key(
                [mod, "shift"],
                str(num_key),
                lazy.window.togroup(group.name, switch_group=False),
                desc="Move focused window to group {}".format(group.name),
            ),
        ]
    )


layouts = [
    layout.MonadTall(ratio=0.66),
    layout.Max(),
]


widget_defaults = dict(
    font="Fira Code",
    fontsize=16,
    padding=5,
)


extension_defaults = widget_defaults.copy()


screens = [
    Screen(
        bottom=bar.Gap(20),
        top=bar.Gap(20),
        left=bar.Gap(20),
        right=bar.Gap(20),
        wallpaper=os.path.expanduser("~/.config/qtile/wallpaper.png"),
        wallpaper_mode="fill",
        # You can uncomment this variable if you see that on X11 floating resize/moving is laggy
        # By default we handle these events delayed to already improve performance, however your system might still be struggling
        # This variable is set to None (no cap) by default, but you can set it to 60 to indicate that you limit it to 60 events per second
        # x11_drag_polling_rate = 60,
    ),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
floats_kept_above = True
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"

# Run the start polybar script after run
@hook.subscribe.startup
def autorun_startup_complete():
    # This script needs to be placed here by the home-manager config
    # config.xdg.configFile."qtile/start_polybar.sh"
    run_polybar = os.path.expanduser("~/.config/qtile/start_polybar.sh")
    subprocess.run([run_polybar])
