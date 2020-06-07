extends Sprite

onready var BaseNode = get_parent()
onready var Map : TileMap = get_parent().get_node("Map")
onready var SelectorLabel : Label = $SelectorLabel


var PlayerPosTile 
var MousePosReal #pos de la souris (monde)
var MousePosTile # pos de la souris (tilemap)

# bool en fonction du cursor
var SelectorIsActived : bool
var SelectorOnPlayer : bool
var SelectorOnChest : bool
var SelectorOnIsland : bool
var SelectorOnMovement : bool

func _ready():
	visible = false
	SelectorIsActived = false
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
		TextLabel = "A unknow island"
	return TextLabel

func PlayerOnMove():
	var PreHunger : int
	
	if Input.is_action_just_pressed("MouseRight") and SelectorOnMovement:
		SelectorOnMovement = false
		visible = false
		yield(get_tree().create_timer(0,1),"timeout")
	if Input.is_action_just_pressed("MouseLeft") and SelectorOnMovement:
		if Player.Hunger > PreHunger or Player.Hunger == PreHunger:
			if PlayerPosTile != MousePosTile:
				MovePlayer(PreHunger)

func SelectorChoose():
	if SelectorOnPlayer:
		if PlayerPosTile != MousePosTile:
			SelectorOnPlayer = false
			visible = false
	else:
		if PlayerPosTile == MousePosTile and Input.is_action_just_pressed("MouseLeft"):
			SelectorOnPlayer = false
			SelectorOnMovement = true
		if PlayerPosTile == MousePosTile and not Input.is_action_just_pressed("MouseLeft"):
			SelectorOnPlayer = true
			SelectorLabel.text = SelectorTextLabel()
			visible = true
		
	
	if SelectorOnChest:
		if MousePosTile != Map.ChestPos:
			visible = false
			SelectorOnChest = false
	else:
		if MousePosTile == Map.ChestPos: #si souris sur Coffre
			SelectorOnChest = true
			SelectorLabel.text = SelectorTextLabel()
			visible = true
	
	if SelectorOnIsland:
		if not Map.IslandTiles.has(MousePosTile):
			SelectorOnIsland = false
			SelectorIsActived = false
			visible = false
	else:
		if Map.IslandTiles.has(MousePosTile):
			SelectorOnIsland = true
			SelectorLabel.text = SelectorTextLabel()
			visible = true

func MovePlayer(preHunger):
	if SelectorIsActived:
		Player.Hunger -= preHunger
		Map.set_cellv(MousePosTile,1)
		SelectorIsActived = false
		yield(get_tree().create_timer(0,1),"timeout")
		Map.set_cellv(PlayerPosTile,0)
		CoreNode.PlayerTiles()
