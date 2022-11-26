extends "res://assets/ui/DialogButton.gd"

var addPatience = 0;

func _ready():
	._ready()
	dialogBoxPath = "../DialogBox"

func _on_Button_Pressed():
	._on_Button_Pressed()
	get_node("../PatienceBar").addPatience(addPatience)
