extends CanvasLayer

var action_state = "Off"

func _process(delta):
	if Input.is_action_just_pressed("Action"):
		match action_state:
			"Off":
				pass
			"Open":
				get_tree().change_scene("res://scenes/city 2.tscn")
				pass

func OnSubwayAreaEntered(body):
	action_state = "Open"
	
func OnSubwayAreaExited(body):
	action_state = "Off"
