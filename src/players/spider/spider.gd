tool
class_name Spider
extends KinematicBody2D
# This a hazard that moves up-and-down.


const EXCLAMATION_MARK_COLOR := Color("783628")
const EXCLAMATION_MARK_WIDTH_START := 4.0
const EXCLAMATION_MARK_LENGTH_START := 24.0
const EXCLAMATION_MARK_STROKE_WIDTH_START := 1.2
const EXCLAMATION_MARK_DURATION := 1.8

const RADIUS := 24.0

const EXCLAMATION_MARK_THROTTLE_INTERVAL := 1.0

const ANIMATOR_SCENE := \
        preload("res://src/players/spider/spider_animator.tscn")

export var range_y := 196.0
export var speed := 50.0
export var pause_at_end_duration := 3.0

var animator: SpiderAnimator

var start_position: Vector2
var is_moving := true
var is_moving_down := true
var just_reached_end := false
var just_started_moving := false
var reached_end_time := -pause_at_end_duration

var is_logging_events := false

var _is_destroyed := false

var _throttled_exclamation_mark: FuncRef = Sc.time.throttle(
        funcref(self, "_show_exclamation_mark"),
        EXCLAMATION_MARK_THROTTLE_INTERVAL)


func _ready() -> void:
    start_position = position
    position.y += randf() * range_y * 0.9 - range_y / 2.0
    is_moving_down = randf() > 0.5
    animator = $SpiderAnimator
    animator.set_up(_create_animator_params(), true)


func _destroy() -> void:
    _is_destroyed = true
    queue_free()


func _physics_process(delta: float) -> void:
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
            is_moving = false
            reached_end_time = current_time
    else:
        if current_time > reached_end_time + pause_at_end_duration:
            is_moving = true
            just_started_moving = true
            is_moving_down = !is_moving_down
    
    if is_logging_events:
        if just_reached_end:
            Sc.logger.print("Spider just reached end")
        if just_started_moving:
            Sc.logger.print("Spider just started moving")
    
    _update_animator()


func _climb_away_from_momma() -> void:
    var is_momma_below: bool = Sc.level.momma.position.y > position.y
    
    _throttled_exclamation_mark.call_func()
    
    if is_moving and \
            is_moving_down != is_momma_below:
        # Already moving away.
        return
    
    if is_logging_events:
        Sc.logger.print("Spider climb-away-from-momma start")
    
    is_moving = true
    just_started_moving = true
    is_moving_down = !is_momma_below
    
    _update_animator()


func _update_animator() -> void:
    animator.is_facing_down = is_moving_down
    
    if just_started_moving:
        if is_moving_down:
            animator.play(PlayerAnimationType.CLIMB_DOWN)
        else:
            animator.play(PlayerAnimationType.CLIMB_UP)
    elif just_reached_end:
        animator.play(PlayerAnimationType.REST)


func _create_animator_params() -> PlayerAnimatorParams:
    var animator_params := PlayerAnimatorParams.new()
    
    animator_params.player_animator_path_or_scene = ANIMATOR_SCENE
    
    animator_params.faces_right_by_default = true
    
    animator_params.rest_name = "Rest"
    animator_params.climb_up_name = "ClimbUp"
    animator_params.climb_down_name = "ClimbDown"

    animator_params.rest_playback_rate = 1.0
    animator_params.climb_up_playback_rate = 1.0
    animator_params.climb_down_playback_rate = 1.0
    
    return animator_params


func on_touched_duckling(duckling: Duckling) -> void:
    if _is_destroyed or \
            !Sc.level_session.has_started:
        return
    
    if is_logging_events:
        Sc.logger.print("Spider collided with duckling")


func on_touched_momma(momma: Momma) -> void:
    if _is_destroyed or \
            !Sc.level_session.has_started:
        return
    
    if is_logging_events:
        Sc.logger.print("Spider collided with momma")
    
    _climb_away_from_momma()


func _show_exclamation_mark() -> void:
    Su.annotators.add_transient(ExclamationMarkAnnotator.new(
            self,
            RADIUS,
            EXCLAMATION_MARK_COLOR,
            EXCLAMATION_MARK_WIDTH_START,
            EXCLAMATION_MARK_LENGTH_START,
            EXCLAMATION_MARK_STROKE_WIDTH_START,
            EXCLAMATION_MARK_DURATION))
