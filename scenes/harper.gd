extends KinematicBody2D


func idleDown():
	$AnimationPlayer.play('idle_down')
	
func idleUp():
	$AnimationPlayer.play('idle_up')
