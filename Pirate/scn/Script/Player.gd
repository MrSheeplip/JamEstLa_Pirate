extends Node2D

var Life : int 
var Hunger : int = 20
var Money : int 
var bullet : int

func Hunger(playerPosTile, mousePosTile):
	var DistancePlayerToMouse = playerPosTile.distance_to(mousePosTile) as int 
	var PreHunger : int
	var DistanceMax : int
	
	if DistancePlayerToMouse > DistanceMax:
		DistanceMax = DistancePlayerToMouse + 1
		PreHunger += DistancePlayerToMouse * 2
	elif DistancePlayerToMouse < DistanceMax:
		DistanceMax = DistancePlayerToMouse - 1
	return PreHunger
