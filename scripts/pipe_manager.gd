extends Node2D

@onready var pipe1 = $PipeSet1;
@onready var pipe2 = $PipeSet2;
@onready var pipe3 = $PipeSet3;

signal on_player_collided;
signal on_player_scored;

func update_game_speed(new_speed: int) -> void:
	pipe1.pipe_speed = new_speed;
	pipe2.pipe_speed = new_speed;
	pipe3.pipe_speed = new_speed;

func set_pipe_movement(can_move: bool) -> void:
	pipe1.can_move = can_move;
	pipe2.can_move = can_move;
	pipe3.can_move = can_move;

func _on_pipe_set_1_on_pipe_out_of_screen() -> void:
	pipe1.reposition(1700);

func _on_pipe_set_1_on_player_collided_with_pipe() -> void:
	on_player_collided.emit();

func _on_pipe_set_1_on_player_scored() -> void:
	on_player_scored.emit();

func _on_pipe_set_2_on_pipe_out_of_screen() -> void:
	pipe2.reposition(1700);

func _on_pipe_set_2_on_player_collided_with_pipe() -> void:
	on_player_collided.emit();

func _on_pipe_set_2_on_player_scored() -> void:
	on_player_scored.emit();

func _on_pipe_set_3_on_pipe_out_of_screen() -> void:
	pipe3.reposition(1700);

func _on_pipe_set_3_on_player_collided_with_pipe() -> void:
	on_player_collided.emit();

func _on_pipe_set_3_on_player_scored() -> void:
	on_player_scored.emit();
