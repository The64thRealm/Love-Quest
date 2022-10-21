extends Node2D

export(Gradient) var barGradient

export(float) var decayPerSecond

signal outOfPatience

const patienceTweening = 0.1

var patience
onready var progressBar = get_node("NinePatchRect/TextureProgress")

# Called when the node enters the scene tree for the first time.
func _ready():
	patience = progressBar.max_value
	progressBar.value = patience

func addPatience(add):
	patience += add

func setPatience(newPatience):
	patience = newPatience

func setDecay(decay):
	if (decay != 0):
		decayPerSecond = decay

func updateColor():
	progressBar.tint_progress = barGradient.interpolate(patience / progressBar.max_value)

func updateProgress(delta):
	patience -= delta * decayPerSecond
	var patienceMaxVal = progressBar.max_value
	var patienceMinVal = progressBar.min_value
	
#	bar cannot fill to max because of the constant decay, 2 lines below would make it fill to max and also not slow down near 0
#	patienceMaxVal = progressBar.max_value + decayPerSecond * 0.2
#	if decayPerSecond != 0:
#		patienceMinVal = progressBar.min_value - (10 / decayPerSecond)
	
	patience = clamp(patience, patienceMinVal, patienceMaxVal)
	updateProgressDisplay()

# lines below were for testing
func _input(event):
	if event.is_action_pressed("interact"):
		addPatience(-10)
	if event.is_action_pressed("right"):
		addPatience(10)

func checkPatience():
	return patience <= progressBar.min_value

func updateProgressDisplay():
	progressBar.value -= (progressBar.value - patience) * patienceTweening
	# progressBar.value = patience

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# print("progress: " + str(progressBar.value))
	# print("actual progress: " + str(patience))
	updateProgress(delta)
	updateColor()
	if checkPatience():
		# print("dead")
		emit_signal("outOfPatience")
