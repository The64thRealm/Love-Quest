extends Node2D

var doneScroll = false


const credits = [
	{"name": "Walten Chan", "section": "Lead, Programming (battle, dialog)"},
	{"name": "Drew Castillo", "section": "Sound, Pixel Art (main), Map Design"},
	{"name": "Sofia Truong", "section": "Character Design, Art (main style)"},
	{"name": "Isabella Kenton", "section": "UI, Pixel Art"},
	{"name": "Natasha Wong", "section": "Programming (map progression)"},
	{"name": "Brianna Ha", "section": "Character Design, Art"},
	{"name": "Yuliana", "section": "Title Screen, Programming"},
	{"name": "Gabriela Moroyoqui", "section": "Writing"},
	{"name": "Joshua Pao", "section": "Pixel Art"}
]
#"You lost\nThe rift between you and Harper grows..."
#"These wonderful people made this game"
#"You've begun to understand Harper a little more"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	SFX.play_end()
	populateCredits()
	$TopText.text = SFX.endText

func populateCredits():
	$Credits/Names.text = ""
	$Credits/Sections.text = ""
	$Credits/Header.text = "Thanks to the wonderful people that made this game"
	for person in credits:
		$Credits/Names.text += person["name"] + "\n"
		$Credits/Sections.text += person["section"] + "\n"

func doneScrolling():
	doneScroll = true
	yield(get_tree().create_timer(10), "timeout")
	OfficeTransition.change_scene("res://MainMenu/TitleMenu.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $Credits.rect_position.y > 10:
		$Credits.rect_position.y -= delta * 100
		if $Credits.rect_position.y < 150:
			$TopText.rect_position.y -= delta * 100
	elif !doneScroll:
		doneScrolling()
