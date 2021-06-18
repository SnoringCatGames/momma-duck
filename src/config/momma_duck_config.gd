class_name MommaDuckConfig
extends Node


# ---

# This method is useful for defining parameters that are likely to change
# between builds or between development and production environments.
func _override_configs_for_current_run(manifest: Dictionary) -> void:
    # TODO: Remember to reset these when creating releases.
    
    var is_debug := true and OS.is_debug_build()
    var is_playtest := false
    
#    var debug_window_size = ScaffolderGuiConfig.SCREEN_RESOLUTIONS.default
    var debug_window_size = ScaffolderGuiConfig.SCREEN_RESOLUTIONS.full_screen
    
    _app_metadata.app_version = "0.0.1"
    
    _app_metadata.debug = is_debug
    _app_metadata.playtest = is_playtest
    _app_metadata.pauses_on_focus_out = !is_debug
    _app_metadata.also_prints_to_stdout = true
    _app_metadata.are_all_levels_unlocked = true and is_debug
    _app_metadata.is_splash_skipped = false and is_debug
    
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

var _uses_threads := false and OS.can_use_threads()

var _app_metadata := {
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
    log_gestures_url = \
            "https://storage.googleapis.com/upload/storage/v1/b/momma-duck-logs/o",
    app_id_query_param = "momma-duck",
    
    app_logo = preload("res://assets/images/logo.png"),
    app_logo_scale = 2.0,
    go_icon = preload("res://assets/images/go_icon.png"),
    go_icon_scale = 1.5,
    developer_name = "Snoring Cat LLC",
    developer_url = "https://snoringcat.games",
    
    developer_logo = preload( \
            "res://addons/scaffolder/assets/images/gui/snoring_cat_logo_about.png"),
    developer_splash = preload( \
            "res://addons/scaffolder/assets/images/gui/snoring_cat_logo_splash.png"),
    
    godot_splash_screen_duration = 1.4,
    developer_splash_screen_duration = 1.0,
}

var _fonts := {
    main_xs = preload( \
            "res://addons/scaffolder/assets/fonts/main_font_xs.tres"),
    main_xs_italic = preload( \
            "res://addons/scaffolder/assets/fonts/main_font_xs_italic.tres"),
    main_s = preload( \
            "res://addons/scaffolder/assets/fonts/main_font_s.tres"),
    main_m = preload( \
            "res://addons/scaffolder/assets/fonts/main_font_m.tres"),
    main_m_bold = preload( \
            "res://addons/scaffolder/assets/fonts/main_font_m_bold.tres"),
    main_m_italic = preload( \
            "res://addons/scaffolder/assets/fonts/main_font_m_italic.tres"),
    main_l = preload( \
            "res://addons/scaffolder/assets/fonts/main_font_l.tres"),
    main_xl = preload( \
            "res://addons/scaffolder/assets/fonts/main_font_xl.tres"),
    
    header_s = preload( \
            "res://addons/scaffolder/assets/fonts/header_font_s.tres"),
    header_m = preload( \
            "res://addons/scaffolder/assets/fonts/header_font_m.tres"),
    header_l = preload( \
            "res://addons/scaffolder/assets/fonts/header_font_l.tres"),
    header_xl = preload( \
            "res://addons/scaffolder/assets/fonts/header_font_xl.tres"),
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
    level_end_sound = "momma_cadence",
    
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

var _colors_manifest := {
    # Scaffolder colors.
    
    # Should match Project Settings > Application > Boot Splash > Bg Color.
    # Should match
    #     Project Settings > Rendering > Environment > Default Clear Color.
    background = Color("2f4034"),
    font = Color("eeeeee"),
    header_font = Color("fff12e"),
    button = Color("24803b"),
    shiny_button_highlight = Color("98cc70"),
    button_disabled_hsv_delta = {h=0.0, s=-0.4, v=0.15, a=-0.2},
    button_focused_hsv_delta = {h=-0.03, s=-0.15, v=0.15},
    button_hover_hsv_delta = {h=-0.03, s=-0.15, v=0.15},
    button_pressed_hsv_delta = {h=0.05, s=-0.05, v=-0.1},
    dropdown = Color("2f4034"),
    tooltip = Color("080808"),
    tooltip_bg = Color("bbbbbb"),
    dropdown_disabled_hsv_delta = {h=0.0, s=-0.4, v=0.15, a=-0.2},
    dropdown_focused_hsv_delta = {h=0.05, s=-0.15, v=0.15},
    dropdown_hover_hsv_delta = {h=0.05, s=-0.15, v=0.15},
    dropdown_pressed_hsv_delta = {h=-0.05, s=-0.05, v=-0.1},
    popup_background_hsv_delta = {h=0.0, s=-0.05, v=0.05},
    scroll_bar_background_hsv_delta = {h=0.0, s=-0.2, v=-0.1},
    scroll_bar_grabber_normal_hsv_delta = {h=0.05, s=-0.2, v=-0.1},
    scroll_bar_grabber_hover_hsv_delta = {h=0.0, s=0.15, v=0.2},
    scroll_bar_grabber_pressed_hsv_delta = {h=0.08, s=-0.15, v=-0.1},
    zebra_stripe_even_row_hsv_delta = {h=0.01, s=-0.05, v=0.05},
    
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

var _styles_manifest := {
    button_corner_radius = 4,
    button_corner_detail = 3,
    button_shadow_size = 3,
    
    dropdown_corner_radius = 4,
    dropdown_corner_detail = 3,
    
    scroll_corner_radius = 6,
    scroll_corner_detail = 3,
    # Width of the scrollbar.
    scroll_content_margin = 7,
    
    scroll_grabber_corner_radius = 8,
    scroll_grabber_corner_detail = 3,
}

var _settings_item_manifest := {
    groups = {
        main = {
            label = "",
            is_collapsible = false,
            item_classes = [
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
                DebugPanelSettingsLabeledControlItem,
            ],
        },
        miscellaneous = {
            label = "Miscellaneous",
            is_collapsible = true,
            item_classes = [
                WelcomePanelSettingsLabeledControlItem,
                IntroChoreographySettingsLabeledControlItem,
                InspectorEnabledSettingsLabeledControlItem,
                TimeScaleSettingsLabeledControlItem,
                MetronomeSettingsLabeledControlItem,
                LogSurfacerEventsSettingsLabeledControlItem,
            ],
        },
    },
}

var _hud_manifest := {
    hud_class = MommaDuckHud,
    hud_key_value_box_size = \
            ScaffolderGuiConfig.HUD_KEY_VALUE_BOX_DEFAULT_SIZE,
    hud_key_value_box_nine_patch_rect_path = \
            ScaffolderGuiConfig.DEFAULT_HUD_KEY_VALUE_BOX_NINE_PATCH_RECT_PATH,
    hud_key_value_list_item_manifest = [
        {
            item_class = TimeLabeledControlItem,
            settings_enablement_label = "Time",
            enabled = true,
        },
        {
            item_class = FollowersCountLabeledControlItem,
            settings_enablement_label = "Ducklings in tow",
            enabled = true,
        },
    ],
    is_inspector_enabled_default = false,
    inspector_panel_starts_open = false,
}

var _welcome_panel_items := [
    HeaderLabeledControlItem.new("Lead your ducklings to the pond"),
    StaticTextLabeledControlItem.new("*Auto nav*", "click"),
    StaticTextLabeledControlItem.new("Walk/Climb", "arrow key / wasd"),
    StaticTextLabeledControlItem.new("Jump", "space / x"),
]

var _gui_manifest := {
    debug_window_size = ScaffolderGuiConfig.SCREEN_RESOLUTIONS.full_screen,
    
    cell_size = Vector2(32.0, 32.0),
    
    # Should match Project Settings > Display > Window > Size > Width/Height
    default_game_area_size = Vector2(1024, 768),
    aspect_ratio_max = 2.0 / 1.0,
    aspect_ratio_min = 1.0 / 2.0,
    camera_smoothing_speed = 10.0,
    default_camera_zoom = 0.4,
    
    is_data_deletion_button_shown = true,
    
    third_party_license_text = \
            ScaffolderThirdPartyLicenses.TEXT + \
            SurfacerThirdPartyLicenses.TEXT + \
            ThirdPartyLicenses.TEXT,
    special_thanks_text = """
""",
    
    main_menu_image_scene_path = "res://src/gui/loading_image.tscn",
    loading_image_scene_path = "res://src/gui/loading_image.tscn",
    welcome_panel_path = ScaffolderGuiConfig.WELCOME_PANEL_PATH,
    
    fade_in_transition_texture = \
            preload("res://addons/scaffolder/assets/images/transition_in.png"),
    fade_out_transition_texture = \
            preload("res://addons/scaffolder/assets/images/transition_out.png"),
    
    theme = preload("res://src/config/default_theme.tres"),
    
    fonts = _fonts,
    settings_item_manifest = _settings_item_manifest,
    hud_manifest = _hud_manifest,
    welcome_panel_items = _welcome_panel_items,
    
    screen_path_exclusions = [
        "res://addons/scaffolder/src/gui/screens/rate_app_screen.tscn",
    ],
    screen_path_inclusions = [
    ],
    pause_item_class_exclusions = [],
    pause_item_class_inclusions = [
        FastestTimeLabeledControlItem,
        FollowersCountLabeledControlItem,
        ScareCountLabeledControlItem,
    ],
    game_over_item_class_exclusions = [],
    game_over_item_class_inclusions = [
        FastestTimeLabeledControlItem,
    ],
    level_select_item_class_exclusions = [],
    level_select_item_class_inclusions = [
        FastestTimeLabeledControlItem,
    ],
}

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
    nav_selection_slow_mo_time_scale = 1.0,
    nav_selection_slow_mo_tick_tock_tempo_multiplier = 1,
    nav_selection_slow_mo_saturation = 0.5,
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
    player_action_classes = SurfacerConfig.DEFAULT_PLAYER_ACTION_CLASSES,
    edge_movement_classes = SurfacerConfig.DEFAULT_EDGE_MOVEMENT_CLASSES,
    player_param_classes = _player_param_classes,
}

var app_manifest := {
    colors_class = SurfacerColors,
    draw_utils_class = SurfacerDrawUtils,
    level_config_class = MommaDuckLevelConfig,
    
    app_metadata = _app_metadata,
    audio_manifest = _audio_manifest,
    colors_manifest = _colors_manifest,
    styles_manifest = _styles_manifest,
    gui_manifest = _gui_manifest,
    surfacer_manifest = _surfacer_manifest,
}


func _ready() -> void:
    Gs.logger.print("MommaDuckConfig._ready")


func amend_app_manifest(manifest: Dictionary) -> void:
    _override_configs_for_current_run(manifest)


func initialize() -> void:
    Gs.profiler.preregister_metric_keys(_additional_metric_keys)
