extends "res://assets/ui/DialogButton.gd"

var addPatience = 0;
const defaultMinigamePath = "res://assets/ui/BattleMinigames/"
var pattern = ""
var battleMinigame

func _ready():
	._ready()
	dialogBoxPath = "../DialogBox"

func _on_Button_Pressed():
	if reference_path != "":
#		print(addPatience)
#		get_node("../PatienceBar").addPatience(addPatience)
		get_node(dialogBoxPath).patienceToAdd = addPatience
		get_node(dialogBoxPath).pause()
		print(defaultMinigamePath + reference_path + ".tscn")
		battleMinigame = load(defaultMinigamePath + reference_path + ".tscn").instance()
		battleMinigame.gameFile = defaultMinigamePath + pattern + ".json"
		battleMinigame.position = get_viewport().size / 2
		battleMinigame.scale *= 4
		battleMinigame.line = skipToLine
		get_node("..").call_deferred("add_child", battleMinigame)
#		updateDialogLine()
		return

	updateDialogLine()
	get_node("../PatienceBar").addPatience(addPatience)

#func _on_Button_Pressed():
#	if reference_path != "":
#		get_tree().change_scene(reference_path)
#	if skipToLine < 0:
#		get_node(dialogBoxPath).nextLine()
#	else:
#		get_node(dialogBoxPath).skipToLine(skipToLine)
