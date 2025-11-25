extends CharacterBody2D

var speed = 120  # valores realistas para Godot: entre 100 e 200
var direction = Vector2.ZERO
var interacao 

@onready var _animated_sprite = $AnimatedSprite2D
@onready var botfollow = $"../bot"
func _physics_process(_delta: float) -> void:
	# ... (código de coleta de input e animação existentes) ...
	if position.distance_to(botfollow.position)< 50:
		Gm.botpodemover = false
	else:
		Gm.botpodemover = true
	var previous_position = global_position # Guarda a posição antes do movimento
	
	direction = Vector2.ZERO
	
	if Gm.podemovimentar == true and Gm.sceneworld2 == true:
		_animated_sprite.flip_h = true
		Gm.sceneworld2 = false
	
	if Gm.podemovimentar == true:
		# Coleta de entradas com prioridade (horizontal > vertical)
		if Input.is_action_pressed("right"):
			direction.x = 1
		elif Input.is_action_pressed("left"):
			direction.x = -1
		elif Input.is_action_pressed("down"):
			direction.y = 1
		elif Input.is_action_pressed("up"):
			direction.y = -1
			


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

	# Corrida com Shift
	speed = 200 if Input.is_action_pressed("shift") else 120

	# Movimento com velocidade realista
	velocity = direction.normalized() * speed if direction != Vector2.ZERO else Vector2.ZERO
	move_and_slide()
	
	# --- NOVO: Rastreamento de Posição ---
	# Verifica se o personagem realmente se moveu
	if previous_position != global_position:
		# Adiciona a posição ANTERIOR (onde ele estava antes de se mover) ao histórico.
		# A posição que ele acabou de deixar é o primeiro "passo" que o Vermelho deve seguir.
		
		# Certifique-se de que o histórico não exceda o tamanho
		if Gm.branco_historico_posicoes.size() >= Gm.CAUDA_TAMANHO:
			# Remove o passo mais antigo para manter o tamanho da cauda.
			# Isso garante que a posição para o Vermelho esteja sempre na posição 0.
			Gm.branco_historico_posicoes.pop_back()
			
		# Adiciona a posição anterior à FRENTE do array.
		# O primeiro elemento (índice 0) é o passo mais recente.
		Gm.branco_historico_posicoes.push_front(previous_position)
