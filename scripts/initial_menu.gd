extends Control

func _process(_delta: float) -> void:
	if (Input.is_action_just_pressed("jump")):
		go_to_game_scene();

func _on_button_pressed() -> void:
	go_to_game_scene();

func go_to_game_scene() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn");
