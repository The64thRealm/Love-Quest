extends KinematicBody2D

var can_move = true

func read_input():
	var velocity = Vector2.ZERO
	
	if Input.is_action_pressed("up"):
		velocity.y -= 1.0
		
	if Input.is_action_pressed("down"):
		velocity.y += 1.0
		
	if Input.is_action_pressed("left"):
		velocity.x -= 1.0
		
	if Input.is_action_pressed("right"):
		velocity.x += 1.0
		
	velocity = velocity.normalized()
	
	if velocity == Vector2.ZERO:
		$AnimationTree.get("parameters/playback").travel("Idle")
	else:
		$AnimationTree.get("parameters/playback").travel("Walk")
		$AnimationTree.set("parameters/Idle/blend_position", velocity)
		$AnimationTree.set("parameters/Walk/blend_position", velocity)
		move_and_slide(velocity * 80)
		
func _physics_process(delta):
	if can_move:
		read_input()
	
func idleDown():
	var velocity = Vector2.ZERO
	velocity.y += 1.0
	$AnimationTree.get("parameters/playback").travel("Idle")
	$AnimationTree.set("parameters/Idle/blend_position", velocity)
	
func idleUp():
	var velocity = Vector2.ZERO
	velocity.y -= 1.0
	$AnimationTree.get("parameters/playback").travel("Idle")
	$AnimationTree.set("parameters/Idle/blend_position", velocity)
	
func cantMove():
	$AnimationTree.get("parameters/playback").travel("Idle")
	can_move = false

func canMove():
	can_move = true
