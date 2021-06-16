class_name CountDisplay
extends Control


const SIZE := Vector2(256.0, 48.0)

var label: String setget _set_label,_get_label
var value: String setget _set_value,_get_value

var is_ready := false


func _ready() -> void:
    is_ready = true
    
    _set_label(label)
    _set_value(value)
    
    update_gui_scale(1.0)


func update_gui_scale(gui_scale: float) -> bool:
    var size := SIZE * Gs.gui_scale
    var spacer_size := 12 * Gs.gui_scale
    rect_min_size = size
    rect_size = size
    $Sprite.rect_min_size = size
    $Sprite.rect_size = size
    $HBoxContainer.rect_min_size = size
    $HBoxContainer.rect_size = size
    $HBoxContainer/Spacer.rect_size.x = spacer_size
    $HBoxContainer/Spacer.rect_min_size.x = spacer_size
    $HBoxContainer/Spacer2.rect_size.x = spacer_size
    $HBoxContainer/Spacer2.rect_min_size.x = spacer_size
    return true


func _set_label(v: String) -> void:
    label = v
    if is_ready:
        $HBoxContainer/Label.text = v


func _get_label() -> String:
    return label


func _set_value(v: String) -> void:
    value = v
    if is_ready:
        $HBoxContainer/Value.text = v


func _get_value() -> String:
    return value
