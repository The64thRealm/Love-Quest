extends "res://assets/ui/DialogBox.gd"

var patienceToAdd = 0

func _ready():
	buttons = ["../TextureButton1", "../TextureButton2"]
	play()
	currentLine = -1
	nextLine()

func battleWon():
	SFX.play_end()
	get_tree().change_scene("res://scenes/win.tscn")
	hide()

func battleLost():
	SFX.play_end()
	get_tree().change_scene("res://scenes/loss.tscn")
	hide()

func endOfDialogReached():
	battleWon()

func updatePatienceDecay():
	if 'patienceDecay' in lines[currentLine]:
		get_node("../PatienceBar").setDecay(lines[currentLine]['patienceDecay'])

func updateActionPatience():
	if 'clear' in lines[currentLine]:
		for button in buttons:
			get_node(button).addPatience = 0
	if 'actions' in lines[currentLine]: # will only be true at this point if actions exists in buttons
		var actions = lines[currentLine]['actions']
		for i in range(len(actions)):
			if 'addPatience' in actions[i]:
				get_node(buttons[i]).addPatience = actions[i]['addPatience']

func updateUI():
	updateDialog()
	updatePatienceDecay()
	updateActions()
	updateSprite()
	updateActionPatience()

func pause():
#	print(patienceToAdd)
	get_node("../PatienceBar").enabled = false
#	get_node("../PatienceBar").hide()
	for button in buttons:
#		get_node(button).hide()
		get_node(button).disabled = true
	enabled = false

func unpause():
	get_node("../PatienceBar").enabled = true
#	get_node("../PatienceBar").show()
	for button in buttons:
#		get_node(button).show()
		get_node(button).disabled = false
	enabled = true

func addPatience(percentage):
	var add = 0
	if patienceToAdd < 0:
		add = patienceToAdd * (percentage + 0.5)
	else:
		add = patienceToAdd * (1 - percentage)
	
	get_node("../PatienceBar").addPatience(add)
