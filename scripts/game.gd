extends Node2D

var game_started := false;
var game_over := false;
var player_score := 0;

@onready var player = $Player;
@onready var pipe_manager = $PipeManager;
@onready var start_timer = $Timer;
@onready var timer_label = $TimerLabel;
@onready var score_label = $ScoreLabel;
@onready var gameover_overlay: Control = $GameOverOverlay

func _ready() -> void:
	set_movements(false);
	start_timer.start();
	gameover_overlay.hide();

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
	gameover_overlay.show();
	
func _process(_delta: float) -> void:
	if (game_started == false):
		var remaining_time = start_timer.time_left;
		timer_label.text = str(int(remaining_time + 1));
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
	score_label.text = "Score: " + str(player_score);


func _on_start_timer_timeout() -> void:
	game_started = true;
	timer_label.visible = false;
	set_movements(true);

func _on_restart_button_pressed() -> void:
	call_deferred("restart_game");
	gameover_overlay.hide();
