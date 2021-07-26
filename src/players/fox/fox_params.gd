class_name FoxParams
extends MovementParams


const PLAYER_SCENE := \
        preload("res://src/players/fox/fox.tscn")
const ANIMATOR_SCENE := \
        preload("res://src/players/fox/fox_animator.tscn")


# FIXME: ---------------- Pull these out into the in-scene MovementParams node.
func _init_params() -> void:
    
    minimizes_velocity_change_when_jumping = false
    optimizes_edge_jump_positions_at_run_time = true
    optimizes_edge_land_positions_at_run_time = true
    also_optimizes_preselection_path = true
    forces_player_position_to_match_edge_at_start = true
    forces_player_velocity_to_match_edge_at_start = true
    forces_player_position_to_match_path_at_end = false
    forces_player_velocity_to_zero_at_path_end = false
    syncs_player_position_to_edge_trajectory = true
    syncs_player_velocity_to_edge_trajectory = true
    includes_discrete_trajectory_state = true
    includes_continuous_trajectory_positions = true
    includes_continuous_trajectory_velocities = true
    is_trajectory_state_stored_at_build_time = false
    bypasses_runtime_physics = false
    
    retries_navigation_when_interrupted = true
    distance_squared_threshold_for_considering_additional_jump_land_points = 32.0 * 32.0
    stops_after_finding_first_valid_edge_for_a_surface_pair = false
    calculates_all_valid_edges_for_a_surface_pair = false
    always_includes_jump_land_positions_at_surface_ends = false
    includes_redundant_jump_land_positions_with_zero_start_velocity = true
    normal_jump_instruction_duration_increase = 0.08
    exceptional_jump_instruction_duration_increase = 0.2
    recurses_when_colliding_during_horizontal_step_calculations = true
    backtracks_to_consider_higher_jumps_during_horizontal_step_calculations = true
    collision_margin_for_edge_calculations = 4.0
    collision_margin_for_waypoint_positions = 5.0
    skips_less_likely_jump_land_positions = false
    prevents_path_end_points_from_protruding_past_surface_ends_with_extra_offsets = true
    reuses_previous_waypoints_when_backtracking_on_jump_height = false
    asserts_no_preexisting_collisions_during_edge_calculations = false
    checks_for_alternate_intersection_points_for_very_oblique_collisions = true
    oblique_collison_normal_aspect_ratio_threshold_threshold = 10.0
    min_valid_frame_count_when_colliding_early_with_expected_surface = 4
    reached_in_air_destination_distance_squared_threshold = 16.0 * 16.0
    max_edges_to_remove_from_end_of_path_for_optimization_to_in_air_destination = 2


func _init_animator_params() -> void:
    animator_params = PlayerAnimatorParams.new()
    
    animator_params.player_animator_path_or_scene = ANIMATOR_SCENE
    
    animator_params.faces_right_by_default = false
    
    animator_params.rest_name = "Rest"
    animator_params.rest_on_wall_name = "RestOnWall"
    animator_params.jump_rise_name = "JumpRise"
    animator_params.jump_fall_name = "JumpFall"
    animator_params.walk_name = "Walk"
    animator_params.climb_up_name = "ClimbUp"
    animator_params.climb_down_name = "ClimbDown"

    animator_params.rest_playback_rate = 0.8
    animator_params.rest_on_wall_playback_rate = 0.8
    animator_params.jump_rise_playback_rate = 1.0
    animator_params.jump_fall_playback_rate = 1.0
    animator_params.walk_playback_rate = 20.0
    animator_params.climb_up_playback_rate = 9.4
    animator_params.climb_down_playback_rate = \
            -animator_params.climb_up_playback_rate / 2.33
