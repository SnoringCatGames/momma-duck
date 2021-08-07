tool
class_name Porcupine
extends SurfacerPlayer
# This is a hazard that moves side-to-side along a surface.


const RUN_FROM_MOMMA_DISTANCE_THRESHOLD := 128.0

const RUN_FROM_MOMMA_DESTINATION_DISTANCE := 256.0

var move_back_and_forth_controller: MoveBackAndForthBehaviorController


func _ready() -> void:
    move_back_and_forth_controller = \
            get_behavior_controller("move_back_and_forth")


func _on_entered_proximity(
        target: Node2D,
        layer_names: Array) -> void:
    match layer_names[0]:
        "momma":
            _walk_away_from_momma()
        _:
            Sc.logger.error()


func _walk_away_from_momma() -> void:
    if start_surface == null:
        return
    
    show_exclamation_mark()
    
    var is_momma_to_the_left: bool = Sc.level.momma.position.x < position.x
    
    _log_player_event("Porcupine walk-away-from-momma start")
    
    move_back_and_forth_controller.trigger_move(
            !is_momma_to_the_left,
            RUN_FROM_MOMMA_DESTINATION_DISTANCE,
            PlayerBehaviorType.RUN_AWAY)


func on_touched_duckling(duckling: Duckling) -> void:
    if _is_destroyed or \
            !Sc.level_session.has_started:
        return
    
    _log_player_event("Porcupine collided with duckling")


func on_touched_momma(momma: Momma) -> void:
    if _is_destroyed or \
            !Sc.level_session.has_started:
        return
    
    _log_player_event("Porcupine collided with momma")
    
    _walk_away_from_momma()
