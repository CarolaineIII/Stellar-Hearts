extends Node2D

@onready var textoInteracao = $textoInteracao
@onready var anim = $Fade/AnimationPlayer
var interacao = false
@onready var tronco = $Tronco
var player
@onready var camera = $player/Camera2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim.play("fade_in")
	player = get_node("player")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if interacao == true and Input.is_action_just_pressed("interact"):
		tronco.play("TroncoComGato")
		textoInteracao.visible = false
		player.visible = false
		camera.zoom = Vector2(2,2)
		#player.position = Vector2(1040, -70)


func _on_exit_pressed() -> void:
	get_tree().quit()

func _on_interacao_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		textoInteracao.visible = true
		interacao = true
		body.interacao = self
		

	

func _on_interacao_body_exited(_body: Node2D) -> void:
	textoInteracao.visible = false
	interacao = false
