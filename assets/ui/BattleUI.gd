extends "res://assets/ui/DialogBox.gd"

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
		$PatienceBar.setDecay(lines[currentLine]['patienceDecay'])

#func updateButtonPatience():
#	if 'addPatience' in actions[i]:
#		get_node(buttons[i]).addPatience = actions[i]['addPatience']

func updateUI():
	updateDialog()
	updatePatienceDecay()
	updateActions()
	updateSprite()
