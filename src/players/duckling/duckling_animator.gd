tool
class_name DucklingAnimator
extends PlayerAnimator


const DEFAULT_ANIMATION_NAMES := [
    "Walk",
    "Rest",
    "JumpFall",
    "JumpRise",
    "Swim",
]


func set_static_frame(animation_state: PlayerAnimationState) -> void:
    _show_sprite(animation_state.animation_name)
    .set_static_frame(animation_state)


func _play_animation(
        animation_name: String,
        blend := 0.1) -> bool:
    _show_sprite(animation_name)
    return ._play_animation(animation_name, blend)


func _show_sprite(animation_name: String) -> void:
    # Hide the other sprites.
    for sprite_name in DEFAULT_ANIMATION_NAMES:
        var sprite := animation_name_to_sprite(sprite_name)
        sprite.visible = false
    
    # Show the current sprite.
    var sprite := animation_name_to_sprite(animation_name)
    sprite.visible = true


func animation_name_to_sprite(name: String) -> Sprite:
    return get_node(name) as Sprite


func animation_type_to_playback_rate(animation_name: String) -> float:
    match animation_name:
        "Rest":
            return 0.8
        "JumpRise":
            return 1.0
        "JumpFall":
            return 1.0
        "Walk":
            return 20.0
        "Swim":
            return 1.0
        _:
            Sc.logger.error("Unrecognized animation name: %s" % animation_name)
            return 0.0
