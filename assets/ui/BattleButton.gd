extends Button
#export var reference_path = ""
export(bool) var start_focused = false

var addPatience = 0;
# var skipToLine = -1;

func _ready():
	if(start_focused):
		grab_focus()
		
	connect("mouse_entered",self,"_on_Button_mouse_entered")
#	connect("pressed",self,"_on_Button_Pressed")
	connect("pressed", get_node("../PatienceBar"), "addPatience", [addPatience])
	connect("pressed", get_node(".."), "advanceLine")

func setAddPatience(newAdd):
	disconnect("pressed", get_node("../PatienceBar"), "addPatience")
	addPatience = newAdd
	connect("pressed", get_node("../PatienceBar"), "addPatience", [addPatience])

func _on_Button_mouse_entered():
		grab_focus()
		  
#func _on_Button_Pressed():
#	pass
