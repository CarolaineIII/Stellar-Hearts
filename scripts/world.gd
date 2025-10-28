extends Node2D

@onready var textoInteracao = $textoInteracao
@onready var anim = $Fade/AnimationPlayer
var interacao = false
@onready var tronco = $TileMap/Tronco
var player
@onready var camera = $player/Camera2D
var estanotronco = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim.play("fade_in")
	player = get_node("player")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	if interacao == true and Input.is_action_just_pressed("interact"):
		
		tronco.play("TroncoComGato")
		#await get_tree().create_timer(1.0).timeout
		
		Gm.podemovimentar = false
		textoInteracao.visible = false
		player.visible = false
		camera.zoom = Vector2(2,2)
		estanotronco = true
		await get_tree().create_timer(3.0).timeout
		anim.play("fade_in")
		await get_tree().create_timer(1.0).timeout
		get_tree().change_scene_to_file("res://cenas/cutscene2.tscn")
		
	#if estanotronco == true and Input.is_action_just_pressed("interact"):
		#print("Foi")
		
		#player.position = Vector2(1040, -70)
	#if Gm.CutToWorld == true:
		#
		#anim.play("fade_out")
		#await get_tree().create_timer(1.0).timeout
		#Gm.CutToWorld = false
		#get_tree().change_scene_to_file("res://cenas/world.tscn")
		
		
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


func _on_animation_player_animation_started(anim_name: StringName) -> void:
	anim.play("fade_in")  # toca a animação


func _on_timer_timeout() -> void:
	pass
