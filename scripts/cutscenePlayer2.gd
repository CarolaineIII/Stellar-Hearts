extends CharacterBody2D

@export var speed: float = 80.0
@export var waypoints: Array[NodePath]

var current_index: int = 0
var moving: bool = true
var target_position: Vector2

@onready var _animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var ui = get_tree().get_first_node_in_group("ui")  # garanta que o UI está no grupo "ui"

func _ready() -> void:
	#Habilita o flip do personagem para a esquerda
	#_animated_sprite.flip_h = true
	if ui:
		ui.dialogue_finished.connect(_on_dialogue_finished)
	_set_target_from_index()
	
func _physics_process(_delta: float) -> void:
	if Gm.playerflip == true:
		_animated_sprite.flip_h = true
		
	#if moving:
		#_move_to_target()
	#else:
		#_play_idle()

func _set_target_from_index() -> void:
	if current_index < waypoints.size():
		var point := get_node(waypoints[current_index]) as Node2D
		if point:
			target_position = point.global_position

#func _move_to_target() -> void:
	#var pos := global_position
	#if abs(pos.x - target_position.x) > 2:
		#velocity = Vector2(sign(target_position.x - pos.x) * speed, 0)
	#elif abs(pos.y - target_position.y) > 2:
		#velocity = Vector2(0, sign(target_position.y - pos.y) * speed)
	#else:
		#velocity = Vector2.ZERO
		#moving = false
		#await get_tree().create_timer(1.0).timeout
		#if ui:
			#ui.start_dialogue(current_index)
	#move_and_slide()
	#_play_walk_anim()

func _play_walk_anim() -> void:
	if velocity.x > 0:
		_animated_sprite.flip_h = false
		_animated_sprite.play("walk")
	elif velocity.x < 0:
		_animated_sprite.flip_h = true
		_animated_sprite.play("walk")
	elif velocity.y < 0:
		_animated_sprite.play("walk-up")
	elif velocity.y > 0:
		_animated_sprite.play("walk-down")

func _play_idle() -> void:
	match _animated_sprite.animation:
		"walk":
			_animated_sprite.play("Idle")
		"walk-up":
			_animated_sprite.play("Idle-up")
		"walk-down":
			_animated_sprite.play("Idle-down")

func _on_dialogue_finished() -> void:
	next_point()

func next_point() -> void:
	current_index += 1
	if current_index < waypoints.size():
		_set_target_from_index()
		moving = true
	else:
		
		print("O jogo comecou")
		print(moving)
		
func _on_exit_pressed() -> void:
	get_tree().quit()
