tool
class_name Momma
extends Duck


func _update_attachment() -> void:
    is_attached_to_leader = true
    leader = self


func get_leash_attachment_offset() -> Vector2:
    if is_in_pond:
        return Vector2(18.0, 11.0)
    elif !surface_state.is_grabbing_a_surface:
        return Vector2(15.0, 5.0)
    else:
        return Vector2(18.0, -1.0)


func _process_sounds() -> void:
    if just_triggered_jump:
        Sc.audio.play_sound("duck_jump")
    
    if surface_state.just_left_air:
        Sc.audio.play_sound("duck_land")


func on_defended_duckling(
        duckling: Duckling,
        enemy: KinematicBody2D) -> void:
    _quack()


func on_touched_enemy(enemy: KinematicBody2D) -> void:
    _quack()
