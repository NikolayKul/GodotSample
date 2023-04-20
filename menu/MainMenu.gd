extends Control

export(String, FILE, '*.tscn') var start_scene

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _on_StartButton_pressed():
	get_tree().change_scene(start_scene)


func _on_QuitButton_pressed():
	get_tree().quit()
