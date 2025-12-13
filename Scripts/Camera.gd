extends Node2D

@export var zoom_speed: float = 0.1
@export var min_zoom: Vector2 = Vector2(0.5, 0.5)
@export var max_zoom: Vector2 = Vector2(2.0, 2.0)

var target_zoom: Vector2 = Vector2(1.0, 1.0) # Variable to store where we want to zoom
var camera: Camera2D
func _ready():
	camera = $Camera2D
	if camera != null:
		target_zoom = camera.zoom # Initialize target zoom to the starting zoom

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			target_zoom -= Vector2(zoom_speed, zoom_speed)
			target_zoom = target_zoom.max(min_zoom)
		elif event.button_index == MOUSE_BUTTON_WHEEL_UP:
			target_zoom += Vector2(zoom_speed, zoom_speed)
			target_zoom = target_zoom.min(max_zoom)

func _process(delta):
	# Smoothly move the actual camera zoom towards the target zoom
	camera.zoom = camera.zoom.lerp(target_zoom, delta * 5.0) # Adjust the 5.0 for speed of smoothing
