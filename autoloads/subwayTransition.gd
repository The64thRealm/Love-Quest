extends CanvasLayer


func change_scene(target: String) -> void:
	$AnimationPlayer.play('dissolve')
	yield(get_tree().create_timer(17), "timeout")
	get_tree().change_scene(target)
	$AnimationPlayer.play_backwards('dissolve')
