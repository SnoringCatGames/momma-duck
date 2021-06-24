class_name LoadingImage
extends Control


const LOADING_IMAGE_SIZE := Vector2(256.0, 256.0)
const SPRITE_SCALE := Vector2(2.0, 2.0)

var _base_scale := 1.0

var _is_ready := false


func _ready() -> void:
    _is_ready = true
    
    set_meta("gs_rect_position", rect_position)
    set_meta("gs_rect_size", rect_size)
    set_meta("gs_rect_min_size", rect_min_size)
    
    update_gui_scale()

func set_base_scale(value: float) -> void:
    _base_scale = value
    if _is_ready:
        update_gui_scale()


func update_gui_scale() -> bool:
    var original_rect_position: Vector2 = get_meta("gs_rect_position")
    var original_rect_size: Vector2 = get_meta("gs_rect_size")
    var original_rect_min_size: Vector2 = get_meta("gs_rect_min_size")

    var scale: float = _base_scale * Gs.gui.scale
    rect_position = original_rect_position * scale
    rect_min_size = original_rect_min_size * scale
    rect_size = original_rect_size * scale
    $Control.rect_position = LOADING_IMAGE_SIZE * 0.5 * scale
    $Control/AnimatedSprite.scale = SPRITE_SCALE * scale
    return true
