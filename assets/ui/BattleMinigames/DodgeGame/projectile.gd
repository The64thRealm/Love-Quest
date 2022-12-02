extends RigidBody2D

var speed = 240
var hit = false

#func _ready():
#	 print("spawned")

func _physics_process(delta):
	if !hit :
		if $Area2D.overlaps_body(get_node("../player")) :
#			print("hit")
			hit = true
			get_node("..").handlePlayerHit()

func _on_VisibilityNotifier2D_viewport_exited(viewport):
#	print("outOfBounds") 
	yield(get_tree().create_timer(3), "timeout")
	queue_free()
