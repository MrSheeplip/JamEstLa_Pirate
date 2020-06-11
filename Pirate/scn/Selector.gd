extends Sprite

onready var BaseNode = get_parent()
onready var Map : TileMap = get_parent().get_node("Map")
onready var SelectorLabel : Label = $SelectorLabel

var PlayerPosTile 
var MousePosReal #pos de la souris (monde)
var MousePosTile # pos de la souris (tilemap)
var PreHunger : int

# bool en fonction du cursor
var SelectorIsActived : bool
var SelectorOnPlayer : bool
var SelectorOnChest : bool
var SelectorOnIsland : bool
var SelectorOnMovement : bool

func _ready():
	visible = false
	SelectorOnChest = false
	SelectorOnIsland = false
	SelectorOnPlayer = false
	SelectorOnMovement = false
	PlayerPosTile = Map.PlayerTiles()
	
func SelectorMovement(): #gère tout ce qui concerne le curseur
	var Offset = Vector2(32,32)
	
	MousePosReal = get_global_mouse_position()
	MousePosTile = Map.world_to_map(MousePosReal)
	
	position = lerp(position,Map.map_to_world(MousePosTile) + Offset, 0.2)

func SelectorTextLabel():
	var TextLabel
	
	#Change le texte du label
	if SelectorOnPlayer:
		TextLabel = "Your ship"
	if SelectorOnChest:
		TextLabel = "A Chest"
	if SelectorOnIsland:
		TextLabel = "An unknown island"
	return TextLabel

func PlayerOnMove():
	var RedFont = Color(1, 0, 0, 1) 
	PreHunger = Player.Hunger(PlayerPosTile, MousePosTile)

	if Player.Food < PreHunger:
		SelectorLabel.self_modulate = "e12222"
	else:
		SelectorLabel.self_modulate = "ffffff"
	SelectorLabel.text = "-" + str(PreHunger) + " Hunger"
	
	if Input.is_action_just_pressed("MouseRight") and SelectorOnMovement:
		SelectorOnMovement = false
		SelectorLabel.self_modulate = "ffffff"
		visible = false
		
	if Input.is_action_just_pressed("MouseLeft") and SelectorOnMovement:
		if Player.Food > PreHunger or Player.Food == PreHunger:
			if MousePosTile != PlayerPosTile or !Map.MapSize.has(MousePosTile) :
				MovePlayer()

func SelectorChoose():
	if SelectorOnMovement:
		PlayerOnMove()
	else:
		if PlayerPosTile == MousePosTile and Input.is_action_just_pressed("MouseLeft"):
			SelectorOnMovement = true
			visible = true
			SelectorLabel.text = SelectorTextLabel()
		elif PlayerPosTile == MousePosTile and not Input.is_action_just_pressed("MouseLeft"):
			SelectorOnPlayer = true
			visible = true
			SelectorLabel.text = SelectorTextLabel()
		elif MousePosTile == Map.ChestPos: #si souris sur Coffre
				SelectorOnChest = true
				SelectorLabel.text = SelectorTextLabel()
				visible = true
		elif Map.IslandTiles.has(MousePosTile):
				SelectorOnIsland = true
				SelectorLabel.text = SelectorTextLabel()
				visible = true
		else:
			SelectorOnChest = false
			SelectorOnIsland = false
			SelectorOnPlayer = false
			visible = false

func MovePlayer():
	Map.set_cellv(MousePosTile,1)
	Map.set_cellv(PlayerPosTile,0)
	PlayerPosTile = Map.PlayerTiles()
	
	Player.Food -= PreHunger
	
	if PlayerPosTile == Map.ChestPos:
		Map.ChestPos = null
	if Map.IslandTiles.has(PlayerPosTile):
		Player.FoundChest()
		Map.IslandTiles.clear()
		Map.IslandTiles = Map.get_used_cells_by_id(4)
		
		
	Map.RandiTiles()
	yield(get_tree().create_timer(0,1),"timeout")
	
	SelectorOnMovement = false

