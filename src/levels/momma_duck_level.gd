tool
class_name MommaDuckLevel
extends SurfacerLevel


const SPIDER_CHARACTER_SCENE := \
        preload("res://src/characters/spider/spider.tscn")

const LEVEL_END_ZOOM_OUT_FACTOR := 2.0
const LEVEL_END_ZOOM_OUT_DURATION := 1.5

var momma: Momma

var last_attached_duck: Duck


#func _load() -> void:
#    ._load()


func _start() -> void:
    ._start()
    
    Sc.level_session.duckling_scare_count = 0


#func _on_started() -> void:
#    ._on_started()


func _add_human_character() -> void:
    ._add_human_character()
    momma = Sc.level.human_character
    last_attached_duck = momma


func _add_npcs() -> void:
    ._add_npcs()
    for duckling in characters["duckling"]:
        duckling.call_deferred("create_leash_annotator")


func _destroy() -> void:
    ._destroy()
    momma = null
    last_attached_duck = null


#func _on_initial_input() -> void:
#    ._on_initial_input()


#func quit(
#        has_finished: bool,
#        immediately: bool) -> void:
#    .quit(has_finished, immediately)


#func _update_editor_configuration() -> void
#    ._update_editor_configuration()


#func _on_intro_choreography_finished() -> void:
#    ._on_intro_choreography_finished()


func _physics_process(_delta: float) -> void:
    if Engine.editor_hint:
        return
    
    if !Sc.level_session.has_started or \
            Sc.level_session.is_destroyed or \
            !Sc.level_session.has_started:
        return
    
    momma.clear_just_changed_attachment()
    for duckling in characters["duckling"]:
        duckling.clear_just_changed_attachment()


func swap_duckling_with_run_away(
        duckling: Duckling,
        enemy: KinematicBody2D) -> void:
    assert(duckling.start_surface != null)
    
    var run_away_origin := duckling.position
    var run_away_destination := PositionAlongSurfaceFactory. \
            create_position_offset_from_target_point(
                    duckling.start_position,
                    duckling.start_surface,
                    duckling.movement_params.collider_half_width_height,
                    true)
    
    remove_character(duckling)
    
    var run_away_duckling: RunAwayDuckling = add_character(
            "run_away_duckling",
            run_away_origin,
            false)
    run_away_duckling.run_away(run_away_destination, enemy)


func swap_run_away_with_duckling(run_away_duckling: RunAwayDuckling) -> void:
    if run_away_duckling._is_destroyed:
        return
    
    var position := run_away_duckling.position
    
    remove_character(run_away_duckling)
    
    var duckling: Duckling = add_character(
            "duckling",
            position,
            false)
    duckling.call_deferred("create_leash_annotator")


func check_if_all_ducks_are_in_pond() -> void:
    if !momma.is_in_pond:
        return
    
    if characters.has("run_away_ducklings") and \
            !characters["run_away_ducklings"].empty():
        return
    
    for duckling in characters["duckling"]:
        if !duckling.is_in_pond:
            return
    
    trigger_level_victory()


func trigger_level_victory() -> void:
    if !Sc.level_session.is_ended:
        Sc.time.tween_property(
                Sc.camera_controller,
                "zoom_factor",
                Sc.camera_controller.zoom_factor,
                LEVEL_END_ZOOM_OUT_FACTOR,
                LEVEL_END_ZOOM_OUT_DURATION,
                "ease_in_out",
                0.0,
                TimeType.PLAY_PHYSICS_SCALED)
        quit(true, false)


func get_music_name() -> String:
    return "momma_music"


func get_slow_motion_music_name() -> String:
    # FIXME: Add slo-mo music
    return ""


func get_ducklings_in_tow_count() -> int:
    if !Sc.level_session.has_started:
        return 0
    
    var count := 0
    var next_follower := momma.follower
    while is_instance_valid(next_follower):
        count += 1
        next_follower = next_follower.follower
    return count


func get_ducklings_count() -> int:
    return characters["duckling"].size() + \
            (characters["run_away_duckling"].size() if \
            characters.has("run_away_duckling") else \
            0)
