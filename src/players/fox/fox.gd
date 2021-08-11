tool
class_name Fox
extends SurfacerPlayer
# This is a hazard that jumps at nearby ducklings, if momma isn't nearby.


const RUN_FROM_MOMMA_DISTANCE_THRESHOLD := 128.0
const RUN_FROM_MOMMA_DISTANCE_SQUARED_THRESHOLD := \
        RUN_FROM_MOMMA_DISTANCE_THRESHOLD * RUN_FROM_MOMMA_DISTANCE_THRESHOLD

const RUN_FROM_MOMMA_DESTINATION_DISTANCE := 256.0

export var wander_radius := 256.0
export var wander_pause_duration := 4.0

var is_running_from_momma := false
var is_pouncing_on_duckling := false
var is_wandering := false
var last_navigation_end_time := 0
var target_duckling: Duckling

var wander_controller: WanderBehaviorController
var collide_controller: CollideBehaviorController
var run_away_controller: RunAwayBehaviorController
var return_controller: ReturnBehaviorController


func _ready() -> void:
    wander_controller = get_behavior_controller(WanderBehaviorController)
    collide_controller = get_behavior_controller(CollideBehaviorController)
    run_away_controller = get_behavior_controller(RunAwayBehaviorController)
    return_controller = get_behavior_controller(ReturnBehaviorController)


func _update_navigator(delta_scaled: float) -> void:
    ._update_navigator(delta_scaled)
    
    if start_surface == null:
        return
    
    if is_pouncing_on_duckling:
        assert(target_duckling != null)
        if navigation_state.just_reached_end_of_edge and \
                surface_state.just_left_air:
            # -   We are currently navigating, and we just landed on a new
            #     surface.
            # -   Update the navigation to point to the current leader
            #     position.
            _pounce_on_duckling(target_duckling)
    elif navigation_state.has_reached_destination:
        _trigger_rest()
    
    if !navigation_state.is_currently_navigating and \
            Sc.time.get_scaled_play_time() >= \
            last_navigation_end_time + wander_pause_duration:
        _trigger_wander()


func _run_from_momma() -> void:
    if is_running_from_momma:
        if !navigation_state.is_currently_navigating or \
                navigation_state.just_reached_end_of_edge and \
                surface_state.just_left_air:
            _navigate_to_new_position_away_from_momma()
    else:
        _navigate_to_new_position_away_from_momma()
    
    behavior = PlayerBehaviorType.RUN_AWAY
    is_running_from_momma = true
    is_pouncing_on_duckling = false
    target_duckling = null


func _navigate_to_new_position_away_from_momma() -> void:
    _log_player_event("Fox run-from-momma start")
    run_away_controller.trigger(true)


func _trigger_wander() -> void:
    if start_surface == null:
        return
    
    _log_player_event("Fox wander start")
    
    is_wandering = true
    behavior = PlayerBehaviorType.CUSTOM
    
    wander_controller.trigger(false)


func _trigger_rest() -> void:
    is_running_from_momma = false
    is_pouncing_on_duckling = false
    is_wandering = false
    target_duckling = null
    behavior = PlayerBehaviorType.REST
    last_navigation_end_time = Sc.time.get_scaled_play_time()
    navigator.stop()


func _process_sounds() -> void:
    if just_triggered_jump:
        Sc.audio.play_sound("duck_jump")
    
    if surface_state.just_left_air:
        Sc.audio.play_sound("duck_land")


func _on_entered_proximity(
        target: Node2D,
        layer_names: Array) -> void:
    match layer_names[0]:
        "duckling":
            _on_duckling_entered_proximity(target)
        "momma":
            _run_from_momma()
        _:
            Sc.logger.error()


func _on_duckling_entered_proximity(duckling: Duckling) -> void:
    _log_player_event("Fox is close to duckling")
    
    if is_running_from_momma or \
            is_pouncing_on_duckling:
        return
    
    var fox_distance_squared_to_momma := \
            self.position.distance_squared_to(Sc.level.momma.position)
    if fox_distance_squared_to_momma <= \
            RUN_FROM_MOMMA_DISTANCE_SQUARED_THRESHOLD:
        return
    
    var duckling_distance_squared_to_momma := \
            duckling.position.distance_squared_to(Sc.level.momma.position)
    if duckling_distance_squared_to_momma <= \
            RUN_FROM_MOMMA_DISTANCE_SQUARED_THRESHOLD:
        return
    
    _pounce_on_duckling(duckling)


func _pounce_on_duckling(duckling: Duckling) -> void:
    _log_player_event("Fox pounce-on-duckling start")
    
    show_exclamation_mark()
    
    behavior = PlayerBehaviorType.COLLIDE
    is_pouncing_on_duckling = true
    target_duckling = duckling
    
    run_away_controller.trigger(false)


func on_touched_duckling(duckling: Duckling) -> void:
    _log_player_event("Fox collided with duckling")
    
    if is_pouncing_on_duckling and \
            duckling == target_duckling:
        _trigger_rest()
        duckling.on_touched_enemy(self)
        collide_controller.on_collided()


func on_touched_momma(momma: Momma) -> void:
    _log_player_event("Fox collided with momma")
    _run_from_momma()
