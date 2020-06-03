extends Node2D

func Hunger(playerPosTile, mousePosTile, distanceMax, preHungerLabel : Label, hunger):
	var DistancePlayerToMouse = playerPosTile.distance_to(mousePosTile) as int 
	var PreHunger : int
	var RedFont = Color(1, 0, 0, 1) 
	
	if DistancePlayerToMouse > distanceMax:
		distanceMax = DistancePlayerToMouse + 1
		PreHunger += DistancePlayerToMouse * 2
	elif DistancePlayerToMouse < distanceMax:
		distanceMax = DistancePlayerToMouse - 1
	
	if hunger < PreHunger:
		preHungerLabel.self_modulate = "e12222"
	else:
		preHungerLabel.self_modulate = "ffffff"
		
	preHungerLabel.text = "-" + str(PreHunger) + " Hunger"
	return PreHunger
