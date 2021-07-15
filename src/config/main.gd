class_name Main
extends Node


func _ready() -> void:
    Sc.connect("initialized", self, "_on_scaffolder_initialized")
    Sc.connect("splashed", self, "_on_splash_screen_finished")


func _on_scaffolder_initialized() -> void:
    Sc.disconnect("initialized", self, "_on_scaffolder_initialized")
    pass


func _on_splash_screen_finished() -> void:
    Sc.disconnect("splashed", self, "_on_splash_screen_finished")
    pass
