extends Node2D

func _ready():
	$Timer.start()
	$subway.play()
	
	#if(test == false):
	#	get_tree().change_scene("res://scenes/city2.tscn")



func _on_Timer_timeout():
	get_tree().change_scene("res://scenes/city 2.tscn")
