extends Node2D

var projectile = preload("res://assets/ui/BattleMinigames/DodgeGame/projectile.tscn")
export(String, FILE, "*.json") var dodgeGameFile = "res://assets/ui/testBattle.json"
var projectilePattern = []
var currentPattern = 0 
var totalProjectiles = 0 
var projectilesHit = 0

var spawnCircleSize = 64;

# Called when the node enters the scene tree for the first time.
func _ready():
	show()
	projectilePattern = loadPattern()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	print($Timer.get_time_left())

func loadPattern():
	var file = File.new()
	if file.file_exists(dodgeGameFile ):
		file.open(dodgeGameFile, file.READ)
		return parse_json(file.get_as_text()) 

func handlePlayerHit():
	projectilesHit += 1
	$player.flashRed()

func _on_Timer_timeout():
#	print("placing stuff")
	
	placePattern()
	currentPattern += 1
	if currentPattern >= len(projectilePattern):
		win()
		return
	$Timer.start(projectilePattern[currentPattern]['wait'])

func placePattern():
	if 'projs' in projectilePattern[currentPattern]:
		var initAngle = 0
		var travelAngle = 0
		var projectiles = projectilePattern[currentPattern]['projs']
		for i in len(projectiles):
			if 'angle0' in projectiles[i]:
				initAngle = projectiles[i]['angle0']
			if 'dir' in projectiles[i]:
				travelAngle = projectiles[i]['dir']
			else:
				travelAngle = initAngle + 180
			var projInstance = projectile.instance()
			projInstance.rotation_degrees = travelAngle
			projInstance.position = getInitPosFromAngle(initAngle)
			projInstance.apply_impulse(Vector2(), Vector2(projInstance.speed, 0).rotated(deg2rad(travelAngle)))
			call_deferred("add_child", projInstance)
			totalProjectiles += 1

func getInitPosFromAngle(angle) : 
	var angleRad = deg2rad(angle)
	return Vector2(cos(angleRad) * spawnCircleSize, sin(angleRad) * spawnCircleSize)
 
func win():
	print(projectilesHit)
	print(totalProjectiles)
	pass
