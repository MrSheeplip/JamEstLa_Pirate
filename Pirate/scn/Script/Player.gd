extends Node2D

var Life : int 
var Food : int = 20
var Money : int 
var Bullets : int

enum Loots {FOOD,AMMUNITION}
var Loot = Loots.FOOD
func _ready():
	randomize()

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

func FoundChest():
	var PreFood : int
	var PreBullet : int
	var randiLoot
	randiLoot = randi() % 2
	print (randiLoot)
	
	if randiLoot == 0:
		Loot = Loots.FOOD
	elif randiLoot == 1:
		Loot = Loots.AMMUNITION
	
	match Loot:
		Loots.FOOD:
			if Food < 20:
				PreFood = 8 + randi() % 10
				Food += PreFood
				print ("Food: " + str(PreFood))
		Loots.AMMUNITION:
			if Bullets < 3:
				PreBullet = 1 + randi() % 2
				Player.Bullets += PreBullet
				print ("Bullets: " + str(PreBullet))
