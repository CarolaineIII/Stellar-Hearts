extends Node2D

var direction = Vector2.ZERO
var speed = 10
@onready var light = $PointLight2D

var base_energy = 1.0
var min_energy = 0.6
var max_energy = 1.4

var current_energy = 1.0
var target_energy = 1.0
var change_timer = 0.0
var time_to_next_change = 0.1  # muda a cada 0.1 a 0.3 segundos

func _ready():
	direction = Vector2(randf() * 2 - 1, randf() * 2 - 1).normalized()
	base_energy = randf_range(0.8, 1.2)
	current_energy = base_energy
	target_energy = randf_range(min_energy, max_energy)
	time_to_next_change = randf_range(0.05, 0.2)

func _process(delta):
	position += direction * speed * delta

# Troca de direção eventual
	if randf() < 0.01:
		direction = Vector2(randf() * 2 - 1, randf() * 2 - 1).normalized()

# Cintilação rápida e caótica
	change_timer += delta
	if change_timer >= time_to_next_change:
		change_timer = 0.0
		time_to_next_change = randf_range(0.05, 0.2)
		target_energy = randf_range(min_energy, max_energy)

# Transição suave entre os valores
	current_energy = lerp(current_energy, target_energy, delta * 10.0)
	light.energy = current_energy
