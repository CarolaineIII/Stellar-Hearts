extends Node2D

@onready var textoInteracao = $interacao/textoInteracao
@onready var anim = $Fade/AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim.play("fade_in")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_exit_pressed() -> void:
	get_tree().quit()

#func _on_interacao_body_entered(body: Node2D) -> void:
	##if body.is_in_group("player"):
	#textoInteracao.visible = not textoInteracao.visible
	##else:
	#if body.is_in_group("player"):
		#print("aqui muda de cena para o gato dormindo")

#func _on_interacao_body_exited(body: Node2D) -> void:
	#textoInteracao.visible = textoInteracao.visible
