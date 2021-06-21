class_name ScareCountLabeledControlItem
extends TextLabeledControlItem


const LABEL := "Duckling scares:"
const DESCRIPTION := ""

var level_id: String


func _init(level_session_or_id).(
        LABEL,
        DESCRIPTION \
        ) -> void:
    self.level_id = \
            level_session_or_id.id if \
            level_session_or_id is ScaffolderLevelSession else \
            (level_session_or_id if \
            level_session_or_id is String else \
            "")


func get_text() -> String:
    if level_id == "":
        return "—"
    else:
        assert(is_instance_valid(Gs.level))
        return str(Gs.level_session.duckling_scare_count)
