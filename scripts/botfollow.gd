extends CharacterBody2D

# O Vermelho usa sua própria velocidade para se mover.
var speed = 100 
# Note que, para um movimento baseado em passos, você pode apenas 
# forçar a posição em vez de usar move_and_slide.

@onready var _animated_sprite = $AnimatedSprite2D # Assumindo que o Vermelho também tem um AnimatedSprite2D

func _physics_process(delta: float) -> void:
	
	
	# O Vermelho só deve se mover se houver uma posição para seguir no histórico
	if Gm.branco_historico_posicoes.size() > 0:
		# Pega a posição mais antiga no histórico (o passo que o Vermelho deve seguir)
		var target_position = Gm.branco_historico_posicoes[-1]
		
		# O Vermelho só se move quando o Branco já se moveu e a posição de destino não é a sua.
		if global_position != target_position:
			
			# --- Movimento e Animação ---
			
			# Calcula a direção para animação (horizontal ou vertical)
			var movement_vector = target_position - global_position
			if Gm.botpodemover == false:
				movement_vector = 0
				
			else:
			# Animações (baseadas na direção de movimento)
				if abs(movement_vector.x) > abs(movement_vector.y): # Movimento horizontal
					if movement_vector.x > 0:
						_animated_sprite.flip_h = false
						_animated_sprite.play("walk")
					else:
						_animated_sprite.flip_h = true
						_animated_sprite.play("walk")
				elif abs(movement_vector.y) > 0: # Movimento vertical
					if movement_vector.y < 0:
						_animated_sprite.play("walk-up")
					else:
						_animated_sprite.play("walk-down")
				
				# Usa um movimento simples de interpolação para ir para a nova posição.
				# Como é um movimento baseado em passos/células, a interpolação parece 
				# mais suave do que o teletransporte direto.
				
				# Move o Vermelho suavemente para a posição alvo
				global_position = global_position.lerp(target_position, delta * 15.0) # O '15.0' é um fator de suavidade
				
				# Se ele estiver muito perto, force a posição exata e remova-a do histórico.
				if global_position.distance_to(target_position) < 1.0:
					global_position = target_position
					Gm.branco_historico_posicoes.pop_back()
					
				else:
				# Posição alcançada, remova do histórico e use animação Idle correspondente
					Gm.branco_historico_posicoes.pop_back()
				
				# Transição para Idle
				match _animated_sprite.animation:
					"walk":
						_animated_sprite.play("Idle")
					"walk-up":
						_animated_sprite.play("Idle-up")
					"walk-down":
						_animated_sprite.play("Idle-down")
						
	else:
		# Se não houver passos para seguir, garanta que esteja na animação Idle
		match _animated_sprite.animation:
			"walk":
				_animated_sprite.play("Idle")
			"walk-up":
				_animated_sprite.play("Idle-up")
			"walk-down":
				_animated_sprite.play("Idle-down")
