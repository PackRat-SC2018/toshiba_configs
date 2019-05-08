/* See LICENSE file for copyright and license details. */

/* multimedia keys and layouts */
#include <X11/XF86keysym.h>
#include "gaplessgrid.c"

/* appearance */
static const unsigned int borderpx  = 2;        /* border pixel of windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const int focusonwheel       = 0;
static const unsigned int gappx     = 0;       /* gap pixel between windows */
static const char *fonts[]          = { "Inconsolata LGC Markup:regular:size=10:antialias=true:autohint=true" };
static const char dmenufont[]       = "Source Sans Pro:regular:size=10:antialias=true:autohint=true";
static const char col_gray1[]       = "#171717";
static const char col_gray2[]       = "#232323";
static const char col_gray3[]       = "#C4C4C4";
static const char col_gray4[]       = "#EEEEEE";
static const char col_gray5[]       = "#292933";
static const char col_yellow[]      = "#DE935F";
static const char col_yellow2[]     = "#705038";
static const char *colors[][3]      = {
	/*               fg         bg         border   */
	[SchemeNorm] = { col_gray3, col_gray1, col_gray2 },
	[SchemeSel]  = { col_yellow, col_gray1, col_yellow2 },
};

/* tagging */
static const char *tags[] = { "1", "2", "3", "4" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class      instance    title       tags mask     isfloating   monitor */
	{ "Gimp",         NULL,   NULL,       1 << 3,       0,           -1 },
/*	{ "Thunderbird",  NULL,   NULL,       1 << 7,       0,           -1 },
	{ "Firefox",      NULL,   NULL,       1 << 8,       0,           -1 },
	{ "XTerm",        NULL,   NULL,       0,            1,           -1 },  */
	{ "XCalc",        NULL,   NULL,       0,            1,           -1 },
	{ "Galculator",   NULL,   NULL,       0,            1,           -1 },
	{ "ColorBox",     NULL,   NULL,       0,            1,           -1 },
	{ "FontBox",      NULL,   NULL,       0,            1,           -1 },
	{ "YadCal",       NULL,   NULL,       0,            1,           -1 },
	{ "Yad-icon-browser",     NULL,    NULL,    0,      1,           -1 },
};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 0;    /* 1 means respect size hints in tiled resizals */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "[M]",      monocle },    
	{ "TTT",      bstack },
	{ "===",      bstackhoriz },
	{ "###",      gaplessgrid },
	{ "><>",      NULL },    /* no layout function means floating behavior */
};

/* key definitions */
#define MODKEY Mod4Mask
#define ALTKEY Mod1Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[]     = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", col_gray1, "-nf", col_gray3, "-sb", col_gray5, "-sf", col_gray4, NULL };
static const char *termcmd[]      = { "st", NULL };
static const char *xtermcmd[]     = { "xterm", NULL };
static const char *guimenucmd[]   = { "jgmenu_run", NULL};
static const char *roficmd[]      = { "rofi-apps", NULL};
static const char *exitcmd[]      = { "rofi-logout", NULL };
static const char *volup[]        = { "amixer", "-q", "sset", "Master", "5%+", "unmute", NULL };
static const char *voldown[]      = { "amixer", "-q", "sset", "Master", "5%-", "unmute", NULL };
static const char *volmute[]      = { "amixer", "-q", "sset", "Master", "toggle", NULL };
static const char *wwwcmd[]       = { "firefox", NULL };
static const char *mailcmd[]      = { "thunderbird", NULL };
static const char *editcmd[]      = { "subl3", NULL };
static const char *artcmd[]       = { "gimp", NULL };
static const char *filmancmd[]    = { "thunar", NULL };
static const char *rfmcmd[]       = { "xterm", "-e", "mc", NULL };
static const char *ssheetcmd[]    = { "libreoffice", "--calc", NULL };
static const char *doccmd[]       = { "libreoffice", "--writer", NULL };
static const char *britecmd[]     = { "acpilight", "-inc", "5", NULL };
static const char *dimcmd[]       = { "acpilight", "-dec", "5", NULL };

static Key keys[] = {
	/* modifier                     key        function        argument */
	{ MODKEY,                       XK_x,      spawn,          {.v = guimenucmd } },
	{ ALTKEY,                       XK_F2,     spawn,          {.v = roficmd } },
	{ MODKEY,                       XK_p,      spawn,          {.v = dmenucmd } },
	{ MODKEY|ShiftMask,             XK_Return, spawn,          {.v = xtermcmd } },
	{ ALTKEY,                       XK_F1,     spawn,          {.v = termcmd } },
	{ ALTKEY,                       XK_F3,     spawn,          {.v = xtermcmd } },
	{ MODKEY|ControlMask,           XK_l,      spawn,          {.v = editcmd } },
	{ MODKEY|ControlMask,           XK_g,      spawn,          {.v = artcmd } },
	{ MODKEY|ControlMask,           XK_p,      spawn,          {.v = ssheetcmd } },
	{ MODKEY|ControlMask,           XK_o,      spawn,          {.v = doccmd } },
	{ MODKEY|ControlMask,           XK_g,      spawn,          {.v = artcmd } },
	{ MODKEY,                       XK_r,      spawn,          {.v = rfmcmd }},
	{ 0,                            XF86XK_AudioRaiseVolume,   spawn,    {.v = volup } },
	{ 0,                            XF86XK_AudioLowerVolume,   spawn,    {.v = voldown } },
	{ 0,                            XF86XK_AudioMute,          spawn,    {.v = volmute } },
	{ MODKEY,                       XK_w,                      spawn,    {.v = wwwcmd } },
	{ 0,                            XF86XK_AudioNext,          spawn,    {.v = wwwcmd } },
	{ 0,                            XK_Menu,                   spawn,    {.v = filmancmd } },
	{ MODKEY,                       XK_t,                      spawn,    { .v = mailcmd } },
	{ 0,                            XF86XK_AudioPlay,          spawn,    { .v = mailcmd } },
	{ 0,                            XF86XK_MonBrightnessUp,    spawn,    { .v = britecmd } },
	{ 0,                            XF86XK_MonBrightnessDown,  spawn,    { .v = dimcmd } },
	{ MODKEY|ShiftMask,             XK_q,                      spawn,    { .v = exitcmd } },
	{ MODKEY|ControlMask,           XK_b,      togglebar,      {0} },
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
	{ ALTKEY,                       XK_Tab,    focusstack,     {.i = +1 } },
	{ ALTKEY|ShiftMask,             XK_Tab,    focusstack,     {.i = -1 } },
	{ MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
	{ MODKEY,                       XK_d,      incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
	{ MODKEY,                       XK_Return, zoom,           {0} },
	{ MODKEY,                       XK_Tab,    view,           {0} },
	{ MODKEY|ShiftMask,             XK_c,      killclient,     {0} },
	{ ALTKEY,                       XK_F4,     killclient,     {0} },
	{ MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_m,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_b,      setlayout,      {.v = &layouts[2]} },
	{ MODKEY|ShiftMask,             XK_b,      setlayout,      {.v = &layouts[3]} },
	{ MODKEY,                       XK_g,      setlayout,      {.v = &layouts[4]} },
	{ MODKEY,                       XK_f,      setlayout,      {.v = &layouts[5] } },
	{ MODKEY,                       XK_space,  setlayout,      {0} },
	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
	{ MODKEY|ShiftMask,             XK_e,      quit,           {0} },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            0,              Button2,        spawn,          {.v = guimenucmd } },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};
