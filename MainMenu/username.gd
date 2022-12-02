extends Label

const DialogBox = preload("res://assets/ui/DialogBox.gd")

func _ready():
	self.text = 'Hello ' + DialogBox.formatStrings["<name>"]
