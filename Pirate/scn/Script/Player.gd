extends Node2D

var Life : int 
var Hunger : int = 20
var Money : int 
var bullet : int

func movement(playerPosTile, mousePosTile, preHungerLabel : Label):
	var DistancePlayerToMouse = playerPosTile.distance_to(mousePosTile) as int 
	var PreHunger : int
	var RedFont = Color(1, 0, 0, 1) 
	var DistanceMax : int
	
	if DistancePlayerToMouse > DistanceMax:
		DistanceMax = DistancePlayerToMouse + 1
		PreHunger += DistancePlayerToMouse * 2
	elif DistancePlayerToMouse < DistanceMax:
		DistanceMax = DistancePlayerToMouse - 1
	
	if Hunger < PreHunger:
		preHungerLabel.self_modulate = "e12222"
	else:
		preHungerLabel.self_modulate = "ffffff"
		
	preHungerLabel.text = "-" + str(PreHunger) + " Hunger"
	return PreHunger
