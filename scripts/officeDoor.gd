extends TileMap

onready var mapscene_GUI = get_node("../GUI")

var door_area = preload("res://scenes/officeDoor.tscn")

func _ready():
	var used_door_tiles = get_used_cells_by_id(46)
	for tile in used_door_tiles:
		if get_cell_autotile_coord(tile[0], tile[1]) == Vector2(0, 0) or get_cell_autotile_coord(tile[0], tile[1]) == Vector2(2, 0):
			var door_area_instance = door_area.instance()
			door_area_instance.position = map_to_world(tile)
			add_child(door_area_instance)
	for area in get_tree().get_nodes_in_group("interactAreas"):
		area.connect("body_entered", mapscene_GUI, "OnDoorAreaEntered")
		area.connect("body_exited", mapscene_GUI, "OnDoorAreaExited")
