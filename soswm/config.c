#include "config.h"
#include "soswm.h"

unsigned int gap_pixels = 8;
float default_win_ratio = 1.f;

KeyBind keybinds[] = {
    /* Window manipulation */
    {XK_j, Mod4Mask, window_roll_l},
    {XK_k, Mod4Mask, window_roll_r},
    {XK_q, Mod4Mask, window_pop},
    {XK_1, Mod4Mask, window_swap, INT_ARG(1)},
    {XK_2, Mod4Mask, window_swap, INT_ARG(2)},
    {XK_3, Mod4Mask, window_swap, INT_ARG(3)},
    {XK_4, Mod4Mask, window_swap, INT_ARG(4)},
    {XK_5, Mod4Mask, window_swap, INT_ARG(5)},
    {XK_6, Mod4Mask, window_swap, INT_ARG(6)},
    {XK_7, Mod4Mask, window_swap, INT_ARG(7)},
    {XK_8, Mod4Mask, window_swap, INT_ARG(8)},
    {XK_9, Mod4Mask, window_swap, INT_ARG(9)},
    {XK_n, Mod4Mask | ControlMask, window_move, INT_ARG(0)},
    {XK_1, Mod4Mask | ControlMask, window_move, INT_ARG(1)},
    {XK_2, Mod4Mask | ControlMask, window_move, INT_ARG(2)},
    {XK_3, Mod4Mask | ControlMask, window_move, INT_ARG(3)},
    {XK_4, Mod4Mask | ControlMask, window_move, INT_ARG(4)},
    {XK_5, Mod4Mask | ControlMask, window_move, INT_ARG(5)},
    {XK_6, Mod4Mask | ControlMask, window_move, INT_ARG(6)},
    {XK_7, Mod4Mask | ControlMask, window_move, INT_ARG(7)},
    {XK_8, Mod4Mask | ControlMask, window_move, INT_ARG(8)},
    {XK_9, Mod4Mask | ControlMask, window_move, INT_ARG(9)},

    /* Workspace manipulation */
    {XK_n, Mod4Mask | ShiftMask, workspace_push},
    {XK_q, Mod4Mask | ShiftMask, workspace_pop},
    {XK_f, Mod4Mask | ShiftMask, workspace_fullscreen},
    {XK_h, Mod4Mask | ShiftMask, workspace_shrink},
    {XK_l, Mod4Mask | ShiftMask, workspace_grow},
    {XK_j, Mod4Mask | ShiftMask, workspace_roll_l},
    {XK_k, Mod4Mask | ShiftMask, workspace_roll_r},
    {XK_1, Mod4Mask | ShiftMask, workspace_swap, INT_ARG(1)},
    {XK_2, Mod4Mask | ShiftMask, workspace_swap, INT_ARG(2)},
    {XK_3, Mod4Mask | ShiftMask, workspace_swap, INT_ARG(3)},
    {XK_4, Mod4Mask | ShiftMask, workspace_swap, INT_ARG(4)},
    {XK_5, Mod4Mask | ShiftMask, workspace_swap, INT_ARG(5)},
    {XK_6, Mod4Mask | ShiftMask, workspace_swap, INT_ARG(6)},
    {XK_7, Mod4Mask | ShiftMask, workspace_swap, INT_ARG(7)},
    {XK_8, Mod4Mask | ShiftMask, workspace_swap, INT_ARG(8)},
    {XK_9, Mod4Mask | ShiftMask, workspace_swap, INT_ARG(9)},

    /* Window manager manipulation */
    {XK_j, Mod4Mask | Mod1Mask, mon_roll_l},
    {XK_k, Mod4Mask | Mod1Mask, mon_roll_r},
    {XK_1, Mod4Mask | Mod1Mask, mon_swap, INT_ARG(1)},
    {XK_2, Mod4Mask | Mod1Mask, mon_swap, INT_ARG(2)},
    {XK_3, Mod4Mask | Mod1Mask, mon_swap, INT_ARG(3)},
    {XK_4, Mod4Mask | Mod1Mask, mon_swap, INT_ARG(4)},
    {XK_5, Mod4Mask | Mod1Mask, mon_swap, INT_ARG(5)},
    {XK_6, Mod4Mask | Mod1Mask, mon_swap, INT_ARG(6)},
    {XK_7, Mod4Mask | Mod1Mask, mon_swap, INT_ARG(7)},
    {XK_8, Mod4Mask | Mod1Mask, mon_swap, INT_ARG(8)},
    {XK_9, Mod4Mask | Mod1Mask, mon_swap, INT_ARG(9)},
    {XK_r, Mod4Mask | Mod1Mask, wm_refresh},
    {XK_p, Mod4Mask | Mod1Mask, wm_replace},
    {XK_l, Mod4Mask | Mod1Mask, wm_logout},
    {XK_s, Mod4Mask | Mod1Mask, window_push, PROG_ARG("systemctl", "suspend")},

    /* Launchers */
    {XK_space, Mod4Mask, window_push, PROG_ARG("rofi", "-show", "run")},
    {XK_s, Mod4Mask, window_push, PROG_ARG("gnome-control-center", "sound")},
    {XK_c, Mod4Mask, window_push, PROG_ARG("google-chrome")},
    {XK_f, Mod4Mask, window_push, PROG_ARG("nautilus")},
    {XK_z, Mod4Mask, window_push, PROG_ARG("zoom")},
    {XK_t, Mod4Mask, window_push, PROG_ARG("kitty")},
    {XK_e, Mod4Mask, window_push, PROG_ARG("kitty", "nvim")},

    /* Misc */
    {XF86XK_AudioLowerVolume, 0, window_push,
     PROG_ARG("pactl", "set-sink-volume", "@DEFAULT_SINK@", "-10%")},
    {XF86XK_AudioRaiseVolume, 0, window_push,
     PROG_ARG("pactl", "set-sink-volume", "@DEFAULT_SINK@", "+10%")},
    {XF86XK_AudioMute, 0, window_push,
     PROG_ARG("pactl", "set-sink-mute", "@DEFAULT_SINK@", "toggle")},
    {XK_Print, 0, window_push, PROG_ARG("gnome-screenshot")},
    {XK_Print, Mod4Mask, window_push, PROG_ARG("gnome-screenshot", "-a")}};

const unsigned int num_keybinds = sizeof(keybinds) / sizeof(*keybinds);

void startup() { 
  window_push(PROG_ARG("feh", "--bg-scale", "/usr/share/backgrounds/f33/default/f33.png"));
  window_push(PROG_ARG("gnome-flashback"));
}
