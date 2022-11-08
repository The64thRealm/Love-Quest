extends CanvasLayer

var action_state = "Off"

func _process(delta):
	if Input.is_action_just_pressed("Action"):
		print("I pressed action")
		match action_state:
			"Off":
				print("Nothing to do here")
				pass
			"Open":
				print("I'm getting outta here")
				pass

func OnDoorAreaEntered(body):
	action_state = "Open"
	print("inDoor")
	
func OnDoorAreaExited(body):
	action_state = "Off"
	print("outDoor")
