extends Node2D

@onready var top_pipe := $TopPipe;
@onready var bottom_pipe := $BottomPipe;
@onready var scoring_area := $ScoringArea;

@export var pipe_speed := 7;

const PIPE_HEIGHT = 504;
const PIPE_WIDTH = 120;
var pipes_spacing = 200;

var can_move = true;

signal on_player_collided_with_pipe;
signal on_pipe_out_of_screen;
signal on_player_scored;

func _ready() -> void:
	set_random_height();
	
func _process(_delta: float) -> void:
	if (can_move):
		position.x -= pipe_speed;
	if (position.x < -PIPE_WIDTH):
		on_pipe_out_of_screen.emit();

func set_random_height() -> void:
	randomize();
	var top_position = 20 + randi() % 275;
	top_pipe.position.y = top_position - PIPE_HEIGHT;
	var bottom_position = top_pipe.position.y + pipes_spacing;
	bottom_pipe.position.y = bottom_position + PIPE_HEIGHT;

func reposition(x: int) -> void:
	position.x = x;
	set_random_height();

func _on_top_pipe_body_entered(_body: Node2D) -> void:
	died();

func _on_bottom_pipe_body_entered(_body: Node2D) -> void:
	died();
	
func died() -> void:
	on_player_collided_with_pipe.emit();

func _on_scoring_area_body_entered(_body: Node2D) -> void:
	on_player_scored.emit(); 
