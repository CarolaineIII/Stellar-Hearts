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
	if scene_file_path == "res://cenas/cutscene.tscn":
		anim.play("fade_in")
	if scene_file_path == "res://cenas/world.tscn":
		anim.play("fade_in")
		
	if scene_file_path == "res://cenas/cutscene2.tscn":
		anim.play("fade_in")
	if scene_file_path == "res://cenas/world2.tscn": 
		Gm.sceneworld2 = true
	else:
		Gm.sceneworld2 = false
	if scene_file_path == "res://cenas/home.tscn":
		anim.play("fade_in")
	player = get_node("player")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
			
	if interacao == true and Input.is_action_just_pressed("interact"):
		
		tronco.play("TroncoComGato") #muda para a camera na mesma cena para o gato dentro de um tronco
		#await get_tree().create_timer(1.0).timeout
		#desabilita a movimentação e outros controles (como texto de interaçao) assim que o gato fica dentro do tronco
		Gm.podemovimentar = false
		textoInteracao.visible = false
		player.visible = false
		camera.zoom = Vector2(2,2)
		estanotronco = true #variavel de estado para guardar um estado
		await get_tree().create_timer(3.0).timeout # temporizador para nada ocorrer por 3 segundos enquanto o gato fica dentro do tronco
		Gm.endsceneworld = true #envia um sinal para o game manager mudando o estado da situação da cena
		await get_tree().create_timer(1.0).timeout #um temporizador de 1 segundo para durar a animação de fade out antes de mudar para a proxima cena
		get_tree().change_scene_to_file("res://cenas/cutscene2.tscn")
		player.position = Vector2(1040, -70) #muda o player de posição alem de deixar invisivel (linha 26)
	
	if Gm.CutToWorld == true: #Talvez aqui ele apresente um "piscar"na troca de cena
		
		anim.play("fade_out")
		await get_tree().create_timer(1.0).timeout
		get_tree().change_scene_to_file("res://cenas/world.tscn")
		
		Gm.CutToWorld = false
		
		
	#analisa a situação da cena de acordo com o sinal enviado ao GM
	if Gm.endsceneworld == true:
		anim.play("fade_out") #A cena atual deve escurecer para então entrar a proxima cena (mas parece que a animação que roda é a fade in)
		Gm.endsceneworld = false #reseta o sinal
	if Gm.world2tohome == true:
		anim.play("fade_out") #A cena atual deve escurecer para então entrar a proxima cena (mas parece que a animação que roda é a fade in)
		Gm.world2tohome = false #reseta o sinal
		
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



func _on_timer_timeout() -> void:
	pass
