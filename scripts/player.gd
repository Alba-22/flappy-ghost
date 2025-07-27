extends CharacterBody2D

var jump_velocity := -350;

var can_move := false;

func _physics_process(delta: float) -> void:
	if (can_move == true):
		velocity += get_gravity() * delta;
		if Input.is_action_pressed("jump"):
			velocity.y = jump_velocity;
		move_and_collide(velocity * delta);
