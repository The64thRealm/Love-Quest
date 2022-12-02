extends Node

func play_sound():
	$doorsfx.play()

func play_train():
	$train.play()

func play_boom():
	$vineboom.play()

func play_music():
	$walkingHome.play()
	
func stop_music():
	$walkingHome.stop()
