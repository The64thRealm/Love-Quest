extends CanvasLayer

func _ready():
	$"../stuff/addons/player2".cantMove()
	$"../stuff/addons/player2".idleUp()
	var harper = preload("res://scenes/harper.tscn").instance()
	harper.idleDown()
	harper.position = Vector2(-39.0,15.0)
	get_tree().get_root().get_node("Node2D/base/stuff/addons/behind/TileMap").add_child(harper)
	$DialogBox.play()


func _on_DialogBox_endReached():
	OfficeTransition.change_scene("res://assets/ui/BattleMinigames/DodgeGame/DodgeGame.tscn")
