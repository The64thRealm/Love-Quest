extends CanvasLayer

onready var player = get_node("../stuff/addons/player2")

func _ready():
	
	player.cantMove()
	player.idleDown()
	var harper = preload("res://scenes/harper.tscn").instance()
	harper.idleDown()
	harper.position = Vector2(-31.0,-43.0)
	get_tree().get_root().get_node("Node2D/base/stuff/addons/behind/TileMap").add_child(harper)
	$DialogBox.play()
