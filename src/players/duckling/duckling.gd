tool
class_name Duckling
extends Duck


var leash_annotator: LeashAnnotator

var wander_behavior: WanderBehavior
var follow_behavior: FollowBehavior


func _ready() -> void:
    if Engine.editor_hint:
        return
    wander_behavior = get_behavior(WanderBehavior)
    follow_behavior = get_behavior(FollowBehavior)
    follow_behavior.connect(
            "deactivated", self, "_on_follow_behavior_deactivated")


func create_leash_annotator() -> void:
    leash_annotator = LeashAnnotator.new(self)
    Sc.annotators.get_player_annotator(self).add_child(leash_annotator)


func get_leash_attachment_offset() -> Vector2:
    if is_in_pond:
        return Vector2(4.0, 5.0)
    elif !surface_state.is_grabbing_a_surface:
        return Vector2(3.0, 3.0)
    else:
        return Vector2(3.0, 2.0)


func _destroy() -> void:
    if is_instance_valid(leash_annotator):
        leash_annotator.queue_free()
    ._destroy()


#func _update_navigator(delta_scaled: float) -> void:
#    ._update_navigator(delta_scaled)


func _process_sounds() -> void:
    if just_triggered_jump:
        Sc.audio.play_sound("duck_jump")
    
    if surface_state.just_left_air:
        Sc.audio.play_sound("duck_land")


func _on_follow_behavior_deactivated() -> void:
    follow_behavior.follow_target = null
    
    Sc.audio.play_sound("duckling_quack")
    
    var was_attached_to_leader := is_attached_to_leader
    is_attached_to_leader = false
    
    just_detached_from_leader = \
            was_attached_to_leader and \
            !is_attached_to_leader
    
    if just_detached_from_leader:
        leader.is_attached_to_follower = false
        leader.just_attached_to_follower = false
        leader.just_detached_from_follower = true
        leader.follower = null
        Sc.level.last_attached_duck = leader
        leader = null
        if is_attached_to_follower:
            follower.on_leader_detached()
        
        on_detached_from_leader()
        
        Sc.audio.play_sound("lost_duck")


func on_attached_to_leader() -> void:
    follow_behavior.follow_target = leader
    follow_behavior.trigger(true)
    Sc.audio.play_sound("duckling_quack")


func on_detached_from_leader() -> void:
    if follow_behavior.is_active:
        follow_behavior.on_detached()
    else:
        show_exclamation_mark()
        Sc.audio.play_sound("duckling_quack")


func on_touched_enemy(enemy: KinematicBody2D) -> void:
    if start_surface == null:
        return
    
    show_exclamation_mark()
    Sc.audio.play_sound("duckling_quack")
    
    Sc.level_session.duckling_scare_count += 1
    
    _log_player_event("Duckling touched an enemy")
    
    if is_attached_to_leader:
        Sc.level.last_attached_duck = leader
        leader.is_attached_to_follower = false
        leader.just_attached_to_follower = false
        leader.just_detached_from_follower = true
        leader.follower = null
        just_attached_to_leader = false
        just_detached_from_leader = true
    if is_attached_to_follower:
        follower.on_leader_detached()
        just_attached_to_follower = false
        just_detached_from_follower = true
    
    is_attached_to_leader = false
    leader = null
    is_attached_to_follower = false
    follower = null
    
    Sc.level.swap_duckling_with_run_away(self, enemy)
