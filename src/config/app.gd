tool
extends FrameworkConfig


# ---

# This method is useful for defining parameters that are likely to change
# between builds or between development and production environments.
func _override_configs_for_current_run(manifest: Dictionary) -> void:
    # TODO: Remember to reset these when creating releases.
    
    var is_debug := true and OS.is_debug_build()
    var is_playtest := false
    
    var debug_window_size = ScaffolderGuiConfig.SCREEN_RESOLUTIONS.default
#    var debug_window_size = ScaffolderGuiConfig.SCREEN_RESOLUTIONS.full_screen
#    var debug_window_size = ScaffolderGuiConfig.SCREEN_RESOLUTIONS.google_ads_portrait
    
    _metadata.app_version = "0.0.1"
    
    _metadata.debug = is_debug
    _metadata.playtest = is_playtest
    _metadata.pauses_on_focus_out = !is_debug
    _metadata.also_prints_to_stdout = true
    _metadata.are_all_levels_unlocked = false and is_debug
    _metadata.are_test_levels_included = true
    _metadata.is_save_state_cleared_for_debugging = false
    _metadata.is_splash_skipped = true and is_debug
    
    _surfacer_manifest.precompute_platform_graph_for_levels = [
#        "1",
#        "2",
#        "3",
#        "4",
#        "5",
    ]
    _surfacer_manifest.ignores_platform_graph_save_files = false
    
    _gui_manifest.debug_window_size = debug_window_size
    _gui_manifest.hud_manifest.is_inspector_enabled_default = \
            false or is_debug or is_playtest

# ---

const INCLUDES_LEASH_SETTINGS_KEY := "includes_leash"

var _is_using_pixel_style := true

var _uses_threads := false and OS.can_use_threads()

var _metadata := {
    debug = false,
    playtest = false,
    pauses_on_focus_out = true,
    also_prints_to_stdout = true,
    is_profiler_enabled = true,
    are_all_levels_unlocked = true,
    is_splash_skipped = false,
    uses_threads = _uses_threads,
    thread_count = OS.get_processor_count() if _uses_threads else 1,
    is_mobile_supported = true,
    uses_level_scores = false,
    must_restart_level_to_change_settings = true,
    overrides_project_settings = true,
    overrides_input_map = true,
    
    app_name = "Momma Duck",
    app_id = "games.snoringcat.momma_duck",
    app_version = "0.0.1",
    score_version = "0.0.1",
    data_agreement_version = "0.0.1",
    
    # Must start with "UA-".
    google_analytics_id = "UA-186405125-3",
    privacy_policy_url = \
            "https://docs.google.com/document/d/1G90Hna_3ZlXYie3CDPne8vjdP7b3mq1Vqj8agbDsKJ8/preview",
    terms_and_conditions_url = \
            "https://docs.google.com/document/d/1qHZQiJnVJGHMWR0FzwBMCV_9NlMYWRhJKL-7I3hWlGk/preview",
    android_app_store_url = "",
    ios_app_store_url = "",
    support_url = "https://snoringcat.games/support",
    error_logs_url = \
            "https://storage.googleapis.com/upload/storage/v1/b/momma-duck-logs/o",
    app_id_query_param = "momma-duck",
    
    app_logo = preload("res://assets/images/logo.png"),
    app_logo_scale = 1.0,
    developer_name = "Snoring Cat LLC",
    developer_url = "https://snoringcat.games",
    
    developer_logo = preload( \
            "res://addons/scaffolder/assets/images/logos/snoring_cat_logo_about.png"),
    developer_splash = preload( \
            "res://addons/scaffolder/assets/images/logos/snoring_cat_logo_splash.png"),
    
    godot_splash_screen_duration = 1.4,
    developer_splash_screen_duration = 1.0,
}

var _fonts_manifest := {
    fonts = {
        main_xs = preload( \
                "res://addons/scaffolder/assets/fonts/pxlzr_font_xs.tres"),
        main_xs_bold = preload( \
                "res://addons/scaffolder/assets/fonts/pxlzr_font_xs.tres"),
        main_xs_italic = preload( \
                "res://addons/scaffolder/assets/fonts/pxlzr_font_xs.tres"),
        main_s = preload( \
                "res://addons/scaffolder/assets/fonts/pxlzr_font_s.tres"),
        main_s_bold = preload( \
                "res://addons/scaffolder/assets/fonts/pxlzr_font_s.tres"),
        main_s_italic = preload( \
                "res://addons/scaffolder/assets/fonts/pxlzr_font_s.tres"),
        main_m = preload( \
                "res://addons/scaffolder/assets/fonts/pxlzr_font_m.tres"),
        main_m_bold = preload( \
                "res://addons/scaffolder/assets/fonts/pxlzr_font_m.tres"),
        main_m_italic = preload( \
                "res://addons/scaffolder/assets/fonts/pxlzr_font_m.tres"),
        main_l = preload( \
                "res://addons/scaffolder/assets/fonts/pxlzr_font_l.tres"),
        main_l_bold = preload( \
                "res://addons/scaffolder/assets/fonts/pxlzr_font_l.tres"),
        main_l_italic = preload( \
                "res://addons/scaffolder/assets/fonts/pxlzr_font_l.tres"),
        main_xl = preload( \
                "res://addons/scaffolder/assets/fonts/pxlzr_font_xl.tres"),
        main_xl_bold = preload( \
                "res://addons/scaffolder/assets/fonts/pxlzr_font_xl.tres"),
        main_xl_italic = preload( \
                "res://addons/scaffolder/assets/fonts/pxlzr_font_xl.tres"),
        
        header_s = preload( \
                "res://addons/scaffolder/assets/fonts/pxlzr_font_s.tres"),
        header_m = preload( \
                "res://addons/scaffolder/assets/fonts/pxlzr_font_m.tres"),
        header_l = preload( \
                "res://addons/scaffolder/assets/fonts/pxlzr_font_l.tres"),
        header_xl = preload( \
                "res://addons/scaffolder/assets/fonts/pxlzr_font_xl.tres"),
    },
    sizes = {
        pc = {
            main_xs = 15,
            main_s = 18,
            main_m = 30,
            main_l = 42,
            main_xl = 48,
#            _bold = ,
#            _italic = ,
#            header_s = ,
#            header_m = ,
#            header_l = ,
#            header_xl = ,
        },
        mobile = {
            main_xs = 16,
            main_s = 18,
            main_m = 28,
            main_l = 32,
            main_xl = 36,
        },
    },
}

var _sounds_manifest := [
    {
        name = "fall",
        volume_db = 18.0,
        path_prefix = "res://addons/scaffolder/assets/sounds/",
    },
    {
        name = "menu_select",
        volume_db = -2.0,
        path_prefix = "res://addons/scaffolder/assets/sounds/",
    },
    {
        name = "menu_select_fancy",
        volume_db = -6.0,
        path_prefix = "res://addons/scaffolder/assets/sounds/",
    },
    {
        name = "lock_low",
        volume_db = 0.0,
        path_prefix = "res://addons/scaffolder/assets/sounds/",
    },
    {
        name = "lock_high",
        volume_db = 0.0,
        path_prefix = "res://addons/scaffolder/assets/sounds/",
    },
    {
        name = "walk",
        volume_db = 15.0,
        path_prefix = "res://addons/scaffolder/assets/sounds/",
    },
    {
        name = "achievement",
        volume_db = 12.0,
        path_prefix = "res://addons/scaffolder/assets/sounds/",
    },
    {
        name = "single_cat_snore",
        volume_db = 17.0,
        path_prefix = "res://addons/scaffolder/assets/sounds/",
    },
    
    {
        name = "duck_jump",
        volume_db = -6.0,
        path_prefix = "res://assets/sounds/",
    },
    {
        name = "duck_land",
        volume_db = -2.0,
        path_prefix = "res://assets/sounds/",
    },
    {
        name = "momma_cadence",
        volume_db = 10.0,
        path_prefix = "res://assets/sounds/",
    },
    {
        name = "cadence_lose",
        volume_db = 10.0,
        path_prefix = "res://addons/scaffolder/assets/sounds/",
    },
    {
        name = "duckling_quack",
        volume_db = 2.0,
        path_prefix = "res://assets/sounds/",
    },
    {
        name = "quack",
        volume_db = 1.0,
        path_prefix = "res://assets/sounds/",
    },
    {
        name = "lost_duck",
        volume_db = 1.0,
        path_prefix = "res://assets/sounds/",
    },
    {
        name = "splash",
        volume_db = 1.0,
        path_prefix = "res://assets/sounds/",
    },
    {
        name = "quack_peep",
        volume_db = 1.0,
        path_prefix = "res://assets/sounds/",
    },
]

var _music_manifest := [
    {
        name = "momma_music",
        path_prefix = "res://assets/music/",
        volume_db = 0.0,
        bpm = 112.5,
        meter = 4,
    },
    {
        name = "momma_pause_music",
        path_prefix = "res://assets/music/",
        volume_db = 0.0,
        bpm = 112.5,
        meter = 4,
    },
]

var _audio_manifest := {
    sounds_manifest = _sounds_manifest,
    default_sounds_path_prefix = "res://assets/sounds/",
    default_sounds_file_suffix = ".wav",
    default_sounds_bus_index = 1,
    
    music_manifest = _music_manifest,
    default_music_path_prefix = "res://addons/scaffolder/assets/music/",
    default_music_file_suffix = ".ogg",
    default_music_bus_index = 2,
    
    godot_splash_sound = "quack_peep",
    developer_splash_sound = "single_cat_snore",
    level_end_sound_win = "momma_cadence",
    level_end_sound_lose = "cadence_lose",
    
    main_menu_music = "momma_pause_music",
    game_over_music = "momma_pause_music",
    pause_menu_music = "momma_pause_music",
    default_level_music = "momma_music",
    
    pauses_level_music_on_pause = true,
    
    are_beats_tracked_by_default = false,
    
    is_arbitrary_music_speed_change_supported = false,
    is_music_speed_scaled_with_time_scale = false,
    is_music_speed_scaled_with_additional_debug_time_scale = false,
    
    is_music_paused_in_slow_motion = false,
    is_tick_tock_played_in_slow_motion = false,
    is_slow_motion_start_stop_sound_effect_played = false,
}

var COLOR_BACKGROUND := Color("2f4034")
var COLOR_BACKGROUND_LIGHTER := Color("3c4d41")
var COLOR_BACKGROUND_DARKER := Color("233327")

var COLOR_TEXT := Color("eeeeee")
var COLOR_HEADER := Color("fff12e")
var COLOR_FOCUS := Color("47a65f")

var COLOR_BUTTON := Color("24803b")
var COLOR_BUTTON_LIGHTER := Color("47a65f")
var COLOR_BUTTON_DARKER := Color("0c591f")

var COLOR_SHADOW := Color("88000000")

var _colors_manifest := {
    # Scaffolder colors.
    
    # Should match Project Settings > Application > Boot Splash > Bg Color.
    boot_splash_background = \
            ScaffolderColors.DEFAULT_BOOT_SPLASH_BACKGROUND_COLOR,
    # Should match
    #     Project Settings > Rendering > Environment > Default Clear Color.
    background = COLOR_BACKGROUND,
    text = COLOR_TEXT,
    header = COLOR_HEADER,
    focus_border = COLOR_FOCUS,
    link_normal = COLOR_BUTTON_LIGHTER,
    link_hover = COLOR_BUTTON,
    link_pressed = COLOR_BUTTON_DARKER,
    button_normal = COLOR_BUTTON,
    button_pulse_modulate = Color(2, 2, 2, 1),
    button_disabled = COLOR_BUTTON_LIGHTER,
    button_focused = COLOR_BUTTON_LIGHTER,
    button_hover = COLOR_BUTTON_LIGHTER,
    button_pressed = COLOR_BUTTON_DARKER,
    button_border = COLOR_TEXT,
    dropdown_normal = COLOR_BACKGROUND,
    dropdown_disabled = COLOR_BACKGROUND_LIGHTER,
    dropdown_focused = COLOR_BACKGROUND_LIGHTER,
    dropdown_hover = COLOR_BACKGROUND_LIGHTER,
    dropdown_pressed = COLOR_BACKGROUND_DARKER,
    dropdown_border = COLOR_BACKGROUND_DARKER,
    tooltip = COLOR_BACKGROUND,
    tooltip_bg = COLOR_TEXT,
    popup_background = COLOR_BACKGROUND_LIGHTER,
    scroll_bar_background = COLOR_BACKGROUND_LIGHTER,
    scroll_bar_grabber_normal = COLOR_BUTTON,
    scroll_bar_grabber_hover = COLOR_BUTTON_LIGHTER,
    scroll_bar_grabber_pressed = COLOR_BUTTON_DARKER,
    slider_background = COLOR_BACKGROUND_DARKER,
    zebra_stripe_even_row = COLOR_BACKGROUND_LIGHTER,
    overlay_panel_background = COLOR_BACKGROUND_DARKER,
    overlay_panel_border = COLOR_TEXT,
    header_panel_background = COLOR_BACKGROUND,
    screen_border = COLOR_TEXT,
    shadow = COLOR_SHADOW,
    
    # Surfacer colors.
    
    click = ScaffolderColors.static_opacify(
            SurfacerColors.WHITE, ScaffolderColors.ALPHA_SLIGHTLY_FAINT),
    surface_click_selection = ScaffolderColors.static_opacify(
            SurfacerColors.WHITE, ScaffolderColors.ALPHA_SOLID),
    grid_indices = ScaffolderColors.static_opacify(
            SurfacerColors.WHITE, ScaffolderColors.ALPHA_FAINT),
    ruler = SurfacerColors.WHITE,
    invalid = SurfacerColors.RED,
    human_navigation = Color("40ff00"),
    computer_navigation = Color("ff8000"),
    player_position = Color("00db0b"),
    recent_movement = Color("ffda85"),
    inspector_origin = ScaffolderColors.static_opacify(
            SurfacerColors.ORANGE, ScaffolderColors.ALPHA_FAINT),
}

var _styles_manifest_normal := {
    focus_border_corner_radius = 5,
    focus_border_corner_detail = 3,
    focus_border_shadow_size = 0,
    focus_border_border_width = 1,
    focus_border_expand_margin_left = 2.0,
    focus_border_expand_margin_top = 2.0,
    focus_border_expand_margin_right = 2.0,
    focus_border_expand_margin_bottom = 2.0,
    
    button_content_margin_left = 16.0,
    button_content_margin_top = 8.0,
    button_content_margin_right = 16.0,
    button_content_margin_bottom = 8.0,
    
    button_shine_margin_left = 0.0,
    button_shine_margin_top = 0.0,
    button_shine_margin_right = 0.0,
    button_shine_margin_bottom = 0.0,
    
    button_corner_radius = 4,
    button_corner_detail = 3,
    button_shadow_size = 3,
    button_border_width = 0,
    
    dropdown_corner_radius = 4,
    dropdown_corner_detail = 3,
    dropdown_shadow_size = 0,
    dropdown_border_width = 0,
    
    scroll_corner_radius = 6,
    scroll_corner_detail = 3,
    # Width of the scrollbar.
    scroll_content_margin_left = 7,
    scroll_content_margin_top = 7,
    scroll_content_margin_right = 7,
    scroll_content_margin_bottom = 7,
    
    scroll_grabber_corner_radius = 8,
    scroll_grabber_corner_detail = 3,
    
    slider_corner_radius = 6,
    slider_corner_detail = 3,
    slider_content_margin_left = 5,
    slider_content_margin_top = 5,
    slider_content_margin_right = 5,
    slider_content_margin_bottom = 5,
    
    overlay_panel_border_width = 2,
    
    overlay_panel_corner_radius = 4,
    overlay_panel_corner_detail = 3,
    overlay_panel_content_margin_left = 0.0,
    overlay_panel_content_margin_top = 0.0,
    overlay_panel_content_margin_right = 0.0,
    overlay_panel_content_margin_bottom = 0.0,
    overlay_panel_shadow_size = 8,
    overlay_panel_shadow_offset = Vector2(-4.0, 4.0),
    
    header_panel_content_margin_left = 0.0,
    header_panel_content_margin_top = 0.0,
    header_panel_content_margin_right = 0.0,
    header_panel_content_margin_bottom = 0.0,
    
    hud_panel_nine_patch = \
            preload("res://addons/scaffolder/assets/images/gui/overlay_panel.png"),
    hud_panel_nine_patch_margin_left = 3.5,
    hud_panel_nine_patch_margin_top = 3.5,
    hud_panel_nine_patch_margin_right = 3.5,
    hud_panel_nine_patch_margin_bottom = 3.5,
    hud_panel_nine_patch_scale = 3.0,
    hud_panel_content_margin_left = 8.0,
    hud_panel_content_margin_top = 2.0,
    hud_panel_content_margin_right = 8.0,
    hud_panel_content_margin_bottom = 2.0,
    
    screen_shadow_size = 8,
    screen_shadow_offset = Vector2(-4.0, 4.0),
    screen_border_width = 0,
}

var _styles_manifest_pixel := {
    button_content_margin_left = 16.0,
    button_content_margin_top = 8.0,
    button_content_margin_right = 16.0,
    button_content_margin_bottom = 8.0,
    
    button_shine_margin_left = 6.0,
    button_shine_margin_top = 6.0,
    button_shine_margin_right = 6.0,
    button_shine_margin_bottom = 6.0,
    
    focus_border_nine_patch = \
            preload("res://addons/scaffolder/assets/images/gui/focus_border.png"),
    focus_border_nine_patch_margin_left = 3.5,
    focus_border_nine_patch_margin_top = 3.5,
    focus_border_nine_patch_margin_right = 3.5,
    focus_border_nine_patch_margin_bottom = 3.5,
    focus_border_nine_patch_scale = 3.0,
    focus_border_expand_margin_left = 3.0,
    focus_border_expand_margin_top = 3.0,
    focus_border_expand_margin_right = 3.0,
    focus_border_expand_margin_bottom = 3.0,
    
    button_active_nine_patch = \
            preload("res://assets/images/button_active.png"),
    button_disabled_nine_patch = \
            preload("res://assets/images/button_hover.png"),
    button_hover_nine_patch = \
            preload("res://assets/images/button_hover.png"),
    button_normal_nine_patch = \
            preload("res://assets/images/button_normal.png"),
    button_nine_patch_margin_left = 3.5,
    button_nine_patch_margin_top = 3.5,
    button_nine_patch_margin_right = 3.5,
    button_nine_patch_margin_bottom = 3.5,
    button_nine_patch_scale = 3.0,
    
    dropdown_active_nine_patch = \
            preload("res://assets/images/dropdown_active.png"),
    dropdown_disabled_nine_patch = \
            preload("res://assets/images/dropdown_hover.png"),
    dropdown_hover_nine_patch = \
            preload("res://assets/images/dropdown_hover.png"),
    dropdown_normal_nine_patch = \
            preload("res://assets/images/dropdown_normal.png"),
    dropdown_nine_patch_margin_left = 3.5,
    dropdown_nine_patch_margin_top = 3.5,
    dropdown_nine_patch_margin_right = 3.5,
    dropdown_nine_patch_margin_bottom = 3.5,
    dropdown_nine_patch_scale = 3.0,
    
    scroll_track_nine_patch = \
            preload("res://assets/images/scroll_track.png"),
    scroll_track_nine_patch_margin_left = 3.5,
    scroll_track_nine_patch_margin_top = 3.5,
    scroll_track_nine_patch_margin_right = 3.5,
    scroll_track_nine_patch_margin_bottom = 3.5,
    scroll_track_nine_patch_scale = 3.0,
    
    scroll_grabber_active_nine_patch = \
            preload("res://assets/images/scroll_grabber_active.png"),
    scroll_grabber_hover_nine_patch = \
            preload("res://assets/images/scroll_grabber_hover.png"),
    scroll_grabber_normal_nine_patch = \
            preload("res://assets/images/scroll_grabber_normal.png"),
    scroll_grabber_nine_patch_margin_left = 3.5,
    scroll_grabber_nine_patch_margin_top = 3.5,
    scroll_grabber_nine_patch_margin_right = 3.5,
    scroll_grabber_nine_patch_margin_bottom = 3.5,
    scroll_grabber_nine_patch_scale = 3.0,
    
    slider_track_nine_patch = \
            preload("res://addons/scaffolder/assets/images/gui/slider_track.png"),
    slider_track_nine_patch_margin_left = 1.5,
    slider_track_nine_patch_margin_top = 1.5,
    slider_track_nine_patch_margin_right = 1.5,
    slider_track_nine_patch_margin_bottom = 1.5,
    slider_track_nine_patch_scale = 3.0,
    
    overlay_panel_border_width = 2,
    
    overlay_panel_nine_patch = \
            preload("res://addons/scaffolder/assets/images/gui/overlay_panel.png"),
    overlay_panel_nine_patch_margin_left = 3.5,
    overlay_panel_nine_patch_margin_top = 3.5,
    overlay_panel_nine_patch_margin_right = 3.5,
    overlay_panel_nine_patch_margin_bottom = 3.5,
    overlay_panel_nine_patch_scale = 3.0,
    overlay_panel_content_margin_left = 3.0,
    overlay_panel_content_margin_top = 3.0,
    overlay_panel_content_margin_right = 3.0,
    overlay_panel_content_margin_bottom = 3.0,
    
    header_panel_content_margin_left = 0.0,
    header_panel_content_margin_top = 0.0,
    header_panel_content_margin_right = 0.0,
    header_panel_content_margin_bottom = 0.0,
    
    hud_panel_nine_patch = \
            preload("res://addons/scaffolder/assets/images/gui/overlay_panel.png"),
    hud_panel_nine_patch_margin_left = 3.5,
    hud_panel_nine_patch_margin_top = 3.5,
    hud_panel_nine_patch_margin_right = 3.5,
    hud_panel_nine_patch_margin_bottom = 3.5,
    hud_panel_nine_patch_scale = 3.0,
    hud_panel_content_margin_left = 8.0,
    hud_panel_content_margin_top = 2.0,
    hud_panel_content_margin_right = 8.0,
    hud_panel_content_margin_bottom = 2.0,
    
    screen_shadow_size = 0,
    screen_shadow_offset = Vector2.ZERO,
    screen_border_width = 0,
}

var _icons_manifest_normal := {
    checkbox_path_prefix = \
            ScaffolderIcons.DEFAULT_CHECKBOX_NORMAL_PATH_PREFIX,
    default_checkbox_size = \
            ScaffolderIcons.DEFAULT_CHECKBOX_NORMAL_SIZE,
    checkbox_sizes = \
            ScaffolderIcons.DEFAULT_CHECKBOX_NORMAL_SIZES,
    
    radio_button_path_prefix = \
            ScaffolderIcons.DEFAULT_RADIO_BUTTON_NORMAL_PATH_PREFIX,
    default_radio_button_size = \
            ScaffolderIcons.DEFAULT_RADIO_BUTTON_NORMAL_SIZE,
    radio_button_sizes = \
            ScaffolderIcons.DEFAULT_RADIO_BUTTON_NORMAL_SIZES,
    
    tree_arrow_path_prefix = \
            ScaffolderIcons.DEFAULT_TREE_ARROW_NORMAL_PATH_PREFIX,
    default_tree_arrow_size = \
            ScaffolderIcons.DEFAULT_TREE_ARROW_NORMAL_SIZE,
    tree_arrow_sizes = \
            ScaffolderIcons.DEFAULT_TREE_ARROW_NORMAL_SIZES,
    
    dropdown_arrow_path_prefix = \
            ScaffolderIcons.DEFAULT_DROPDOWN_ARROW_NORMAL_PATH_PREFIX,
    default_dropdown_arrow_size = \
            ScaffolderIcons.DEFAULT_DROPDOWN_ARROW_NORMAL_SIZE,
    dropdown_arrow_sizes = \
            ScaffolderIcons.DEFAULT_DROPDOWN_ARROW_NORMAL_SIZES,
    
    slider_grabber_path_prefix = \
            ScaffolderIcons.DEFAULT_SLIDER_GRABBER_NORMAL_PATH_PREFIX,
    default_slider_grabber_size = \
            ScaffolderIcons.DEFAULT_SLIDER_GRABBER_NORMAL_SIZE,
    slider_grabber_sizes = \
            ScaffolderIcons.DEFAULT_SLIDER_GRABBER_NORMAL_SIZES,
    
    slider_tick_path_prefix = \
            ScaffolderIcons.DEFAULT_SLIDER_TICK_NORMAL_PATH_PREFIX,
    default_slider_tick_size = \
            ScaffolderIcons.DEFAULT_SLIDER_TICK_NORMAL_SIZE,
    slider_tick_sizes = \
            ScaffolderIcons.DEFAULT_SLIDER_TICK_NORMAL_SIZES,
    
    go_normal = preload("res://assets/images/go_icon.png"),
    go_scale = 1.5,
    
    about_circle_active = \
            preload("res://addons/scaffolder/assets/images/gui/about_circle_active.png"),
    about_circle_hover = \
            preload("res://addons/scaffolder/assets/images/gui/about_circle_hover.png"),
    about_circle_normal = \
            preload("res://addons/scaffolder/assets/images/gui/about_circle_normal.png"),
    
    alert_normal = \
            preload("res://addons/scaffolder/assets/images/gui/alert_normal.png"),
    
    close_active = \
            preload("res://addons/scaffolder/assets/images/gui/close_active.png"),
    close_hover = \
            preload("res://addons/scaffolder/assets/images/gui/close_hover.png"),
    close_normal = \
            preload("res://addons/scaffolder/assets/images/gui/close_normal.png"),
    
    gear_circle_active = \
            preload("res://addons/scaffolder/assets/images/gui/gear_circle_active.png"),
    gear_circle_hover = \
            preload("res://addons/scaffolder/assets/images/gui/gear_circle_hover.png"),
    gear_circle_normal = \
            preload("res://addons/scaffolder/assets/images/gui/gear_circle_normal.png"),
    
    home_normal = \
            preload("res://addons/scaffolder/assets/images/gui/home_normal.png"),
    
    left_caret_active = \
            preload("res://addons/scaffolder/assets/images/gui/left_caret_active.png"),
    left_caret_hover = \
            preload("res://addons/scaffolder/assets/images/gui/left_caret_hover.png"),
    left_caret_normal = \
            preload("res://addons/scaffolder/assets/images/gui/left_caret_normal.png"),
    
    pause_circle_active = \
            preload("res://addons/scaffolder/assets/images/gui/pause_circle_active.png"),
    pause_circle_hover = \
            preload("res://addons/scaffolder/assets/images/gui/pause_circle_hover.png"),
    pause_circle_normal = \
            preload("res://addons/scaffolder/assets/images/gui/pause_circle_normal.png"),
    
    pause_normal = \
            preload("res://addons/scaffolder/assets/images/gui/pause_normal.png"),
    play_normal = \
            preload("res://addons/scaffolder/assets/images/gui/play_normal.png"),
    retry_normal = \
            preload("res://addons/scaffolder/assets/images/gui/retry_normal.png"),
    stop_normal = \
            preload("res://addons/scaffolder/assets/images/gui/stop_normal.png"),
}

var _icons_manifest_pixel := {
    checkbox_path_prefix = \
            ScaffolderIcons.DEFAULT_CHECKBOX_PIXEL_PATH_PREFIX,
    default_checkbox_size = \
            ScaffolderIcons.DEFAULT_CHECKBOX_PIXEL_SIZE,
    checkbox_sizes = \
            ScaffolderIcons.DEFAULT_CHECKBOX_PIXEL_SIZES,
    
    radio_button_path_prefix = \
            ScaffolderIcons.DEFAULT_RADIO_BUTTON_PIXEL_PATH_PREFIX,
    default_radio_button_size = \
            ScaffolderIcons.DEFAULT_RADIO_BUTTON_PIXEL_SIZE,
    radio_button_sizes = \
            ScaffolderIcons.DEFAULT_RADIO_BUTTON_PIXEL_SIZES,
    
    tree_arrow_path_prefix = \
            ScaffolderIcons.DEFAULT_TREE_ARROW_PIXEL_PATH_PREFIX,
    default_tree_arrow_size = \
            ScaffolderIcons.DEFAULT_TREE_ARROW_PIXEL_SIZE,
    tree_arrow_sizes = \
            ScaffolderIcons.DEFAULT_TREE_ARROW_PIXEL_SIZES,
    
    dropdown_arrow_path_prefix = \
            ScaffolderIcons.DEFAULT_DROPDOWN_ARROW_PIXEL_PATH_PREFIX,
    default_dropdown_arrow_size = \
            ScaffolderIcons.DEFAULT_DROPDOWN_ARROW_PIXEL_SIZE,
    dropdown_arrow_sizes = \
            ScaffolderIcons.DEFAULT_DROPDOWN_ARROW_PIXEL_SIZES,
    
    slider_grabber_path_prefix = \
            ScaffolderIcons.DEFAULT_SLIDER_GRABBER_PIXEL_PATH_PREFIX,
    default_slider_grabber_size = \
            ScaffolderIcons.DEFAULT_SLIDER_GRABBER_PIXEL_SIZE,
    slider_grabber_sizes = \
            ScaffolderIcons.DEFAULT_SLIDER_GRABBER_PIXEL_SIZES,
    
    slider_tick_path_prefix = \
            ScaffolderIcons.DEFAULT_SLIDER_TICK_PIXEL_PATH_PREFIX,
    default_slider_tick_size = \
            ScaffolderIcons.DEFAULT_SLIDER_TICK_PIXEL_SIZE,
    slider_tick_sizes = \
            ScaffolderIcons.DEFAULT_SLIDER_TICK_PIXEL_SIZES,
    
    go_normal = preload("res://assets/images/go_icon.png"),
    go_scale = 1.5,
    
    about_circle_active = \
            preload("res://addons/scaffolder/assets/images/gui/about_circle_active.png"),
    about_circle_hover = \
            preload("res://addons/scaffolder/assets/images/gui/about_circle_hover.png"),
    about_circle_normal = \
            preload("res://addons/scaffolder/assets/images/gui/about_circle_normal.png"),
    
    alert_normal = \
            preload("res://addons/scaffolder/assets/images/gui/alert_normal.png"),
    
    close_active = \
            preload("res://addons/scaffolder/assets/images/gui/close_active.png"),
    close_hover = \
            preload("res://addons/scaffolder/assets/images/gui/close_hover.png"),
    close_normal = \
            preload("res://addons/scaffolder/assets/images/gui/close_normal.png"),
    
    gear_circle_active = \
            preload("res://addons/scaffolder/assets/images/gui/gear_circle_active.png"),
    gear_circle_hover = \
            preload("res://addons/scaffolder/assets/images/gui/gear_circle_hover.png"),
    gear_circle_normal = \
            preload("res://addons/scaffolder/assets/images/gui/gear_circle_normal.png"),
    
    home_normal = \
            preload("res://addons/scaffolder/assets/images/gui/home_normal.png"),
    
    left_caret_active = \
            preload("res://addons/scaffolder/assets/images/gui/left_caret_active.png"),
    left_caret_hover = \
            preload("res://addons/scaffolder/assets/images/gui/left_caret_hover.png"),
    left_caret_normal = \
            preload("res://addons/scaffolder/assets/images/gui/left_caret_normal.png"),
    
    pause_circle_active = \
            preload("res://addons/scaffolder/assets/images/gui/pause_circle_active.png"),
    pause_circle_hover = \
            preload("res://addons/scaffolder/assets/images/gui/pause_circle_hover.png"),
    pause_circle_normal = \
            preload("res://addons/scaffolder/assets/images/gui/pause_circle_normal.png"),
    
    pause_normal = \
            preload("res://addons/scaffolder/assets/images/gui/pause_normal.png"),
    play_normal = \
            preload("res://addons/scaffolder/assets/images/gui/play_normal.png"),
    retry_normal = \
            preload("res://addons/scaffolder/assets/images/gui/retry_normal.png"),
    stop_normal = \
            preload("res://addons/scaffolder/assets/images/gui/stop_normal.png"),
}

var _settings_item_manifest := {
    groups = {
        main = {
            label = "",
            is_collapsible = false,
            item_classes = [
                LeashIncludedSettingsLabeledControlItem,
                MusicSettingsLabeledControlItem,
                SoundEffectsSettingsLabeledControlItem,
                HapticFeedbackSettingsLabeledControlItem,
            ],
        },
        annotations = {
            label = "Rendering",
            is_collapsible = true,
            item_classes = [
                RulerAnnotatorSettingsLabeledControlItem,
                PreselectionTrajectoryAnnotatorSettingsLabeledControlItem,
                ActiveTrajectoryAnnotatorSettingsLabeledControlItem,
                PreviousTrajectoryAnnotatorSettingsLabeledControlItem,
                NavigationDestinationAnnotatorSettingsLabeledControlItem,
                RecentMovementAnnotatorSettingsLabeledControlItem,
                SurfacesAnnotatorSettingsLabeledControlItem,
                PlayerPositionAnnotatorSettingsLabeledControlItem,
                PlayerAnnotatorSettingsLabeledControlItem,
                LevelAnnotatorSettingsLabeledControlItem,
            ],
        },
        hud = {
            label = "HUD",
            is_collapsible = true,
            item_classes = [
                InspectorEnabledSettingsLabeledControlItem,
                DebugPanelSettingsLabeledControlItem,
            ],
        },
        miscellaneous = {
            label = "Miscellaneous",
            is_collapsible = true,
            item_classes = [
                WelcomePanelSettingsLabeledControlItem,
                IntroChoreographySettingsLabeledControlItem,
                CameraZoomSettingsLabeledControlItem,
                TimeScaleSettingsLabeledControlItem,
                MetronomeSettingsLabeledControlItem,
                LogSurfacerEventsSettingsLabeledControlItem,
            ],
        },
    },
}

var _pause_item_manifest := [
    LevelLabeledControlItem,
    TimeLabeledControlItem,
    FastestTimeLabeledControlItem,
    FollowersCountLabeledControlItem,
    ScareCountLabeledControlItem,
]

var _game_over_item_manifest := [
    LevelLabeledControlItem,
    TimeLabeledControlItem,
    FastestTimeLabeledControlItem,
]

var _level_select_item_manifest := [
    TotalPlaysLabeledControlItem,
    FastestTimeLabeledControlItem,
]

var _hud_manifest := {
    hud_class = MommaDuckHud,
    hud_key_value_box_size = \
            ScaffolderGuiConfig.HUD_KEY_VALUE_BOX_DEFAULT_SIZE,
    hud_key_value_box_scene = \
            preload("res://addons/scaffolder/src/gui/hud/hud_key_value_box.tscn"),
    hud_key_value_list_scene = \
            preload("res://addons/scaffolder/src/gui/hud/hud_key_value_list.tscn"),
    hud_key_value_list_item_manifest = [
        {
            item_class = TimeLabeledControlItem,
            settings_enablement_label = "Time",
            enabled_by_default = true,
            settings_group_key = "hud",
        },
        {
            item_class = FollowersCountLabeledControlItem,
            settings_enablement_label = "Ducklings in tow",
            enabled_by_default = true,
            settings_group_key = "hud",
        },
    ],
    is_inspector_enabled_default = false,
    inspector_panel_starts_open = false,
}

var _welcome_panel_manifest := {
    items = [
        ["Lead your ducklings to the pond"],
        ["*Auto nav*", "click"],
        ["Walk/Climb", "arrow key / wasd"],
        ["Jump", "space / x"],
    ],
    header_color = [
    ],
    body_color = [
    ],
}

var _screen_manifest := {
    exclusions = [
        preload("res://addons/scaffolder/src/gui/screens/rate_app_screen.tscn"),
    ],
    inclusions = [
    ],
    overlay_mask_transition_fade_in_texture = \
            preload("res://addons/scaffolder/assets/images/transition_masks/radial_mask_transition_in.png"),
    overlay_mask_transition_fade_out_texture = \
            preload("res://addons/scaffolder/assets/images/transition_masks/radial_mask_transition_in.png"),
    screen_mask_transition_fade_texture = \
            preload("res://addons/scaffolder/assets/images/transition_masks/checkers_mask_transition.png"),
    overlay_mask_transition_class = OverlayMaskTransition,
    screen_mask_transition_class = ScreenMaskTransition,
    slide_transition_duration = 0.3,
    fade_transition_duration = 0.3,
    overlay_mask_transition_duration = 1.2,
    screen_mask_transition_duration = 1.2,
    slide_transition_easing = "ease_in_out",
    fade_transition_easing = "ease_in_out",
    overlay_mask_transition_fade_in_easing = "ease_out",
    overlay_mask_transition_fade_out_easing = "ease_in",
    screen_mask_transition_easing = "ease_in",
    default_transition_type = ScreenTransition.FADE,
    fancy_transition_type = ScreenTransition.SCREEN_MASK,
    overlay_mask_transition_color = Color("#111111"),
    overlay_mask_transition_uses_pixel_snap = false,
    overlay_mask_transition_smooth_size = 0.02,
    screen_mask_transition_uses_pixel_snap = true,
    screen_mask_transition_smooth_size = 0.0,
}

var _gui_manifest := {
    debug_window_size = ScaffolderGuiConfig.SCREEN_RESOLUTIONS.full_screen,
    
    cell_size = Vector2(32.0, 32.0),
    default_pc_game_area_size = Vector2(1024, 768),
    default_mobile_game_area_size = Vector2(500, 600),
    aspect_ratio_max = 2.0 / 1.0,
    aspect_ratio_min = 1.0 / 2.0,
    camera_smoothing_speed = 10.0,
    default_camera_zoom = 0.4,
    button_height = 56.0,
    button_width = 230.0,
    screen_body_width = 460.0,
    
    is_data_deletion_button_shown = true,
    
    is_suggested_button_shine_line_shown = true,
    is_suggested_button_color_pulse_shown = true,
    
    third_party_license_text = \
            ScaffolderThirdPartyLicenses.TEXT + \
            SurfacerThirdPartyLicenses.TEXT + \
            ThirdPartyLicenses.TEXT,
    special_thanks_text = """
""",
    
    main_menu_image_scale = 1.0,
    game_over_image_scale = 0.5,
    loading_image_scale = 0.5,
    
    main_menu_image_scene = \
            preload("res://src/gui/loading_image.tscn"),
    game_over_image_scene = \
            preload("res://src/gui/loading_image.tscn"),
    loading_image_scene = \
            preload("res://src/gui/loading_image.tscn"),
    welcome_panel_scene = \
            preload("res://addons/scaffolder/src/gui/welcome_panel.tscn"),
    debug_panel_scene = \
            preload("res://addons/scaffolder/src/gui/debug_panel.tscn"),
    
    theme = preload("res://src/config/default_theme.tres"),
    
    fonts_manifest = _fonts_manifest,
    settings_item_manifest = _settings_item_manifest,
    pause_item_manifest = _pause_item_manifest,
    game_over_item_manifest = _game_over_item_manifest,
    level_select_item_manifest = _level_select_item_manifest,
    hud_manifest = _hud_manifest,
    welcome_panel_manifest = _welcome_panel_manifest,
    screen_manifest = _screen_manifest,
    
    splash_scale_pc = 1.0,
    splash_scale_mobile = 0.77,
}

var _slow_motion_manifest := {
    time_scale = 1.0,
    tick_tock_tempo_multiplier = 1,
    saturation = 0.5,
}

var _input_map = ScaffolderProjectSettings.DEFAULT_INPUT_MAP

var _additional_metric_keys := [
]

var _surfacer_debug_params := {
}

var _player_param_classes := [
    preload("res://src/players/duckling/duckling_params.gd"),
    preload("res://src/players/fox/fox_params.gd"),
    preload("res://src/players/momma/momma_params.gd"),
    preload("res://src/players/porcupine/porcupine_params.gd"),
    preload("res://src/players/run_away_duckling/run_away_duckling_params.gd"),
]

var _surfacer_manifest := {
    precompute_platform_graph_for_levels = [],
    ignores_platform_graph_save_files = false,
    ignores_platform_graph_save_file_trajectory_state = false,
    is_debug_only_platform_graph_state_included = false,
    are_loaded_surfaces_deeply_validated = true,
    uses_threads_for_platform_graph_calculation = false and _uses_threads,
    
    default_player_name = 'momma',
    nav_selection_prediction_opacity = 0.5,
    nav_selection_prediction_tween_duration = 0.15,
    new_path_pulse_duration = 0.7,
    new_path_pulse_time_length = 1.0,
    path_drag_update_throttle_interval = 0.2,
    path_beat_update_throttle_interval = 0.2,
    
    # Params for CameraPanController.
    snaps_camera_back_to_player = true,
    max_zoom_multiplier_from_pointer = 1.5,
    max_pan_distance_from_pointer = 512.0,
    duration_to_max_pan_from_pointer_at_max_control = 0.67,
    duration_to_max_zoom_from_pointer_at_max_control = 3.0,
    screen_size_ratio_distance_from_edge_to_start_pan_from_pointer = 0.3,
    
    skip_choreography_framerate_multiplier = 4.0,
    
    is_human_current_nav_trajectory_shown_with_slow_mo = false,
    is_computer_current_nav_trajectory_shown_with_slow_mo = true,
    is_human_current_nav_trajectory_shown_without_slow_mo = true,
    is_computer_current_nav_trajectory_shown_without_slow_mo = false,
    is_human_nav_pulse_shown_with_slow_mo = false,
    is_computer_nav_pulse_shown_with_slow_mo = true,
    is_human_nav_pulse_shown_without_slow_mo = true,
    is_computer_nav_pulse_shown_without_slow_mo = false,
    is_human_new_nav_exclamation_mark_shown = false,
    is_computer_new_nav_exclamation_mark_shown = false,
    does_human_nav_pulse_grow = false,
    does_computer_nav_pulse_grow = true,
    is_human_prediction_shown = true,
    is_computer_prediction_shown = true,
    
    debug_params = _surfacer_debug_params,
    player_action_classes = Su.DEFAULT_PLAYER_ACTION_CLASSES,
    edge_movement_classes = Su.DEFAULT_EDGE_MOVEMENT_CLASSES,
    player_param_classes = _player_param_classes,
}

var app_manifest := {
    level_config_class = MommaDuckLevelConfig,
    level_session_class = MommaDuckLevelSession,
    
    metadata = _metadata,
    audio_manifest = _audio_manifest,
    colors_manifest = _colors_manifest,
    styles_manifest = _styles_manifest_normal,
    icons_manifest = _icons_manifest_normal,
    gui_manifest = _gui_manifest,
    slow_motion_manifest = _slow_motion_manifest,
    input_map = _input_map,
    surfacer_manifest = _surfacer_manifest,
}

var includes_leash := true

# ---


func _ready() -> void:
    assert(is_instance_valid(Sc) and \
            is_instance_valid(Su),
            "The Sc (Scaffolder) and Su (Surfacer) AutoLoads must be declared first.")
    
    Sc.logger.on_global_init(self, "App")
    Sc.register_framework_config(self)
    
    Sc.run(app_manifest)


func _amend_app_manifest(manifest: Dictionary) -> void:
    _override_configs_for_is_using_pixel_style(manifest)
    _override_configs_for_current_run(manifest)


func _override_configs_for_is_using_pixel_style(manifest: Dictionary) -> void:
    if _is_using_pixel_style:
        app_manifest.styles_manifest = _styles_manifest_pixel
        app_manifest.icons_manifest = _icons_manifest_pixel
    else:
        app_manifest.styles_manifest = _styles_manifest_normal
        app_manifest.icons_manifest = _icons_manifest_normal


func _set_up() -> void:
    Sc.profiler.preregister_metric_keys(_additional_metric_keys)


func _load_state() -> void:
    App.includes_leash = Sc.save_state.get_setting(
            INCLUDES_LEASH_SETTINGS_KEY,
            false)
