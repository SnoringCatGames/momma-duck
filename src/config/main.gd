class_name Main
extends Node


func _ready() -> void:
    Gs.connect("initialized", self, "_on_scaffolder_initialized")
    Gs.connect("splashed", self, "_on_splash_screen_finished")


func _on_scaffolder_initialized() -> void:
    Gs.disconnect("initialized", self, "_on_scaffolder_initialized")
    pass


func _on_splash_screen_finished() -> void:
    Gs.disconnect("splashed", self, "_on_splash_screen_finished")
    pass
