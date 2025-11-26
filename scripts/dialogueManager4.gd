extends CanvasLayer

signal dialogue_finished # avisa o Player quando terminar
@onready var ui = get_tree().get_first_node_in_group("ui")
var current_index: int = 0
# Alterar textos atraves do inspector da UI (Item dialogues)
@export var dialogues: Array[Array] = [
	["???: Com licença?", "Cauda de Esquivo: Uh? AAH! Q-Qqq-quem -é v-v-vvvo-cc-cê?"],
	["Está muito escuro, e frio.", "Melhor seguir em frente.", "Está muito escuro, e frio"],
	["Não tem nada por aqui.", "Preciso explorar", "E achar um lugar pra descansar."],	
]

var active: bool = false
var current_line: int = 0
var current_dialogue: Array = []

# Variável de controle para garantir que o diálogo inicie apenas uma vez
var dialogue_started_once: bool = false 
# Caminho da próxima cena conforme solicitado
const NEXT_SCENE_PATH: String = "res://cenas/home.tscn" 

@onready var panel: Panel = $Panel
@onready var label: Label = $Panel/Label

func _ready() -> void:
	panel.visible = false
	# A checagem inicial foi movida para _process para capturar a mudança de estado.

func start_dialogue(index: int) -> void:
	if index >= dialogues.size():
		# Se não houver mais diálogos, apenas termina
		_end_dialogue()
		return
	current_dialogue = dialogues[index]
	current_line = 0
	panel.visible = true
	active = true
	_show_line()

func _process(_delta: float) -> void:
	# Lógica corrigida:
	# Inicia o diálogo APENAS UMA VEZ quando Gm.world2dialogue for true.
	if Gm.world2dialogue and not dialogue_started_once:
		start_dialogue(current_index)
		# Marca como verdadeiro para impedir execuções futuras.
		dialogue_started_once = true 
		
	# Lógica para avançar o diálogo
	if active and Input.is_action_just_pressed("interact"):
		_next_line()

func _show_line() -> void:
	if current_line < current_dialogue.size():
		label.text = str(current_dialogue[current_line])
	else:
		_end_dialogue()

func _next_line() -> void:
	current_line += 1
	_show_line()

func _end_dialogue() -> void:
	active = false
	panel.visible = false
	
	
	# Troca de cena para "res://cenas/home.tscn"
	#if NEXT_SCENE_PATH != "":
		#Gm.world2tohome = true
		#get_tree().change_scene_to_file(NEXT_SCENE_PATH)
