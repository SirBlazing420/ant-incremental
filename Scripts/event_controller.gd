extends Node

signal level_completed

signal on_health_ui_ready(node: Node)
signal on_health_changed(node: Node, new_health: float)
signal on_max_health_changed(node: Node, new_health: float)
