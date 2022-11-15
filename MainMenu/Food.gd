extends LineEdit

var template: String = 'So your favorite food is \n'
var t: String = '? Interesting...'
onready var response_node: Label = self.get_parent().get_node("foodname")

func _ready():
	grab_focus()
	set_cursor_position(len(text))




func _on_Food_text_entered(text1):
	response_node.show()
	response_node.text = template + text1 + t
	GLOBAL.typefood = text1
