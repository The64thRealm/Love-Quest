extends CanvasLayer
onready var player = get_node("../buildings and stuff/player")
var action_state = "Off"

func _process(delta):
	if Input.is_action_just_pressed("Action"):
		match action_state:
			"Off":
				pass
			"Open":
				action_state = "Off"
				SFX.stop_music()
				var harper = preload("res://scenes/harper.tscn").instance()
				harper.idleUp()
				harper.position = Vector2(16.0,33.0)
				get_node("../buildings and stuff/addons").add_child(harper)
				SFX.play_boom()
				player.cantMove()
				player.idleDown()
				$DialogBox.play()
				$DialogBox/sprite.position = Vector2(150, 60)

func OnApartAreaEntered(body):
	action_state = "Open"
	
func OnApartAreaExited(body):
	action_state = "Off"


func _on_DialogBox_endReached():
	player.idleUp()
	SFX.play_sound()
	yield(get_tree().create_timer(0.9), "timeout")
	get_tree().change_scene("res://scenes/apartment.tscn")
