extends CanvasLayer

var action_state = "Off"

func _process(delta):
	if Input.is_action_just_pressed("Action"):
		match action_state:
			"Off":
				pass
			"Open":
				SFX.play_sound()
				yield(get_tree().create_timer(0.9), "timeout")
				SFX.play_music()
#				OfficeTransition.change_scene("res://scenes/city 2.tscn")
				get_tree().change_scene("res://scenes/city.tscn")
				pass

func OnDoorAreaEntered(body):
	action_state = "Open"
	
func OnDoorAreaExited(body):
	action_state = "Off"
