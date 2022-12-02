extends KinematicBody2D

var speed = 24000
var canMove = false

func read_input(delta):
	var velocity = Vector2.ZERO
	
	if Input.is_action_pressed("up"):
		velocity.y = -1.0
		
	if Input.is_action_pressed("down"):
		velocity.y = 1.0
		
	if Input.is_action_pressed("left"):
		velocity.x = -1.0
		
	if Input.is_action_pressed("right"):
		velocity.x = 1.0
		
	velocity = velocity.normalized() * speed
	
	if velocity == Vector2.ZERO:
		$AnimationTree.get("parameters/playback").travel("Idle")
	else:
		$AnimationTree.get("parameters/playback").travel("Walk")
		$AnimationTree.set("parameters/Idle/blend_position", velocity)
		$AnimationTree.set("parameters/Walk/blend_position", velocity)
		move_and_slide(velocity * delta)

func _physics_process(delta):
	if !canMove:
		move_and_slide(Vector2(100, 100))
		move_and_slide(Vector2(-100, -100))
		return
	read_input(delta)

func flashRed():
	$HitEffect.play(" hitBlink")
