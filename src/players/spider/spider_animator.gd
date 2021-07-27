tool
class_name SpiderAnimator
extends PlayerAnimator


const DEFAULT_ANIMATION_NAMES := [
    "ClimbUp",
    "ClimbDown",
    "RestUp",
    "RestDown",
]

var is_facing_down := true


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
    match animation_name:
        "ClimbUp":
            return $ClimbUp
        "ClimbDown":
            return $ClimbDown
        "Rest":
            if is_facing_down:
                return $RestDown
            else:
                return $RestUp
        _:
            Sc.logger.error()
            return null


func animation_type_to_playback_rate(animation_name: String) -> float:
    match animation_name:
        "ClimbUp":
            return 1.0
        "ClimbDown":
            return 1.0
        "RestUp":
            return 1.0
        "RestDown":
            return 1.0
        _:
            Sc.logger.error("Unrecognized animation name: %s" % animation_name)
            return 0.0
