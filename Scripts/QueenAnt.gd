extends CharacterBody2D
@onready var texture_progress_bar: TextureProgressBar = $CanvasLayer/TextureProgressBar
@onready var attack_area: Area2D = $AttackArea
@onready var health_label: Label = $CanvasLayer/TextureProgressBar/MaxHealth

signal health_changed(new_health, max_health)
@export var max_health: float = 100.0


var current_health: float = 100.0:
	set(value):
		current_health = clamp(value, 0.0, max_health)
		emit_signal("health_changed", current_health, max_health)


func _ready() -> void:
	#value = current_health
	#update_label()
	add_to_group("Player")
	connect_signals()
	
func update_label():
	health_label.text = "HP: " + str(current_health) + " / " + str(max_health)
	
#func set_health(new_health):
	#current_health = new_health
	#value = current_health
	#update_label()
	
func connect_signals() -> void:
	attack_area.body_entered.connect(decrease_life_points)
	#texture_progress_bar.connect("value_changed", healthbar_changed)
	
func decrease_life_points(_body)-> void:
	texture_progress_bar.value = current_health
	
func take_damage(amount):
	self.current_health -= amount
	if current_health <= 0:
		queue_free()
	
#func healthbar_changed(value : float) -> void:
	#if value == 0:
		#queue_free()
#func _on_player_health_changed(new_health: float, max_health_val: float):
	#self.max_value = max_health_val
	#self.value = new_health

#func _on_attack_area_body_entered(_body: CharacterBody2D) -> void:
	#take_damage(10)


#func _on_texture_progress_bar_value_changed(value: float) -> void:
	#current_health = int(value)
	#update_label()
	#pass # Replace with function body.
