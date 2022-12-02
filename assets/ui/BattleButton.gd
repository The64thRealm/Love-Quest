extends "res://assets/ui/DialogButton.gd"

var addPatience = 0;

func _ready():
	._ready()
	dialogBoxPath = "../DialogBox"

func _on_Button_Pressed():
	._on_Button_Pressed()
	get_node("../PatienceBar").addPatience(addPatience)

#func _on_Button_Pressed():
#	if reference_path != "":
#		get_tree().change_scene(reference_path)
#	if skipToLine < 0:
#		get_node(dialogBoxPath).nextLine()
#	else:
#		get_node(dialogBoxPath).skipToLine(skipToLine)
