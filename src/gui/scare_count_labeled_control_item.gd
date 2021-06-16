class_name ScareCountLabeledControlItem
extends TextLabeledControlItem


const LABEL := "Duckling scares:"
const DESCRIPTION := ""

var level_id: String


func _init(level_or_id).(
        LABEL,
        DESCRIPTION \
        ) -> void:
    self.level_id = \
            level_or_id.id if \
            level_or_id is ScaffolderLevel else \
            (level_or_id if \
            level_or_id is String else \
            "")


func get_text() -> String:
    if level_id == "":
        return "—"
    else:
        assert(is_instance_valid(Gs.level))
        return str(Gs.level.duckling_scare_count)
