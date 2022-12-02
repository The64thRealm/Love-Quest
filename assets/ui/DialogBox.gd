extends Control

const formatStrings = {}

static func addFormatStrings(key, replacement) :
	formatStrings[key] = replacement

static func fillVariableDialogText(rawDialog) :
	for key in formatStrings :
		rawDialog = rawDialog.replace(key, formatStrings[key])
		# replaces keywords like <name> with the actual player name
	return rawDialog

export(String, FILE, "*.json") var dialogFile = "res://assets/ui/testBattle.json"
# the file where the dialog will be read from
var lines = []
# list lines, will be populated after parsing the json
var currentLine = 0
var typing_speed = 0.1
var read_time = 2
var current_message = 0
var display = ""
var current_char = 0
var enabled = false
signal endReached

export(String) var character
# the name of the folder where the character sprites will be accessed from
export(Array, String) var buttons : Array = ["NinePatchRect/TextureButton1", "NinePatchRect/TextureButton2"]
# names of the button objects that will be used
var forceChoice = false
# variable that tells the game whether or not to force the player to press

const defaultFilePath = "res://assets/characters/"

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()


func play():
	enabled = true
	show()
	lines = loadDialog()
	currentLine = -1
	nextLine()

func nextLine():
	currentLine += 1
	
	if !checkOutOfBounds() :
		if 'skipToLine' in lines[currentLine - 1]:
			skipToLine(lines[currentLine - 1]['skipToLine'])
		updateUI()

func skipToLine(line):
	currentLine = line
	checkOutOfBounds()
	updateUI()

func checkOutOfBounds():
	if currentLine >= len(lines):
		enabled = false
		endOfDialogReached()
		return true

func endOfDialogReached():
	$sprite.texture = load("res://assets/ui/canGodotStopYellingAtMe.png")
	hide()
	emit_signal("endReached")

func updateUI():
	updateDialog()
	updateActions()
	updateSprite()

func determineIfClearLine():
	return 'clear' in lines[currentLine] and lines[currentLine]['clear']

func updateDialog():
	if 'text' in lines[currentLine]:
		$NinePatchRect/Dialog.text = fillVariableDialogText(lines[currentLine]['text'])
	elif determineIfClearLine():
		$NinePatchRect/Dialog.text = ''
	if 'name' in lines[currentLine]:
		$NinePatchRect/Name.text = fillVariableDialogText(lines[currentLine]['name'])
	elif determineIfClearLine():
		$NinePatchRect/Name.text = ''

func updateActions():
	if 'actions' in lines[currentLine]:
		forceChoice = true
		var actions = lines[currentLine]['actions']
		for i in range(len(actions)):
			get_node(buttons[i]).show()
			if 'actionText' in actions[i]:
				get_node(buttons[i]).setText(fillVariableDialogText(actions[i]['actionText']))
			if 'skipToLine' in actions[i]:
				get_node(buttons[i]).skipToLine = actions[i]['skipToLine']
			else:
				get_node(buttons[i]).skipToLine = -1
			if 'scene' in actions[i]:
				get_node(buttons[i]).reference_path = actions[i]['scene']
				get_node(buttons[i]).pattern = actions[i]['pattern']
			else:
				get_node(buttons[i]).reference_path = ""
				get_node(buttons[i]).pattern = ""
	elif determineIfClearLine():
		forceChoice = false
		for button in buttons:
			var buttonNode = get_node(button)
			buttonNode.skipToLine = -1
			buttonNode.setText("")
	else:
		forceChoice = false
		for button in buttons:
			get_node(button).skipToLine = -1
			get_node(button).setText("")
			get_node(button).hide()

func updateSprite(): 
	if 'character' in lines[currentLine]:
		character = lines[currentLine]['character']
	if 'sprite' in lines[currentLine]:
		$sprite.texture = load(defaultFilePath + character + '/' + lines[currentLine]['sprite'] + ".png")
	elif determineIfClearLine():
		$sprite.texture = null

func hide():
	$NinePatchRect.visible = false

func show():
	$NinePatchRect.visible = true

func _input(event):
	
	if event.is_action_pressed("interact"):
		if !enabled:
			return
		if forceChoice:
			return
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
