class_name Main
extends SurfacerBootstrap


func _ready() -> void:
    run(MommaDuck, self)


func _on_app_initialized() -> void:
    ._on_app_initialized()
    
    # Hide this annatotator by default.
    Surfacer.annotators.set_annotator_enabled(
            AnnotatorType.RECENT_MOVEMENT,
            false)
