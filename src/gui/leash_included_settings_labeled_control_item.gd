class_name LeashIncludedSettingsLabeledControlItem
extends CheckboxLabeledControlItem


const LABEL := "Leash shown"
const DESCRIPTION := ""


func _init(__ = null).(
        LABEL,
        DESCRIPTION \
        ) -> void:
    pass


func on_pressed(pressed: bool) -> void:
    MommaDuck.includes_leash = pressed
    Gs.save_state.set_setting(
            MommaDuck.INCLUDES_LEASH_SETTINGS_KEY,
            MommaDuck.includes_leash)


func get_is_pressed() -> bool:
    return MommaDuck.includes_leash


func get_is_enabled() -> bool:
    return true
