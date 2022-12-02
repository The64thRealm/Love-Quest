extends Node2D

var projectile = preload("res://assets/ui/BattleMinigames/DodgeGame/projectile.tscn")
#export(String, FILE, "*.json") 
var gameFile = "res://assets/ui/BattleMinigames/DodgeGame/patterns/attackPattern1.json"
var projectilePattern = []
var currentPattern = 0 
var totalProjectiles = 0 
var projectilesHit = 0
var line = 0

var spawnCircleSize = 64
var wait = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("load in")
	show()
	projectilePattern = loadPattern()



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	print($Timer.get_time_left())

func loadPattern():
	var file = File.new()
	if file.file_exists(gameFile):
		file.open(gameFile, file.READ)
		return parse_json(file.get_as_text()) 

func handlePlayerHit():
	$hit.play()
	projectilesHit += 1
	$player.flashRed()

func _on_Timer_timeout():
	$player.canMove = true
#	print("placing stuff")
	
	placePattern()
	currentPattern += 1
	if currentPattern >= len(projectilePattern):
		$AnimationPlayer.play_backwards("load in")
		yield(get_tree().create_timer(2), "timeout")
		win()
		return
	if 'wait' in projectilePattern[currentPattern]:
		wait = projectilePattern[currentPattern]['wait']
	$Timer.start(wait)

func placePattern():
	if 'projs' in projectilePattern[currentPattern]:
		$shoot.play()
		var initAngle = 0
		var travelAngle = 0
		var along = 0
		var projectiles = projectilePattern[currentPattern]['projs']
		
		for i in len(projectiles):
			var projInstance = projectile.instance()
			if 'angle0' in projectiles[i]:
				initAngle = projectiles[i]['angle0']
				if 'dir' in projectiles[i]:
					travelAngle = projectiles[i]['dir']
				else:
					travelAngle = initAngle + 180
				projInstance.position = getInitPosFromAngle(initAngle)
			elif 'side' in projectiles[i]:
				if 'along' in projectiles[i]:
					along = projectiles[i]['along']
				else: 
					along = 0
				projInstance.position = getInitPosFromLoc(projectiles[i]['side'], along)
				
				if 'dir' in projectiles[i]:
					travelAngle = projectiles[i]['dir']
				else:
					travelAngle = getDirFromLoc(projectiles[i]['side'])

			projInstance.rotation_degrees = travelAngle
			projInstance.apply_impulse(Vector2(), Vector2(projInstance.speed, 0).rotated(deg2rad(travelAngle)))
			call_deferred("add_child", projInstance)
			totalProjectiles += 1

func getInitPosFromLoc(loc, along):
	if loc == 't':
		return Vector2(along * spawnCircleSize, -spawnCircleSize)
	elif loc == 'l':
		return Vector2(-spawnCircleSize, along * spawnCircleSize)
	elif loc == 'r':
		return Vector2(spawnCircleSize, -along * spawnCircleSize)
	else:
		return Vector2(-along * spawnCircleSize, spawnCircleSize)

func getDirFromLoc(loc):
	if loc == 't':
		return 90
	elif loc == 'l':
		return 0
	elif loc == 'r':
		return 180
	else:
		return -90

func getInitPosFromAngle(angle) : 
	var angleRad = deg2rad(angle)
	return Vector2(cos(angleRad) * spawnCircleSize, sin(angleRad) * spawnCircleSize)
 
func win():
	var percentage = float (projectilesHit) / totalProjectiles
	
	get_node("../DialogBox").unpause()
	get_node("../DialogBox").addPatience(percentage)
	if (line < 0):
		get_node("../DialogBox").nextLine()
	else:
		get_node("../DialogBox").skipToLine(line)
	self.queue_free()
