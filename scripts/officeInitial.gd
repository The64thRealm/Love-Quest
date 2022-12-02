extends Node2D

var HEY = preload("res://audio/HEY.wav")
var script1Over = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var scriptNum = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	yield(get_tree().create_timer(0.2), "timeout")
	$AudioStreamPlayer2D.stream = HEY
	$AudioStreamPlayer2D.play()
	$Base/GUI/DialogBox.play()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if script1Over:
		$Sprite.position.x -= 5*delta
		$Sprite.modulate.a -= 0.25*delta

func _on_DialogBox_endReached():
	if scriptNum == 0:
		scriptNum += 1
		$AnimationPlayer.play("WalkLeft")
		script1Over = true
		yield(get_tree().create_timer(6), "timeout")
		
		script1Over = false
		$Sprite.hide()
		$Base/GUI/DialogBox.dialogFile = "res://assets/ui/dialogJsons/bossDialogInitialPart2.json"
		$Base/GUI/DialogBox.play()
	elif scriptNum == 1:
		OfficeTransition.change_scene("res://scenes/office.tscn")
