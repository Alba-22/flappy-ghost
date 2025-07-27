extends Node2D

var game_started := false;
var game_over := false;
var player_score := 0;

@onready var player = $Player;
@onready var pipe_manager = $PipeManager;

func _ready() -> void:
	set_movements(false);

func _on_top_collider_body_entered(_body: Node2D) -> void:
	player_collided();

func _on_bottom_collider_body_entered(_body: Node2D) -> void:
	player_collided();
	
func _on_pipe_manager_on_player_collided() -> void:
	player_collided();

func _on_pipe_manager_on_player_scored() -> void:
	score_point();
	
func player_collided() -> void:
	game_over = true;
	set_movements(false);
	
func _process(delta: float) -> void:
	if (game_started == false):
		if Input.is_action_just_pressed("jump"):
			game_started = true;
			set_movements(true);
	if (game_over == true):
		if Input.is_action_just_pressed("restart"):
			call_deferred("restart_game");

func restart_game() -> void:
	get_tree().reload_current_scene();

func set_movements(can_move: bool) -> void:
	player.can_move = can_move;
	pipe_manager.set_pipe_movement(can_move);

func score_point() -> void:
	player_score += 1;
	if (player_score == 10):
		pipe_manager.update_game_speed(9);
	if (player_score == 30):
		pipe_manager.update_game_speed(11);
	if (player_score == 60):
		pipe_manager.update_game_speed(13);
	$%ScoreLabel.text = "Score: " + str(player_score);
