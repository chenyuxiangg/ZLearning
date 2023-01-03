local broadcast_range = 30

TUNING.KAACHIEVEMENT =
{
    RPC =
    {
        SAVE_DELAY       = 3,
        POPUP_FADE_DELAY = 5,
    },
    BOSS =
    {
        BROADCAST_RANGE = broadcast_range,
    },
    EXPLORATION =
    {
        BROADCAST_RANGE = broadcast_range,
    },
    CHARACTER =
    {
        WILLOW_BURN_TIME        = 60,
        WILLOW_BURN_RESET_DELAY = 1,
        WURT_MERMKING_RANGE     = broadcast_range,
    },
    TIME =
    {
        BROADCAST_RANGE = broadcast_range,
    },
    SOCIAL =
    {
        LIGHT_FLARE_RANGE           = 8,
        GIVEPLAYER_GIVER_MIN_AGE    = 0, -- Klei says 20 (TUNING.ACHIEVEMENT_HELPOUT_GIVER_MIN_AGE)
        GIVEPLAYER_RECEIVER_MAX_AGE = 5, -- Klei says 2  (TUNING.ACHIEVEMENT_HELPOUT_RECEIVER_MAX_AGE)
    },
    ACTIVITY =
    {
        BROADCAST_RANGE_HALF       = broadcast_range / 2,
        BROADCAST_RANGE            = broadcast_range,
        PIGKING_MINIGAME_SCORE_MIN = 4, -- 1, 2, 3, 4
        NUM_PIG_FOLLOWERS          = 6,
        NUM_BUNNY_FOLLOWERS        = 6,
        NUM_ROCKY_FOLLOWERS        = 4,
        HATCH_WITNESS_RANGE        = broadcast_range,
        BEEFALO_TAME_RANGE         = broadcast_range,
        WEREPIG_WITNESS_RANGE      = broadcast_range,
        DO_EMOTE_RANGE             = broadcast_range,
        DO_EMOTE_PLAYERS           = 3,  -- including yourself
        KRAMPUS_SACK_WITNESS_RANGE = broadcast_range,
        OPALSTAFF_WITNESS_RANGE    = broadcast_range,
        CHESTER_WITNESS_RANGE      = broadcast_range,
        HUTCH_WITNESS_RANGE        = broadcast_range,
    },
    VALUE =
    {
        AMOUNT_TINY                = 1,
        AMOUNT_SMALL               = 5,
        AMOUNT_MEDSMALL            = 10,
        AMOUNT_MED                 = 20,
        AMOUNT_MEDLARGE            = 40, -- Was 30.
        AMOUNT_LARGE               = 60, -- Was 50.
        AMOUNT_HUGE                = 100,
        AMOUNT_MEDHUGE             = 500,
        AMOUNT_SUPERHUGE           = 1000, -- Was 500.

        MINUTE_TINY                = 60,
        MINUTE_SMALL               = 120,
        MINUTE_MEDSMALL            = 180,
        MINUTE_MED                 = 240,
        MINUTE_MEDLARGE            = 300,
        MINUTE_LARGE               = 360,
        MINUTE_HUGE                = 420,
        MINUTE_SUPERHUGE           = 500,
    },
    DOUBLE_CLICK_TIME = 0.5,
}

KAACHIEVEMENT =
{
    -- Achievement categories to load
    CATEGORIES =
    {
        "Mastery",
        "Activity",
        "Hunt",
        "Combat",
        "Boss",
        "Exploration",
        "Farming",
        "Social",
        "Time",
        "Character",
    },
    SORT =
    {
        "Default",
        "Alphabetically",
        "Unlocked_Locked",
        "Locked_Unlocked",
    },
    LANGS =
    {
        -- Make sure the translation file exists: scripts/kaachievement_utils/strings_<lang>.lua
        { text = "Português (BR)", data = "br" },
        { text = "English (EN)", data = "en" },
        { text = "한국어 (KR)", data = "kr" },
        { text = "简体中文 (ZH)", data = "zh" },
        { text = "正體中文 (ZHT)", data = "zht" },
    },
    KEYS =
    {
        -- text STRINGS.UI.CONTROLSSCREEN.INPUTS[1][KEY_F1]
        0,
        -- KEY_TAB,
        KEY_KP_0, KEY_KP_1, KEY_KP_2, KEY_KP_3, KEY_KP_4, KEY_KP_5, KEY_KP_6, KEY_KP_7, KEY_KP_8, KEY_KP_9,
        KEY_KP_PERIOD,
        KEY_KP_DIVIDE,
        KEY_KP_MULTIPLY,
        KEY_KP_MINUS,
        KEY_KP_PLUS,
        -- KEY_KP_ENTER,
        -- KEY_KP_EQUALS,
        KEY_MINUS,
        KEY_EQUALS,
        -- KEY_SPACE,
        -- KEY_ENTER,
        -- KEY_ESCAPE,
        KEY_HOME,
        KEY_INSERT,
        KEY_DELETE,
        KEY_END,
        KEY_PAUSE,
        -- KEY_PRINT,
        KEY_CAPSLOCK,
        KEY_SCROLLOCK,
        -- KEY_ALT,
        -- KEY_CTRL,
        -- KEY_SHIFT,
        KEY_BACKSPACE,
        KEY_PERIOD,
        -- KEY_SLASH,
        KEY_SEMICOLON,
        -- KEY_LEFTBRACKET,
        KEY_BACKSLASH,
        -- KEY_RIGHTBRACKET,
        -- KEY_TILDE,
        KEY_A, KEY_B, KEY_C, KEY_D, KEY_E, KEY_F, KEY_G, KEY_H, KEY_I, KEY_J, KEY_K, KEY_L, KEY_M,
        KEY_N, KEY_O, KEY_P, KEY_Q, KEY_R, KEY_S, KEY_T, KEY_U, KEY_V, KEY_W, KEY_X, KEY_Y, KEY_Z,
        KEY_F1, KEY_F2, KEY_F3, KEY_F4, KEY_F5, KEY_F6, KEY_F7, KEY_F8, KEY_F9, KEY_F10, KEY_F11, KEY_F12,
    }
}
