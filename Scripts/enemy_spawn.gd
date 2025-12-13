extends Node2D

@onready var main = get_node("/root/Main")
@export var Enemy_ant: PackedScene


var Enemy_scene := preload("res://scenes/Enemy.tscn")
var spawn_points := []
var current_wave: int 
var starting_nodes: int
var current_nodes: int
var wave_spawn_ended

# Called when the node enters the scene tree for the first time.
func _ready():
	current_wave = 0
	for i in get_children():
		if i is Marker2D:
			spawn_points.append(i)

func _on_timer_timeout() -> void:
	var spawn = spawn_points[randi() % spawn_points.size()]
	var EnemyAnt = Enemy_scene.instantiate()
	EnemyAnt.position = spawn.position
	main.add_child(EnemyAnt)
