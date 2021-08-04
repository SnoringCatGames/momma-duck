tool
class_name Porcupine
extends MoveBackAndForthPlayer
# This is a hazard that moves side-to-side along a surface.


const RUN_FROM_MOMMA_DISTANCE_THRESHOLD := 128.0

const RUN_FROM_MOMMA_DESTINATION_DISTANCE := 256.0

const EXCLAMATION_MARK_COLOR := Color("262626")
const EXCLAMATION_MARK_WIDTH_START := 4.0
const EXCLAMATION_MARK_LENGTH_START := 24.0
const EXCLAMATION_MARK_STROKE_WIDTH_START := 1.2
const EXCLAMATION_MARK_DURATION := 1.8

const EXCLAMATION_MARK_THROTTLE_INTERVAL := 1.0

var _throttled_exclamation_mark: FuncRef = Sc.time.throttle(
        funcref(self, "_show_exclamation_mark"),
        EXCLAMATION_MARK_THROTTLE_INTERVAL)


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
    
    _throttled_exclamation_mark.call_func()
    
    var is_momma_to_the_left: bool = Sc.level.momma.position.x < position.x
    
    _print("Porcupine walk-away-from-momma start")
    
    _trigger_move(!is_momma_to_the_left, RUN_FROM_MOMMA_DESTINATION_DISTANCE)


func on_touched_duckling(duckling: Duckling) -> void:
    if _is_destroyed or \
            !Sc.level_session.has_started:
        return
    
    _print("Porcupine collided with duckling")


func on_touched_momma(momma: Momma) -> void:
    if _is_destroyed or \
            !Sc.level_session.has_started:
        return
    
    _print("Porcupine collided with momma")
    
    _walk_away_from_momma()


func _show_exclamation_mark() -> void:
    Su.annotators.add_transient(ExclamationMarkAnnotator.new(
            self,
            movement_params.collider_half_width_height.y,
            EXCLAMATION_MARK_COLOR,
            EXCLAMATION_MARK_WIDTH_START,
            EXCLAMATION_MARK_LENGTH_START,
            EXCLAMATION_MARK_STROKE_WIDTH_START,
            EXCLAMATION_MARK_DURATION))
