extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# var filePath = ""
export(String, FILE, "*.json") var dialogFile
export(int) var boxX
export(int) var boxY
export(int) var boxWidth
export(int) var boxHeight

var lines = []
var currentLine = 0

# Called when the node enters the scene tree for the first time.
func _ready(): 
	currentLine = -1
	play() 
	nextLine()

func play():
	show()
	$NinePatchRect.margin_right = max(boxWidth, 10)
	$NinePatchRect.margin_bottom = max(boxHeight, 10)
	position.x = boxX
	position.y = boxY
	
	lines = loadDialog()

func nextLine():
	currentLine += 1
	
	if currentLine >= len(lines):
		hide()
		return
	$NinePatchRect/Name.text = lines[currentLine]['name']       
	$NinePatchRect/Dialog.text = lines[currentLine]['text']

func hide():
	$NinePatchRect.visible = false

func show():
	$NinePatchRect.visible = true

func _input(event):
	if event.is_action_pressed("interact"):
		nextLine()

func loadDialog():
	var file = File.new()
	if file.file_exists(dialogFile):
		file.open(dialogFile, file.READ)
		return parse_json(file.get_as_text())


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
