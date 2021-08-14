tool
class_name Porcupine
extends SurfacerPlayer
# This is a hazard that moves side-to-side along a surface.


var move_back_and_forth_controller: MoveBackAndForthBehavior
var run_away_controller: RunAwayBehavior


func _ready() -> void:
    if Engine.editor_hint:
        return
    move_back_and_forth_controller = \
            get_behavior(MoveBackAndForthBehavior)
    run_away_controller = get_behavior(RunAwayBehavior)
    run_away_controller.target_to_run_from = Sc.level.momma


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
    run_away_controller.trigger(true)


func on_touched_duckling(duckling: Duckling) -> void:
    _log_custom("Porcupine collided with duckling")


func on_touched_momma(momma: Momma) -> void:
    _log_custom("Porcupine collided with momma")
    _walk_away_from_momma()
