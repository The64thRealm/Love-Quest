extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const formatStrings = {}

static func addFormatStrings(key, replacement) :
	formatStrings[key] = replacement

static func fillVariableDialogText(rawDialog) :
	for key in formatStrings :
		rawDialog = rawDialog.replace(key, formatStrings[key])
	return rawDialog

# var filePath = ""
export(String, FILE, "*.json") var dialogFile = "res://assets/ui/testDialog.json"
var lines = []
var currentLine = 0

# Called when the node enters the scene tree for the first time.
func _ready(): 
	addFormatStrings('<name>', 'Bob')
	lines = loadDialog()
	currentLine = 0
	play()
	loadLine()

func play():
	show()
	$NinePatchRect/Dialog.margin_right = $NinePatchRect.margin_right - 5
	$NinePatchRect/Name.margin_right = $NinePatchRect.margin_right - 5
	$NinePatchRect/Name.margin_bottom = $NinePatchRect.margin_bottom - 5

func nextLine():
	currentLine += 1
	
	if currentLine >= len(lines) :
		hide()
		return
	loadLine()

func loadLine():
	if 'name' in lines[currentLine] :
		$NinePatchRect/Name.text = fillVariableDialogText(lines[currentLine]['name'])   
	if 'text' in lines[currentLine] :
		$NinePatchRect/Dialog.text = fillVariableDialogText(lines[currentLine]['text'])

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
