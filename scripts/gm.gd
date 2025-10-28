extends Node

var cenamenu = false
var podemovimentar = true
var CutToWorld = false
var Cut2ToHome = false

func _process(delta: float) -> void:
	print(CutToWorld)
	
	if Cut2ToHome == true:
		get_tree().change_scene_to_file("res://cenas/home.tscn")
		Cut2ToHome = false
