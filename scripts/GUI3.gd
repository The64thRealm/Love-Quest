extends CanvasLayer

func _ready():
	$"../stuff/addons/player2".cantMove()
	$"../stuff/addons/player2".idleUp()
	var harper = preload("res://scenes/harper.tscn").instance()
	harper.idleDown()
	harper.position = Vector2(-39.0,15.0)
	get_tree().get_root().get_node("Node2D/base/stuff/addons/behind/TileMap").add_child(harper)
	var tilemap = $"../stuff/addons/behind/TileMap"
	tilemap.set_cell(-1, -4, 1)
	yield(get_tree().create_timer(0.9), "timeout")
	$DialogBox.play()
#	$DialogBox/sprite.scale *= 0.25
	$DialogBox/sprite.position = Vector2(120, 60)

func _on_DialogBox_endReached():
	SFX.play_battle()
	OfficeTransition.change_scene("res://inBattleMain/inBattleMain.tscn")
