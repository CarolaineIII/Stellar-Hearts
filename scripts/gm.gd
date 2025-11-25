extends Node

# Variáveis existentes...
var cenamenu = false
var podemovimentar = true
var CutToWorld = false
var Cut2ToWorld2 = false
var playerflip = false
var endsceneworld = false
var sceneworld2 = false
var sceneworld2a = false
var botpodemover = false
var world2dialogue = false
# --- NOVO: Variável para armazenar o histórico de posições do Branco ---
# Usaremos um Array de Vector2 para isso.
var branco_historico_posicoes: Array[Vector2] = []
# O tamanho da cauda (quantos passos de atraso o Vermelho deve ter).
# Como é um CharacterBody2D com movimento baseado em célula/bloco (sem diagonal),
# uma posição (que é o passo inicial) já é suficiente para começar a seguir no próximo passo.
const CAUDA_TAMANHO: int = 100

func _process(delta: float) -> void:
	# ... código existente ...
	print(sceneworld2)
	
	if Cut2ToWorld2 == true:
		get_tree().change_scene_to_file("res://cenas/world2.tscn")
		Cut2ToWorld2 = false
		podemovimentar = true
