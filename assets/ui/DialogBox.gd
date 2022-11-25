extends Node2D

const formatStrings = {}

static func addFormatStrings(key, replacement) :
	formatStrings[key] = replacement

static func fillVariableDialogText(rawDialog) :
	for key in formatStrings :
		rawDialog = rawDialog.replace(key, formatStrings[key])
		# replaces keywords like <name> with the actual player name
	return rawDialog

const defaultFilePath = "res://assets/characters/"

export(String) var character
# the name of the folder where the character sprites will be accessed from
export(String, FILE, "*.json") var dialogFile = "res://assets/ui/testBattle.json"
# the file where the dialog will be read from
var lines = []
# list lines, will be populated after parsing the json
var currentLine = 0
export(Array, String) var buttons : Array = ["NinePatchRect/Choice1", "NinePatchRect/Choice2"]
# names of the button objects that will be used
var forceChoice = false
# variable that tells the game whether or not to force the player to press
# the buttons or use advance text using the interact button

# Called when the node enters the scene tree for the first time.
func _ready():
#	addFormatStrings("<name>", "Bob")
	play()
	currentLine = -1
	advanceLine()

func play():
	show()
	lines = loadDialog()

func advanceLine():
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
		endOfDialogReached()
		return true

func endOfDialogReached():
	hide()

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
				get_node(buttons[i]).text = fillVariableDialogText(actions[i]['actionText'])
			if 'skipToLine' in actions[i]:
				get_node(buttons[i]).skipToLine = actions[i]['skipToLine']
			else:
				get_node(buttons[i]).skipToLine = -1
	elif determineIfClearLine():
		for button in buttons:
			var buttonNode = get_node(button)
			buttonNode.skipToLine = -1
			buttonNode.text = ''
	else:
		forceChoice = false
		for button in buttons:
			get_node(button).skipToLine = -1
			get_node(button).text = ""
			get_node(button).hide()

func updateSprite(): 
	if 'character' in lines[currentLine]:
		character = lines[currentLine]['character']
	elif determineIfClearLine():
		character = ''
	if 'sprite' in lines[currentLine]:
		$sprite.texture = load(defaultFilePath + character + '/' + lines[currentLine]['sprite'] + ".png")
	elif determineIfClearLine():
		$sprite.texture = null

func show():
	self.visible = true

func hide():
	self.visible = false

func _input(event):
	if event.is_action_pressed("interact") and !forceChoice:
		advanceLine()

func loadDialog():
	var file = File.new()
	if file.file_exists(dialogFile):
		file.open(dialogFile, file.READ)
		return parse_json(file.get_as_text())


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
