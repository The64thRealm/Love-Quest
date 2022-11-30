extends "res://assets/ui/DialogBox.gd"

#func _ready():
#	buttons = ["../TextureButton1", "../TextureButton1"]
#	play()
#	currentLine = -1
#	nextLine()

func battleWon():
	print("you won ig");
	hide()

func battleLost():
	print("you lost");
	hide()

func endOfDialogReached():
	battleWon()

func updatePatienceDecay():
	if 'patienceDecay' in lines[currentLine]:
		get_node("../PatienceBar").setDecay(lines[currentLine]['patienceDecay'])

func updateActionPatience():
	if 'clear' in lines:
		for button in buttons:
			get_node(button).addPatience = 0
	if 'actions' in lines: # will only be true at this point if actions exists in buttons
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
