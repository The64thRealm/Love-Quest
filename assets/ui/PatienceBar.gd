extends Node2D

export(Gradient) var barGradient

export(int) var decayPerSecond

signal outOfPatience

var patience

# Called when the node enters the scene tree for the first time.
func _ready():
	patience = $TextureProgress.max_value

func addPatience(add):
	patience += add

func setPatience(newPatience):
	patience = newPatience

func setDecay(decay):
	decayPerSecond = decay

func updateColor():
	$TextureProgress.tint_progress = barGradient.interpolate(patience / $TextureProgress.max_value)

func updateProgress(delta):
	patience -= delta * decayPerSecond
	print(delta * decayPerSecond)
	updateProgressDisplay()

func checkPatience():
	return patience <= $TextureProgress.min_value

func updateProgressDisplay():
	$TextureProgress.value = patience

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	updateProgress(delta)
	updateColor()
	if checkPatience():
		emit_signal("outOfPatience")
