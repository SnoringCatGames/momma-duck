tool
class_name CollidableTileMap
extends SurfacesTileMap


const DEFAULT_TILE_SET := \
        preload("res://src/levels/collidable_tile_set.tres")


export var draws_tile_indices := false setget _set_draws_tile_indices


func _ready() -> void:
    if tile_set == null:
        tile_set = DEFAULT_TILE_SET


func _draw() -> void:
    if draws_tile_indices:
        Sc.draw.draw_tile_map_indices(
                    self,
                    self,
                    Color.white,
                    false)


func _set_draws_tile_indices(value: bool) -> void:
    draws_tile_indices = value
    update()
