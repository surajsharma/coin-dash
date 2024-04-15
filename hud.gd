extends CanvasLayer
signal start_game

var gameover = false

func update_score(value):
	$MarginContainer/Score.text = str(value)
	
func update_timer(value):
	$MarginContainer/Time.text = str(value)

func show_message(text):
	$Message.text = text
	$Message.show()
	$Timer.start()

func show_game_over():
	show_message("Game Over!")
	gameover = true

func _on_start_button_pressed():
	$StartButton.hide()
	$Message.hide()
	start_game.emit()

func _on_timer_timeout():
	if !gameover:
		$Message.hide()
	else:
		$StartButton.show()
		$StartButton.text = "Play again!"
