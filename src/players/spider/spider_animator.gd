tool
class_name SpiderAnimator
extends PlayerAnimator


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
