class_name PorcupineParams
extends MovementParams


const PLAYER_SCENE := \
        preload("res://src/players/porcupine/porcupine.tscn")
const ANIMATOR_SCENE := \
        preload("res://src/players/porcupine/porcupine_animator.tscn")


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
