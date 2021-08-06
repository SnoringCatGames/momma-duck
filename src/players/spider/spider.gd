tool
class_name Spider
extends ScaffolderPlayer
# This a hazard that moves up-and-down.


export var range_y := 196.0
export var speed := 50.0
export var pause_at_end_duration := 3.0

var is_moving := true
var is_moving_down := true
var just_reached_end := false
var just_started_moving := false
var reached_end_time := -pause_at_end_duration


func _ready() -> void:
    behavior = PlayerBehaviorType.CUSTOM
    position.y += randf() * range_y * 0.9 - range_y / 2.0
    is_moving_down = randf() > 0.5


func _on_physics_process(delta: float) -> void:
    var current_time := Sc.time.get_scaled_play_time()
    
    just_reached_end = false
    just_started_moving = false
    
    # Update position.
    if is_moving:
        var displacement := Vector2(
                0.0, 
                speed * delta * Sc.time.get_combined_scale())
        if !is_moving_down:
            displacement *= -1
        position += displacement
    
    # Check for mode change.
    if is_moving:
        if is_moving_down:
            if position.y >= start_position.y + range_y / 2.0:
                just_reached_end = true
        else:
            if position.y <= start_position.y - range_y / 2.0:
                just_reached_end = true

        if just_reached_end:
            behavior = PlayerBehaviorType.REST
            is_moving = false
            reached_end_time = current_time
    else:
        if current_time > reached_end_time + pause_at_end_duration:
            behavior = PlayerBehaviorType.CUSTOM
            is_moving = true
            just_started_moving = true
            is_moving_down = !is_moving_down
    
    if just_reached_end:
        _log_player_event("Spider just reached end")
    if just_started_moving:
        _log_player_event("Spider just started moving")
    
    _process_animation()


func _climb_away_from_momma() -> void:
    var is_momma_below: bool = Sc.level.momma.position.y > position.y
    
    show_exclamation_mark()
    
    if is_moving and \
            is_moving_down != is_momma_below:
        # Already moving away.
        return
    
    _log_player_event("Spider climb-away-from-momma start")
    
    behavior = PlayerBehaviorType.RUN_AWAY
    is_moving = true
    just_started_moving = true
    is_moving_down = !is_momma_below
    
    _process_animation()


func _process_animation() -> void:
    animator.is_facing_down = is_moving_down
    
    if just_started_moving:
        if is_moving_down:
            animator.play("ClimbDown")
        else:
            animator.play("ClimbUp")
    elif just_reached_end:
        animator.play("Rest")


func on_touched_duckling(duckling: Duckling) -> void:
    if _is_destroyed or \
            !Sc.level_session.has_started:
        return
    
    _log_player_event("Spider collided with duckling")


func on_touched_momma(momma: Momma) -> void:
    if _is_destroyed or \
            !Sc.level_session.has_started:
        return
    
    _log_player_event("Spider collided with momma")
    
    _climb_away_from_momma()
