extends LineEdit
onready var response_node: Label = self.get_parent().get_node("name")
func _ready():
	grab_focus()
	set_cursor_position(len(text))

	

func _on_Questions_text_entered(new_text):
	GLOBAL.ans = new_text
	SceneTransition.change_scene("res://Favortiefood.tscn")


