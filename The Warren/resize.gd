extends Node

func _ready():
	#OS.window_size = Vector2(1600, 900)
	pass

func _input(event):
	if (Input.is_action_pressed("quit")):
		get_tree().quit()