extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	SFX.play_title()


func _on_PlayButton_pressed():
	get_tree().change_scene("res://MainMenu/QuestionMenu.tscn")
