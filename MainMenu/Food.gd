extends LineEdit

const DialogBox = preload("res://assets/ui/DialogBox.gd")
var textEntered = false
var template: String = 'So your favorite food is \n'
var t: String = '? Interesting...'
onready var response_node: Label = self.get_parent().get_node("foodname")

func _ready():
	grab_focus()
	set_cursor_position(len(text))




func _on_Food_text_entered(text1):
	if !textEntered:
		textEntered = true
		response_node.show()
		response_node.text = template + text1 + t
		DialogBox.addFormatStrings("<food>", text1)
		editable = false
		yield(get_tree().create_timer(2), "timeout")
		OfficeTransition.change_scene("res://scenes/officeInitial.tscn")
