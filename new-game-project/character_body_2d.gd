extends CharacterBody2D

@export var speed: float = 100
@export var jump_force: float = -200
@export var gravity: float = 450

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta

	var direction := Input.get_axis("ui_left", "ui_right")
	velocity.x = direction * speed

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_force

	move_and_slide()

	_update_animation(direction)

func _update_animation(direction: float) -> void:
	if not is_on_floor():
		pass
	elif direction == 0:
		animated_sprite.play("Idle")
	else:
		animated_sprite.play("Run")

	if direction != 0:
		animated_sprite.flip_h = direction < 0

func _on_area_2d_body_entered(body: Node2D) -> void:
	get_tree().call_deferred("reload_current_scene")


func _on_area_2d_2_body_entered(body: Node2D) -> void:
	get_tree().change_scene_to_file("res://win_scene.tscn")
