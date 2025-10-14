extends CharacterBody2D

var speed = 120  # valores realistas para Godot: entre 100 e 200
var direction = Vector2.ZERO

@onready var _animated_sprite = $AnimatedSprite2D

func _physics_process(_delta: float) -> void:
	direction = Vector2.ZERO
	
	#Animações
	if direction.x > 0:
		_animated_sprite.flip_h = false
		_animated_sprite.play("walk")
	elif direction.x < 0:
		_animated_sprite.flip_h = true
		_animated_sprite.play("walk")
	elif direction.y < 0:
		_animated_sprite.play("walk-up")
	elif direction.y > 0:
		_animated_sprite.play("walk-down")
	else:
		match _animated_sprite.animation:
			"walk":
				_animated_sprite.play("Idle")
			"walk-up":
				_animated_sprite.play("Idle-up")
			"walk-down":
				_animated_sprite.play("Idle-down")
				
# Movimento com velocidade realista
	velocity = direction.normalized() * speed if direction != Vector2.ZERO else Vector2.ZERO
	move_and_slide()
