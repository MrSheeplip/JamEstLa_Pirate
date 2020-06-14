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

func FoundIsland():
	var PreFood : int
	var PreBullet : int
	var randiLoot
	
	randiLoot = randi() % 2
	
	if randiLoot == 0:
		Loot = Loots.FOOD
	elif randiLoot == 1:
		Loot = Loots.AMMUNITION
	
	match Loot:
		Loots.FOOD:
			if Food < 20:
				PreFood = 8 + randi() % 10
				Food += PreFood
				print ("Add Food: " + str(PreFood))
			else:
				FoundIsland()
		Loots.AMMUNITION:
			if Bullets < 3:
				PreBullet = 1 + randi() % 2
				Player.Bullets += PreBullet
				print ("Add Bullets: " + str(PreBullet))
			else:
				FoundIsland()

func FoundChest():
	var PreMoney
	
	PreMoney = 1 + randi() % 100
	Money += PreMoney
	print ("Add Money : " + str(PreMoney))

func EnemyAttack():
	if Bullets > 0:
		Bullets -= 1
		print ("Use one Bullet")
	else:
		Life -= 1
		print ("take one damage")
