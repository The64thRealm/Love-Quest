extends Node
var endText = ""

func play_sound():
	$doorsfx.play()

func play_train():
	$train.play()

func play_boom():
	$vineboom.play()

func stop_music():
	$walkingHome.stop()
	$titleMusic.stop()
	$battle.stop()
	$endRoll.stop()

func play_music():
	stop_music()
	$walkingHome.play()
	
func play_title():
	stop_music()
	$titleMusic.play()

func play_battle():
	stop_music()
	$battle.play()

func play_end():
	stop_music()
	$endRoll.play()
