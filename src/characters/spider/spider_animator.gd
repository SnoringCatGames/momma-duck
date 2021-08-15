tool
class_name SpiderAnimator
extends ScaffolderCharacterAnimator


var is_facing_down := true


func _standand_animation_name_to_specific_animation_name(
        standard_name: String) -> String:
    if standard_name == "Rest":
        if is_facing_down:
            return "RestDown"
        else:
            return "RestUp"
    else:
        return standard_name
