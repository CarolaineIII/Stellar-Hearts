extends Node2D


@onready var anim = $Fade/AnimationPlayer

func _ready() -> void:
	if scene_file_path == "res://cenas/home.tscn":
		anim.play("fade_in")
