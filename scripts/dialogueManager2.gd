extends CanvasLayer

signal dialogue_finished  # avisa o Player quando terminar

#Alterar textos atraves do inspector da UI (Item dialogues)
@export var dialogues: Array[Array] = [
	["???: Com licença?", "Cauda de Esquivo: Uh? AAH! Q-Qqq-quem -é v-v-vvvo-cc-cê?"],
	["Está muito escuro, e frio.", "Melhor seguir em frente.", "Está muito escuro, e frio"],
	["Não tem nada por aqui.", "Preciso explorar", "E achar um lugar pra descansar."], 
	
]

var active: bool = false
var current_line: int = 0
var current_dialogue: Array = []

@onready var panel: Panel = $Panel
@onready var label: Label = $Panel/Label

func _ready() -> void:
	panel.visible = false

func start_dialogue(index: int) -> void:
	if index >= dialogues.size():
		# se não houver mais diálogos, apenas termina
		_end_dialogue()
		return
	current_dialogue = dialogues[index]
	current_line = 0
	panel.visible = true
	active = true
	_show_line()

func _process(_delta: float) -> void:
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
	emit_signal("dialogue_finished")  # o Player ouvirá isso e seguirá para o próximo ponto
	
