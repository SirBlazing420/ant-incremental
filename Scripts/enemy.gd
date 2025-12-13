extends CharacterBody2D


# Export variables for easy adjustment in the Inspector

@export var move_speed: float = 100.0
@export var attack_range: float = 20.0
@export var attack_cooldown: float = 1.0
@export var current_health: int
@export var damage_amount: int = 10


var player_target: Node2D = null
var can_attack: bool = true


func _ready():
	# Find the player node in the scene tree
	# This assumes a specific hierarchy or the player is in the "Player" group
	var players = get_tree().get_nodes_in_group("Player")
	if players:
		player_target = players[1]
		# Face the player immediately upon spawning
		face_player() 
	
	# Get a reference to your attack Area2D node
	# Replace "AttackArea" with the actual name of your Area2D node
	


func _physics_process(delta):
	if player_target:
		var distance_to_player = global_position.distance_to(player_target.global_position)

		if distance_to_player > attack_range:
			# Move towards the player
			converge_towards_player(delta)
		else:
			# Stop moving and attack if in range
			# Optional: Keep facing the player while stopped
			face_player()
			if can_attack:
				attack()

func face_player():
	if player_target:
		# Use look_at to rotate the enemy towards the player's global position
		# For 2D, this rotates the entire node. For 3D, use the appropriate look_at
		look_at(player_target.global_position) 

func converge_towards_player(_delta):
	if player_target:
		# Calculate the direction vector towards the player
		var direction = (player_target.global_position - global_position).normalized()
		velocity = direction * move_speed
		move_and_slide()

		# Ensure enemy faces the direction of movement while chasing
		face_player()

func attack():
	# Implement your attack logic here
	can_attack = false
	# Start a timer for the attack cooldown
	# Add a Timer node named "AttackTimer" to the Enemy scene
	$AttackTimer.start(attack_cooldown)

func _on_attack_area_body_entered(body):
	# Check if the body entering the attack area is the player
	if body.is_in_group("Player"):
		body.take_damage(damage_amount)

func _on_attack_timer_timeout():
	# Reset attack cooldown
	can_attack = false
	
	
	if current_health <= 0:
		queue_free() # Remove the enemy from the scene

# Function to be called when the enemy takes damage
func take_damage(amount: int):
	current_health -= amount

# Example attack function (implement your attack logic here)
