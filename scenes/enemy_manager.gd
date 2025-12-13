# EnemyManager.gd
extends Node2D

@export var max_waves: int = 5
@export var enemy_spawner: Node 
@export var initial_spawn_count: int = 5
@export var enemies_per_wave_increase: int = 2

var current_wave: int = 0
var enemies_left_to_spawn: int = 0

func start_game():
	start_next_wave()

func start_next_wave():
	current_wave += 1
	if current_wave > max_waves:
		print("Game Won!")
		return

	# Calculate enemies for this wave
	enemies_left_to_spawn = initial_spawn_count + (current_wave - 1) * enemies_per_wave_increase
	
	# Start the spawn timer on the Spawner node
	# Assuming your spawner has a Timer child named 'SpawnTimer'
	enemy_spawner.get_node("Timer2").start() 

func on_enemy_spawned():
	enemies_left_to_spawn -= 1
	# Check for wave end condition (you'd need to track living enemies too)

	if enemies_left_to_spawn <= 0:
		enemy_spawner.get_node("Timer2").stop() # Stop spawning
		print("Waiting for enemies to be cleared...")
