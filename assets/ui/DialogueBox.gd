extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# var filePath = ""
export(String, FILE, "*.json") var dialogFile
var lines = []
var currentLine = 0
var typing_speed = 0.1
var read_time = 2
var current_message = 0
var display = ""
var current_char = 0


# Called when the node enters the scene tree for the first time.
func _ready(): 
	currentLine = -1
	play() 
	nextLine()

func play():
	show()
	#$NinePatchRect/Dialog.margin_right = $NinePatchRect.margin_right - 5
	#$NinePatchRect/Name.margin_right = $NinePatchRect.margin_right - 5
	#$NinePatchRect/Name.margin_bottom = $NinePatchRect.margin_bottom - 5
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
	current_message = 0
	display = ""
	current_char = 0
	var file = File.new()
	if file.file_exists(dialogFile):
		file.open(dialogFile, file.READ)
		return parse_json(file.get_as_text())


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
