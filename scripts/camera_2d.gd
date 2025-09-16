#extends Camera2D
#
#@export var player_node: Node2D
#
## Ajuste este valor para mudar a suavidade. Valores menores = mais suave.
#@export var smoothing_factor: float = 0.1
#
#func _process(delta):
	##if player_node:
		### Interpola suavemente a posição X da câmera em direção à posição X do jogador.
		##global_position.x = lerp(global_position.x, player_node.global_position.x, smoothing_factor * delta * 60)
	#pass



#script não utilizado por nenhum node atualmente
