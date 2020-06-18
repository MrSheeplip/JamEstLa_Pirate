extends Node

func _process(delta):
	if Input.is_action_just_pressed("Debug_F5"):
		Player.Food += 5
