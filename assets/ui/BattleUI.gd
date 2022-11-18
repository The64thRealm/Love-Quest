extends Node2D
const DialogueBox = preload("DialogueBox.gd")

const defaultFilePath = "res://assets/characters/"

export(String) var character
export(String, FILE, "*.json") var battleFile = "res://assets/ui/testBattle.json"
var lines = []
var currentLine = 0 
var buttons = ["Action1", "Action2"]

# Called when the node enters the scene tree for the first time.
func _ready():
	play()
	currentLine = -1
	advanceLine()

func play():
	show()
	lines = loadBattle()

func advanceLine():
	currentLine += 1
	
	if currentLine >= len(lines):
		battleWon() 
		return
	
	updateUI()

func skipToLine(line):
	currentLine = line
	
	if currentLine >= len(lines):
		battleWon()
		return
	
	updateUI()

func updateUI():
	updateDialog()
	updatePatienceDecay()
	updateActions()
	updateSprite()

func determineIfClearLine():
	return 'clear' in lines[currentLine] and lines[currentLine]['clear']

func updateDialog():
	if 'text' in lines[currentLine]:
		$DialogBox/NinePatchRect/Dialog.text = DialogueBox.fillVariableDialogText(lines[currentLine]['text'])
	elif determineIfClearLine():
		$DialogBox/NinePatchRect/Dialog.text = ''
	if 'name' in lines[currentLine]:
		$DialogBox/NinePatchRect/Name.text = DialogueBox.fillVariableDialogText(lines[currentLine]['name'])
	elif determineIfClearLine():
		$DialogBox/NinePatchRect/Name.text = ''

func updatePatienceDecay():
	if 'patienceDecay' in lines[currentLine]:
		$PatienceBar.setDecay(lines[currentLine]['patienceDecay'])

func updateActions():
	if 'actions' in lines[currentLine]:
		var actions = lines[currentLine]['actions']
		for i in range(len(actions)):
			if 'actionText' in actions[i]:
				get_node(buttons[i]).text = DialogueBox.fillVariableDialogText(actions[i]['actionText'])
			if 'addPatience' in actions[i]:
				get_node(buttons[i]).addPatience = actions[i]['addPatience']
			if 'skipToLine' in actions[i]:
				get_node(buttons[i]).skipToLine = actions[i]['skipToLine']
			else:
				get_node(buttons[i]).skipToLine = -1
	elif determineIfClearLine():
		for button in buttons:
			get_node(button).skipToLine = -1
			get_node(button).addPatience = 0
			get_node(button).text = ''
	else:
		for button in buttons:
			get_node(button).skipToLine = -1

func updateSprite(): 
	if 'character' in lines[currentLine]:
		character = lines[currentLine]['character']
	elif determineIfClearLine():
		character = ''
	if 'enemySprite' in lines[currentLine]:
		 $EnemySprite.texture = load(defaultFilePath + character + '/' + lines[currentLine]['enemySprite'])
	elif determineIfClearLine():
		$EnemySprite.texture = load('')

func battleWon():
	print("you won ig");
	hide()

func battleLost():
	print("you lost");
	hide()
 
func show():
	self.visible = true

func hide():
	self.visible = false

#func _input(event):
#	if event.is_action_pressed("interact"):
#		nextLine()

func loadBattle():
	var file = File.new()
	if file.file_exists(battleFile):
		file.open(battleFile, file.READ)
		return parse_json(file.get_as_text())


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
