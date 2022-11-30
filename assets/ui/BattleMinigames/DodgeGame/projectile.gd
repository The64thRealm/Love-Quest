extends RigidBody2D

var speed = 100
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
	queue_free()
