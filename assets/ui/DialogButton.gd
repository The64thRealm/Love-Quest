extends Button
export var reference_path = ""
export(bool) var start_focused = false

var skipToLine = -1
var dialogBoxPath = "../.."

func _ready():
	dialogBoxPath
	if(start_focused):
		grab_focus()
	connect("mouse_entered",self,"_on_Button_mouse_entered")
	connect("pressed",self,"_on_Button_Pressed")

func _on_Button_mouse_entered():
		grab_focus()
		  
func _on_Button_Pressed():
	if reference_path != "":
		get_tree().change_scene(reference_path)
	if skipToLine < 0:
		get_node(dialogBoxPath).advanceLine()
	else:
		get_node(dialogBoxPath).skipToLine(skipToLine)
#		skipToLine = -1
