tool
class_name Duckling
extends Duck


var leash_annotator: LeashAnnotator


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


func _update_navigator(delta_scaled: float) -> void:
    ._update_navigator(delta_scaled)
    
    if is_attached_to_leader:
        if navigator.is_currently_navigating:
            if is_close_enough_to_leader_to_stop_moving and \
                    surface_state.is_grabbing_floor:
                navigator.stop()
                behavior = PlayerBehaviorType.REST
            elif navigator.navigation_state.just_reached_end_of_edge and \
                    surface_state.just_left_air:
                # -   We are currently navigating, and we just landed on a new
                #     surface.
                # -   Update the navigation to point to the current leader
                #     position.
                _trigger_new_navigation()
        elif !is_far_enough_from_leader_to_start_moving:
            # We weren't yet navigating anywhere, so start navigating to the
            # leader.
            _trigger_new_navigation()


func _trigger_new_navigation() -> bool:
    var position_type: int
    if leader.surface_state.is_grabbing_a_surface:
        position_type = IntendedPositionType.CENTER_POSITION_ALONG_SURFACE
    elif leader.navigator.is_currently_navigating:
        if leader.navigator.edge.get_end_surface() != null:
            position_type = IntendedPositionType.EDGE_DESTINATION
        elif leader.navigator.edge.get_start_surface() != null:
            position_type = IntendedPositionType.EDGE_ORIGIN
        else:
            return false
    elif leader.surface_state.last_position_along_surface.surface != null:
        position_type = IntendedPositionType.LAST_POSITION_ALONG_SURFACE
    else:
        return false
    
    var destination := leader.get_intended_position(position_type)
    navigator.navigate_to_position(destination)
    behavior = PlayerBehaviorType.FOLLOW
    
    return true


func _process_sounds() -> void:
    if just_triggered_jump:
        Sc.audio.play_sound("duck_jump")
    
    if surface_state.just_left_air:
        Sc.audio.play_sound("duck_land")


func on_attached_to_leader() -> void:
    show_exclamation_mark()
    Sc.audio.play_sound("duckling_quack")


func on_detached_from_leader() -> void:
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
    behavior = PlayerBehaviorType.RUN_AWAY
    
    Sc.level.swap_duckling_with_run_away(self, enemy)
