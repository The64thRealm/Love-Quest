extends Node2D

var projectile = preload("res://assets/ui/BattleMinigames/DodgeGame/featherProjectile.png")
export(String, FILE, "*.json") var dodgeGameFile = "res://assets/ui/testBattle.json"
var projectilePattern = []
var currentPattern = -1 
var totalProjectiles = 0 
var projectilesHit = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	show()
	projectilePattern = loadPattern()   


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func loadPattern():
	var file = File.new()
	if file.file_exists(dodgeGameFile ):
		file.open(dodgeGameFile, file.READ)
		return parse_json(file.get_as_text()) 


func _on_Timer_timeout():
	placePattern()
	currentPattern += 1
	if currentPattern >= len(projectilePattern):
		win()
	$Timer.wait_time = projectilePattern['wait']

func placePattern():
	if 'projs' in projectilePattern:
		var initAngle = 0
		var travelAngle = 0
		var projectiles = projectilePattern['projs']
		for i in len(projectiles):
			if 'angle0' in projectiles[i]:
				initAngle = projectiles[i]['angle0']
			if 'dir' in projectiles[i]:
				travelAngle = projectiles[i]['dir']
			else:
				travelAngle = -initAngle
			var projInstance = projectile.instance()
			projInstance.rotation_degrees = travelAngle

func win():
	pass
