class_name CountDisplays
extends VBoxContainer


const COUNT_DISPLAY_RESOURCE_PATH := "res://src/gui/count_display.tscn"
const SEPARATION := 12.0
const DEFAULT_GUI_SCALE := 1.0

var followers_count_display: CountDisplay
var duckling_scare_count_display: CountDisplay
var time_display: CountDisplay


func _ready() -> void:
    time_display = Gs.utils.add_scene(
            self,
            COUNT_DISPLAY_RESOURCE_PATH,
            true,
            true)
    time_display.label = "Time:"
    
    followers_count_display = Gs.utils.add_scene(
            self,
            COUNT_DISPLAY_RESOURCE_PATH,
            true,
            true)
    followers_count_display.label = "Ducklings in tow:"
    
    duckling_scare_count_display = Gs.utils.add_scene(
            self,
            COUNT_DISPLAY_RESOURCE_PATH,
            true,
            false)
    duckling_scare_count_display.label = "Ducklings scared:"
    
    Gs.add_gui_to_scale(self, DEFAULT_GUI_SCALE)
    
    update_gui_scale(1.0)


func update_gui_scale(gui_scale: float) -> bool:
    var separation := SEPARATION * Gs.gui_scale
    
    rect_position = Vector2(separation, separation)
    
    return false


func _process(_delta: float) -> void:
    if !Gs.level.is_momma_level_started:
        return
    
    _update_displays()


func _update_displays() -> void:
    time_display.value = Gs.utils.get_time_string_from_seconds(
            Gs.time.get_play_time() - \
            Gs.level.level_start_play_time_unscaled,
            false,
            false)
    followers_count_display.value = str(Gs.level.get_ducklings_in_tow_count())
    duckling_scare_count_display.value = str(Gs.level.duckling_scare_count)
