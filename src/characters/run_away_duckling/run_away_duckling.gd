tool
class_name RunAwayDuckling
extends SurfacerCharacter


var destination: PositionAlongSurface


func run_away(
        destination: PositionAlongSurface,
        enemy: KinematicBody2D) -> void:
    self.destination = destination
    
    # The newly-created surface-state thinks we're in-air anyway, so let's make
    # it a little more real.
    self.set_position(position + Vector2(0.0, -0.1))
    
    # Give the run-away an initial jump away from the enemy.
    velocity.y = movement_params.jump_boost
    velocity.x = movement_params.max_horizontal_speed_default * 0.5
    var is_left_of_enemy := position.x < enemy.position.x
    if is_left_of_enemy:
        velocity.x *= -1
    
    navigator.connect("destination_reached", self, "_on_destination_reached")
    var did_navigation_succeed := navigator.navigate_to_position(destination)
    if !did_navigation_succeed:
        Sc.logger.warning("Run-away navigation path-finding was not successful")
        Sc.level.swap_run_away_with_duckling(self)
    
    show_exclamation_mark()


func _on_destination_reached() -> void:
    _log_custom("Run-away reached spawn position")
    Sc.level.swap_run_away_with_duckling(self)


func _process_sounds() -> void:
    if just_triggered_jump:
        Sc.audio.play_sound("duck_jump")
    
    if surface_state.just_left_air:
        Sc.audio.play_sound("duck_land")
