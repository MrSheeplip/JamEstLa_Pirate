extends TileMap


var MapSize : Array #Array avec tout les nodes des cellules sur la tilemap
var ChestPos  #Pos du coffre (tilemap)
var IslandTiles : Array #Array avec tout les cellules des îles (tilemap)

func _ready():
	set_cell(7,7,1)
	MapSize = get_used_cells()
	RandiTiles()

func PlayerTiles():
	var PlayerCell
	var PlayerTile = get_used_cells_by_id(1) #array
	for player in PlayerTile:
		PlayerCell = player
	return PlayerCell

func RandiTiles():
	var CellsRandi : Array
	
	for cell in MapSize:
		var DistanceToPlayer
		DistanceToPlayer = cell.distance_to(PlayerTiles()) as int
		if DistanceToPlayer > 5 :
			CellsRandi.append(cell)
	
	while ChestPos == null:
		var randiArray 
		var randiPos =  CellsRandi.size()
		randiArray = randi() % randiPos
		ChestPos = CellsRandi[randiArray]
		set_cellv(ChestPos,3)

	while  IslandTiles.size() < 4:
			var SetCellPos
			var randiArray 
			var randiPos =  CellsRandi.size()
			randiArray = randi() % randiPos + 1
			SetCellPos = CellsRandi[randiArray]
			if !SetCellPos == ChestPos:
				set_cellv(SetCellPos,4)
				IslandTiles.append(SetCellPos)
