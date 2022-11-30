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
				get_tree().change_scene("res://scenes/apartment.tscn")
				pass

func OnApartAreaEntered(body):
	action_state = "Open"
	
func OnApartAreaExited(body):
	action_state = "Off"
