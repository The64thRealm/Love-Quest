extends Button

func _on_CreditsButton_pressed():
	SFX.endText = "Thanks to the wonderful people that made this game"
	OfficeTransition.change_scene("res://scenes/end.tscn")
