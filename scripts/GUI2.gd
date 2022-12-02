extends CanvasLayer

var action_state = "Off"

func _process(delta):
	if Input.is_action_just_pressed("Action"):
		match action_state:
			"Off":
				pass
			"Open":
				SFX.stop_music()
				var harper = preload("res://scenes/harper.tscn").instance()
				harper.position = Vector2(16.0,33.0)
				SFX.play_boom()
				get_tree().get_root().get_node("Node2D/base/buildings and stuff").add_child(harper)
				Player.idleDown()
				$DialogBox.play()
				yield(get_tree().create_timer(30), "timeout")
				SFX.play_sound()
				yield(get_tree().create_timer(0.9), "timeout")
				get_tree().change_scene("res://scenes/apartment.tscn")
				pass

func OnApartAreaEntered(body):
	action_state = "Open"
	
func OnApartAreaExited(body):
	action_state = "Off"
