extends TileMap


var MapSize : Array #Array avec tout les nodes des cellules sur la tilemap
var ChestPos  #Pos du coffre (tilemap)
var IslandTiles : Array #Array avec tout les cellules des îles (tilemap)
var EnemyTiles : Array
var PlayerPos

func _ready():
	randomize()
	set_cell(7,7,1)
	MapSize = get_used_cells()
	RandiTiles()

func PlayerTiles():
	var PlayerCell
	var PlayerTile = get_used_cells_by_id(1) #array
	for player in PlayerTile:
		PlayerCell = player
		PlayerPos = PlayerCell
	return PlayerCell

func RandiTiles():
	var CellsRandiIsland : Array
	var CellsRandiChest : Array
	var CellsRandiEnemy : Array
	
	for cell in MapSize:
		var DistanceToPlayer
		
		DistanceToPlayer = cell.distance_to(PlayerTiles()) as int
		if DistanceToPlayer > 2 and DistanceToPlayer < 8 :
			CellsRandiIsland.append(cell)
		if DistanceToPlayer > 5 and DistanceToPlayer < 10:
			CellsRandiChest.append(cell)
			CellsRandiEnemy.append(cell)
			
	
	while ChestPos == null:
		var randiArray
		var randiPos =  CellsRandiChest.size()
		randiArray = randi() % randiPos
		ChestPos = CellsRandiChest[randiArray]
		set_cellv(ChestPos,3)
	print ("New ChestPos: " + str(ChestPos))

	while IslandTiles.size() < 4:
		var SetCellPos
		var randiArray
		var randiPos =  CellsRandiIsland.size()
		randiArray = 1 + randi() % randiPos
		SetCellPos = CellsRandiIsland[randiArray]
		if !SetCellPos == ChestPos or !IslandTiles.has(SetCellPos):
			set_cellv(SetCellPos,4)
			IslandTiles.append(SetCellPos)
	print ("New Islands Pos: " + str(IslandTiles))
	
	while EnemyTiles.size() < 5 :
		var SetCellPos
		var randiArray
		var randiPos =  CellsRandiEnemy.size()
		randiArray = 1 + randi() % randiPos
		SetCellPos = CellsRandiEnemy[randiArray]
		if !SetCellPos == ChestPos or !EnemyTiles.has(SetCellPos):
			set_cellv(SetCellPos,2)
			EnemyTiles.append(SetCellPos)
	print ("New Enemy Pos: " + str(EnemyTiles))
	
func MoveEnemy():
	var CellNearest : Array
	
	for enemy in EnemyTiles:
		var EnemyDistanceToPlayer
		var CellNearToEnemy
		
		for cell in MapSize:
			if cell.distance_to(enemy) < 2:
				CellNearest.append(cell)
		for cell in CellNearest:
			EnemyDistanceToPlayer = enemy.distance_to(PlayerPos) as int
			
		print(CellNearest)
				
#			if DistanceToPlayer < 5:
#					var NeaerestCell : Vector2
#					var minimalDistance = playerPos.distance_to(Vector2(2000,2000))
#					var distance = playerPos.distance_to(cell)
#					if distance < minimalDistance:
#						minimalDistance = distance
#						nearestCell = cell
