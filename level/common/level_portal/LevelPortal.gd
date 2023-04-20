extends Area2D

export(String, FILE, '*.tscn') var next_scene_path

func _ready():
	connect("body_entered", self, "_on_body_entered")


func _on_body_entered(body):
	if body.name == "Player":
		if get_tree().change_scene(next_scene_path) == OK:
			return
