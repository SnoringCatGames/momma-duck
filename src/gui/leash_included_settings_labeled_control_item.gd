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
    App.includes_leash = pressed
    Sc.save_state.set_setting(
            App.INCLUDES_LEASH_SETTINGS_KEY,
            App.includes_leash)


func get_is_pressed() -> bool:
    return App.includes_leash


func get_is_enabled() -> bool:
    return true
