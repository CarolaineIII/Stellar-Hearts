extends Node

var cenamenu = false
var podemovimentar = true
var CutToWorld = false
var Cut2ToWorld2 = false
var endsceneworld = false
func _process(delta: float) -> void:
	#print(podemovimentar)
	
	# Imprime o nome do nó da cena atual.
	#print(get_tree().current_scene.scene_file_path)
	
	
	if Cut2ToWorld2 == true:
		get_tree().change_scene_to_file("res://cenas/world2.tscn")
		Cut2ToWorld2 = false
		podemovimentar = true
