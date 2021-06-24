tool
class_name MommaDuckLevel
extends SurfacerLevel


const DUCKLING_PATH := "res://src/players/duckling/duckling.tscn"
const RUN_AWAY_DUCKLING_PATH := \
        "res://src/players/run_away_duckling/run_away_duckling.tscn"
const FOX_PATH := "res://src/players/fox/fox.tscn"
const PORCUPINE_PATH := "res://src/players/porcupine/porcupine.tscn"
const SPIDER_PATH := "res://src/players/spider/spider.tscn"

const DUCKLING_SPAWN_POSITIONS_GROUP_NAME := "duckling_spawn_positions"
const FOX_SPAWN_POSITIONS_GROUP_NAME := "fox_spawn_positions"
const PORCUPINE_SPAWN_POSITIONS_GROUP_NAME := "porcupine_spawn_positions"
const SPIDER_SPAWN_POSITIONS_GROUP_NAME := "spider_spawn_positions"

const LEVEL_END_ZOOM_OUT_FACTOR := 2.0
const LEVEL_END_ZOOM_OUT_DURATION := 1.5

var duckling_spawn_positions := []
var fox_spawn_positions := []
var porcupine_spawn_positions := []
var spider_spawn_positions := []

var momma: Momma
# Array<Duckling>
var ducklings := []
# Array<RunAwayDuckling>
var run_away_ducklings := []
# Array<Fox>
var foxes := []
# Array<Porcupine>
var porcupines := []
# Array<Spider>
var spiders := []

var last_attached_duck: Duck


#func _enter_tree() -> void:
#    pass


#func _load() -> void:
#    ._load()


func _start() -> void:
    ._start()
    
    Gs.level_session.duckling_scare_count = 0
    
    momma = Surfacer.human_player
    last_attached_duck = momma
    
    duckling_spawn_positions = Gs.utils.get_all_nodes_in_group(
            DUCKLING_SPAWN_POSITIONS_GROUP_NAME)
    fox_spawn_positions = Gs.utils.get_all_nodes_in_group(
            FOX_SPAWN_POSITIONS_GROUP_NAME)
    porcupine_spawn_positions = Gs.utils.get_all_nodes_in_group(
            PORCUPINE_SPAWN_POSITIONS_GROUP_NAME)
    spider_spawn_positions = Gs.utils.get_all_nodes_in_group(
            SPIDER_SPAWN_POSITIONS_GROUP_NAME)
    
    for spawn_position in duckling_spawn_positions:
        var duckling: Duckling = add_player(
                DUCKLING_PATH,
                spawn_position.position,
                false)
        duckling.call_deferred("create_leash_annotator")
        ducklings.push_back(duckling)
    
    for spawn_position in fox_spawn_positions:
        var fox: Fox = add_player(
                FOX_PATH,
                spawn_position.position,
                false)
        foxes.push_back(fox)
    
    for spawn_position in porcupine_spawn_positions:
        var porcupine: Porcupine = add_player(
                PORCUPINE_PATH,
                spawn_position.position,
                false)
        porcupines.push_back(porcupine)
    
    for spawn_position in spider_spawn_positions:
        var spider: Spider = add_spider(spawn_position.position)
        spiders.push_back(spider)


#func _on_started() -> void:
#    ._on_started()


func _destroy() -> void:
    for duckling in ducklings:
        remove_player(duckling)
    ducklings.clear()
    
    for fox in foxes:
        remove_player(fox)
    foxes.clear()
    
    for spider in spiders:
        remove_spider(spider)
    spiders.clear()
    
    for porcupine in porcupines:
        remove_player(porcupine)
    porcupines.clear()
    
    if is_instance_valid(momma):
        remove_player(momma)
    
    ._destroy()


#func _on_initial_input() -> void:
#    ._on_initial_input()


#func quit(
#        has_finished: bool,
#        immediately: bool) -> void:
#    .quit(has_finished, immediately)


#func _on_intro_choreography_finished() -> void:
#    ._on_intro_choreography_finished()


func _physics_process(_delta: float) -> void:
    if !Gs.level_session.has_started or \
            Gs.level_session.is_destroyed or \
            !Gs.level_session.has_started:
        return
    
    momma.clear_just_changed_attachment()
    for duckling in ducklings:
        duckling.clear_just_changed_attachment()


func add_spider(position: Vector2) -> Spider:
    var player: Spider = Gs.utils.add_scene(
            self,
            SPIDER_PATH,
            false,
            true)
    player.position = position
    add_child(player)
    return player


func remove_spider(spider: Spider) -> void:
    spider._destroy()
    remove_child(spider)


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
    
    ducklings.erase(duckling)
    remove_player(duckling)
    
    var run_away_duckling: RunAwayDuckling = add_player(
            RUN_AWAY_DUCKLING_PATH,
            run_away_origin,
            false)
    run_away_ducklings.push_back(run_away_duckling)
    run_away_duckling.run_away(run_away_destination, enemy)


func swap_run_away_with_duckling(run_away_duckling: RunAwayDuckling) -> void:
    var position := run_away_duckling.position
    
    run_away_ducklings.erase(run_away_duckling)
    remove_player(run_away_duckling)
    
    var duckling: Duckling = add_player(
            DUCKLING_PATH,
            position,
            false)
    duckling.call_deferred("create_leash_annotator")
    ducklings.push_back(duckling)


func check_if_all_ducks_are_in_pond() -> void:
    if !momma.is_in_pond:
        return
    
    for duckling in ducklings:
        if !duckling.is_in_pond:
            return
    
    trigger_level_victory()


func trigger_level_victory() -> void:
    if !Gs.level_session.is_ended:
        Gs.time.tween_property(
                Gs.camera_controller,
                "zoom_factor",
                Gs.camera_controller.zoom_factor,
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
    if !Gs.level_session.has_started:
        return 0
    
    var count := 0
    var next_follower := momma.follower
    while is_instance_valid(next_follower):
        count += 1
        next_follower = next_follower.follower
    return count


func get_ducklings_count() -> int:
    return ducklings.size()
