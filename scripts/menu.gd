extends Node2D

@onready var anim = $Fade/AnimationPlayer
func _ready() -> void:
	Gm.cenamenu = true
# Quando o botão Play for pressionado
func _on_play_pressed() -> void:
	anim.play("fade_out")  # toca a animação

# Quando a animação terminar
func _on_AnimationPlayer_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_out":
		get_tree().change_scene_to_file("res://cenas/cutscene.tscn")
		Gm.cenamenu = false


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_out":
		get_tree().change_scene_to_file("res://cenas/cutscene.tscn")
