tool
class_name SpiderAnimator
extends SurfacerPlayerAnimator


var is_facing_down := true


func animation_name_to_sprite(animation_name: String) -> Sprite:
    match animation_name:
        "ClimbUp":
            return $ClimbUp as Sprite
        "ClimbDown":
            return $ClimbDown as Sprite
        "Rest":
            if is_facing_down:
                return $RestDown as Sprite
            else:
                return $RestUp as Sprite
        _:
            Sc.logger.error()
            return null


func animation_name_to_playback_rate(animation_name: String) -> float:
    match animation_name:
        "Rest":
            if is_facing_down:
                return animations["RestDown"].speed
            else:
                return animations["RestUp"].speed
        _:
            return animations[animation_name].speed
