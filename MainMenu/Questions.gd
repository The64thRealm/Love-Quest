extends LineEdit

const DialogBox = preload("res://assets/ui/DialogBox.gd")

onready var response_node: Label = self.get_parent().get_node("name")
func _ready():
	grab_focus()
	set_cursor_position(len(text))

func _on_Questions_text_entered(new_text):
	DialogBox.addFormatStrings("<name>", new_text)
	SceneTransition.change_scene("res://Favortiefood.tscn")
